import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mobile_wash_control/utils/utils.dart';

import '../../entity/entity.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';
import '../../utils/download.dart' as dl;

// --- File tree model ---

class _TreeNode {
  final String name;
  final String fullPath; // empty for directories
  final bool isDir;
  final Map<String, _TreeNode> children;
  int size;

  _TreeNode({
    required this.name,
    this.fullPath = '',
    this.isDir = false,
    this.size = 0,
  }) : children = {};

  void insert(List<String> parts, String fullPath, int size) {
    if (parts.length == 1) {
      children[parts[0]] = _TreeNode(
        name: parts[0],
        fullPath: fullPath,
        isDir: false,
        size: size,
      );
    } else {
      final dir = parts[0];
      children.putIfAbsent(
        dir,
        () => _TreeNode(name: dir, isDir: true),
      );
      children[dir]!.insert(parts.sublist(1), fullPath, size);
    }
  }

  List<_TreeNode> get sortedChildren {
    final dirs = children.values.where((n) => n.isDir).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    final files = children.values.where((n) => !n.isDir).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
    return [...dirs, ...files];
  }
}

// --- Helpers ---

/// Parse "x;y" string into two doubles.
List<double> _parsePair(String? s) {
  if (s == null || !s.contains(';')) return [0, 0];
  final parts = s.split(';');
  return [
    double.tryParse(parts[0]) ?? 0,
    double.tryParse(parts[1]) ?? 0,
  ];
}

IconData _iconForItemType(String type) {
  switch (type) {
    case 'image':
    case 'image_array':
      return Icons.image_outlined;
    case 'digits':
      return Icons.tag;
    case 'text':
      return Icons.text_fields;
    case 'animation':
      return Icons.play_circle_outline;
    default:
      return Icons.widgets;
  }
}

IconData _iconForFile(String name) {
  if (name.endsWith('.lua')) return Icons.code;
  if (name.endsWith('.json')) return Icons.data_object;
  if (name.endsWith('.png') || name.endsWith('.jpg') || name.endsWith('.jpeg') || name.endsWith('.bmp')) {
    return Icons.image_outlined;
  }
  return Icons.insert_drive_file_outlined;
}

bool _isImageFile(String path) {
  return path.endsWith('.png') ||
      path.endsWith('.jpg') ||
      path.endsWith('.jpeg') ||
      path.endsWith('.bmp');
}

bool _isTextFile(String path) {
  return path.endsWith('.lua') || path.endsWith('.json') || path.endsWith('.txt') || path.endsWith('.ini');
}

// --- Page ---

class SkinEditorPage extends StatefulWidget {
  const SkinEditorPage({Key? key}) : super(key: key);

  @override
  State<SkinEditorPage> createState() => _SkinEditorPageState();
}

enum _ViewMode { none, screenPreview, codeEditor, imageViewer }

class _SkinEditorPageState extends State<SkinEditorPage> {
  List<SkinFileInfo>? _manifest;
  Map<String, dynamic>? _mainJson;
  _TreeNode? _fileTree;
  bool _loading = false;

  _ViewMode _viewMode = _ViewMode.none;
  String? _selectedPath;

  // Screen preview state
  List<dynamic>? _screenItems;
  Map<String, List<dynamic>> _screenItemsCache = {};
  Map<String, Uint8List> _loadedImages = {};

  // Screen selection & editing state
  String? _selectedItemId;
  bool _screenDirty = false;
  bool _screenSaving = false;

  // Image array animation
  Timer? _imageArrayTimer;
  int _imageArrayFrame = 0;

  // Code editor state
  final TextEditingController _codeController = TextEditingController();
  bool _codeDirty = false;
  bool _codeSaving = false;

  // Image viewer state
  List<int>? _imageBytes;

  Repository? _repository;
  String? _skinName;

  // Track expanded directories and screens
  final Set<String> _expandedDirs = {};
  final Set<String> _expandedScreens = {};

  // Vertical skin flag
  bool _isVertical = false;

  Future<void> _loadManifest() async {
    if (_repository == null || _skinName == null) return;
    setState(() => _loading = true);
    try {
      final manifest = await _repository!.getSkinManifest(_skinName!, context: context);
      List<int> mainJsonBytes = await _repository!.getSkinFile(_skinName!, 'main.json', context: context);
      Map<String, dynamic>? mainJson;
      if (mainJsonBytes.isNotEmpty) {
        try {
          mainJson = jsonDecode(utf8.decode(mainJsonBytes));
        } catch (_) {}
      }

      // Build file tree
      final root = _TreeNode(name: _skinName!, isDir: true);
      for (final f in manifest) {
        final parts = f.path.split('/');
        root.insert(parts, f.path, f.size);
      }

      // Check for _vertical flag file
      final isVertical = manifest.any((f) => f.path == '_vertical');

      setState(() {
        _manifest = manifest;
        _mainJson = mainJson;
        _fileTree = root;
        _isVertical = isVertical;
        // Expand root by default
        _expandedDirs.add('');
      });
    } finally {
      setState(() => _loading = false);
    }
  }

  List<Map<String, dynamic>> get _screens {
    if (_mainJson == null) return [];
    final screens = _mainJson!['screens'];
    if (screens is List) {
      return screens.cast<Map<String, dynamic>>();
    }
    return [];
  }

  void _onFileTap(String path) {
    if (_isImageFile(path)) {
      _selectImageFile(path);
    } else if (_isTextFile(path)) {
      _selectCodeFile(path);
    }
    // Other files: no action on tap, use Download button in toolbar
  }

  Future<void> _downloadFile(String path) async {
    final bytes = await _repository!.getSkinFile(_skinName!, path, context: context);
    if (bytes.isEmpty) return;
    final filename = path.split('/').last;
    await dl.downloadBytes(Uint8List.fromList(bytes), filename);
  }

  Future<void> _selectScreen(Map<String, dynamic> screen) async {
    final src = screen['src'] as String?;
    if (src == null) return;

    setState(() {
      _viewMode = _ViewMode.screenPreview;
      _selectedPath = src;
      _screenItems = null;
      _loadedImages = {};
      _selectedItemId = null;
      _screenDirty = false;
    });

    final bytes = await _repository!.getSkinFile(_skinName!, src, context: context);
    if (bytes.isEmpty) return;

    try {
      final screenJson = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      final items = screenJson['items'] as List<dynamic>?;

      // Collect all unique image paths from items
      final imagePaths = <String>{};
      if (items != null) {
        for (final item in items) {
          if (item is! Map<String, dynamic>) continue;
          final type = (item['type'] ?? '').toString();
          if (type == 'image' && item['src'] != null) {
            imagePaths.add(item['src'] as String);
          } else if (type == 'image_array' && item['sources'] is List) {
            // Load all frames of image_array
            for (final s in item['sources'] as List) {
              if (s is Map && s['src'] != null) {
                imagePaths.add(s['src'] as String);
              }
            }
          }
        }
      }

      // Load all images
      final images = <String, Uint8List>{};
      for (final path in imagePaths) {
        try {
          final imgBytes = await _repository!.getSkinFile(_skinName!, path, context: context);
          if (imgBytes.isNotEmpty) {
            images[path] = Uint8List.fromList(imgBytes);
          }
        } catch (_) {}
      }

      setState(() {
        _screenItems = items;
        if (items != null) _screenItemsCache[src] = items;
        _loadedImages = images;
      });
      _startImageArrayTimer();
    } catch (_) {}
  }

  Future<void> _selectCodeFile(String path) async {
    _stopImageArrayTimer();
    setState(() {
      _viewMode = _ViewMode.codeEditor;
      _selectedPath = path;
      _codeDirty = false;
      _codeController.text = '';
    });

    final bytes = await _repository!.getSkinFile(_skinName!, path, context: context);
    if (bytes.isNotEmpty) {
      setState(() {
        _codeController.text = utf8.decode(bytes, allowMalformed: true);
      });
    }
  }

  Future<void> _saveCode() async {
    if (_selectedPath == null) return;
    setState(() => _codeSaving = true);
    try {
      await _repository!.uploadSkinFile(
        _skinName!,
        _selectedPath!,
        utf8.encode(_codeController.text),
        context: context,
      );
      setState(() => _codeDirty = false);
    } finally {
      setState(() => _codeSaving = false);
    }
  }

  Future<void> _selectImageFile(String path) async {
    _stopImageArrayTimer();
    setState(() {
      _viewMode = _ViewMode.imageViewer;
      _selectedPath = path;
      _imageBytes = null;
    });

    final bytes = await _repository!.getSkinFile(_skinName!, path, context: context);
    if (bytes.isNotEmpty) {
      setState(() => _imageBytes = bytes);
    }
  }

  Future<void> _replaceImage() async {
    if (_selectedPath == null) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    List<int> bytes;
    if (file.bytes != null) {
      bytes = file.bytes!;
    } else if (file.path != null) {
      bytes = await File(file.path!).readAsBytes();
    } else {
      return;
    }

    await _repository!.uploadSkinFile(_skinName!, _selectedPath!, bytes, context: context);
    setState(() => _imageBytes = bytes);
  }

  void _startImageArrayTimer() {
    _imageArrayTimer?.cancel();
    _imageArrayFrame = 0;
    _imageArrayTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (_viewMode == _ViewMode.screenPreview && _screenItems != null) {
        setState(() => _imageArrayFrame++);
      }
    });
  }

  void _stopImageArrayTimer() {
    _imageArrayTimer?.cancel();
    _imageArrayTimer = null;
  }

  @override
  void dispose() {
    _stopImageArrayTimer();
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final initialArgs = ModalRoute.of(context)?.settings.arguments;

    if (!isArgsValid(initialArgs, context)) {
      return const SizedBox.shrink();
    }

    var args = initialArgs as Map<PageArgCode, dynamic>;
    _repository ??= args[PageArgCode.repository];
    _skinName ??= args[PageArgCode.skinName];

    if (_manifest == null && !_loading) {
      _loadManifest();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_skinName ?? 'Skin Editor'),
      ),
      body: _loading && _manifest == null
          ? const Center(child: CircularProgressIndicator())
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLeftPanel(),
                const VerticalDivider(width: 1),
                Expanded(child: _buildCenterPanel()),
                if (_viewMode == _ViewMode.screenPreview && _selectedItemId != null) ...[
                  const VerticalDivider(width: 1),
                  _buildPropertiesPanel(),
                ],
              ],
            ),
    );
  }

  // --- Left panel: file tree ---

  Widget _buildLeftPanel() {
    return SizedBox(
      width: 280,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
            children: [
              // SCREENS — scrollable, up to 60% of panel height
              if (_screens.isNotEmpty) ...[
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: constraints.maxHeight * 0.6),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    children: [
                      Container(
                        width: double.infinity,
                        color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Text(
                          'SCREENS',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                      ..._screens.expand((s) {
                        final id = s['id']?.toString() ?? '';
                        final src = s['src']?.toString() ?? '';
                        final isActive = _viewMode == _ViewMode.screenPreview && _selectedPath == src;
                        final isExpanded = _expandedScreens.contains(src);
                        final widgets = <Widget>[];

                        // Screen row
                        widgets.add(
                          InkWell(
                            onTap: () {
                              _selectScreen(s);
                            },
                            child: Container(
                              color: isActive ? Theme.of(context).primaryColor.withValues(alpha: 0.15) : null,
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                              child: Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (isExpanded) {
                                          _expandedScreens.remove(src);
                                        } else {
                                          _expandedScreens.add(src);
                                          if (!isActive) _selectScreen(s);
                                        }
                                      });
                                    },
                                    child: Icon(
                                      isExpanded ? Icons.expand_more : Icons.chevron_right,
                                      size: 16,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  Icon(Icons.screenshot_monitor, size: 16, color: isActive ? Theme.of(context).primaryColor : Colors.grey),
                                  const SizedBox(width: 6),
                                  Expanded(
                                    child: Text(id, style: TextStyle(fontSize: 13, fontWeight: isActive ? FontWeight.bold : FontWeight.normal)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                        // Component sub-tree — use cache so trees stay open across screen switches
                        final cachedItems = _screenItemsCache[src];
                        if (isExpanded && cachedItems != null) {
                          for (final item in cachedItems) {
                            if (item is! Map<String, dynamic>) continue;
                            final itemId = item['id']?.toString() ?? '';
                            final itemType = (item['type'] ?? '').toString();
                            final isItemSelected = isActive && _selectedItemId == itemId;
                            widgets.add(
                              InkWell(
                                onTap: () {
                                  if (!isActive) _selectScreen(s);
                                  setState(() => _selectedItemId = itemId);
                                },
                                child: Container(
                                  color: isItemSelected ? Colors.yellow.withValues(alpha: 0.2) : null,
                                  padding: const EdgeInsets.only(left: 44, top: 3, bottom: 3, right: 8),
                                  child: Row(
                                    children: [
                                      Icon(_iconForItemType(itemType), size: 14, color: isItemSelected ? Colors.orange.shade700 : Colors.grey.shade600),
                                      const SizedBox(width: 6),
                                      Expanded(
                                        child: Text(
                                          '$itemId ($itemType)',
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: isItemSelected ? FontWeight.bold : FontWeight.normal,
                                            color: isItemSelected ? Colors.orange.shade900 : null,
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }
                        }

                        return widgets;
                      }),
                    ],
                  ),
                ),
                const Divider(height: 1),
              ],
              // FILES header
              Container(
                width: double.infinity,
                color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Text(
                  'FILES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1,
                  ),
                ),
              ),
              // FILES — scrollable, takes remaining space
              Expanded(
                child: _fileTree == null
                    ? const SizedBox.shrink()
                    : ListView(
                        padding: EdgeInsets.zero,
                        children: _buildTreeNodes(_fileTree!, 0, ''),
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  List<Widget> _buildTreeNodes(_TreeNode node, int depth, String parentPath) {
    final widgets = <Widget>[];
    for (final child in node.sortedChildren) {
      final path = parentPath.isEmpty ? child.name : '$parentPath/${child.name}';
      if (child.isDir) {
        final isExpanded = _expandedDirs.contains(path);
        widgets.add(
          InkWell(
            onTap: () {
              setState(() {
                if (isExpanded) {
                  _expandedDirs.remove(path);
                } else {
                  _expandedDirs.add(path);
                }
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: 8.0 + depth * 16.0, top: 2, bottom: 2),
              child: Row(
                children: [
                  Icon(
                    isExpanded ? Icons.expand_more : Icons.chevron_right,
                    size: 16,
                    color: Colors.grey.shade600,
                  ),
                  Icon(
                    isExpanded ? Icons.folder_open : Icons.folder,
                    size: 16,
                    color: Colors.amber.shade700,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      child.name,
                      style: const TextStyle(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
        if (isExpanded) {
          widgets.addAll(_buildTreeNodes(child, depth + 1, path));
        }
      } else {
        final isSelected = _selectedPath == child.fullPath &&
            (_viewMode == _ViewMode.codeEditor || _viewMode == _ViewMode.imageViewer);
        widgets.add(
          InkWell(
            onTap: () => _onFileTap(child.fullPath),
            child: Container(
              color: isSelected ? Theme.of(context).primaryColor.withValues(alpha: 0.15) : null,
              padding: EdgeInsets.only(left: 28.0 + depth * 16.0, top: 3, bottom: 3, right: 8),
              child: Row(
                children: [
                  Icon(_iconForFile(child.name), size: 16, color: Colors.grey.shade600),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      child.name,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }
    }
    return widgets;
  }

  // --- Center panel ---

  Widget _buildCenterPanel() {
    switch (_viewMode) {
      case _ViewMode.screenPreview:
        return _buildScreenPreview();
      case _ViewMode.codeEditor:
        return _buildCodeEditor();
      case _ViewMode.imageViewer:
        return _buildImageViewer();
      case _ViewMode.none:
        return Center(
          child: Text(
            'Select a screen or file',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.grey),
          ),
        );
    }
  }

  Widget _buildScreenPreview() {
    if (_screenItems == null) {
      return const Center(child: CircularProgressIndicator());
    }

    // Detect orientation from main.json or first background item
    double canvasW = 1920;
    double canvasH = 1080;
    final resolution = _mainJson?['resolution'] as String?;
    if (resolution != null && resolution.contains('x')) {
      final rp = resolution.split('x');
      canvasW = double.tryParse(rp[0]) ?? 1920;
      canvasH = double.tryParse(rp[1]) ?? 1080;
    }

    return LayoutBuilder(builder: (context, constraints) {
      // If vertical, the displayed dimensions are swapped (rotated 90° CW)
      final displayW = _isVertical ? canvasH : canvasW;
      final displayH = _isVertical ? canvasW : canvasH;
      final scaleX = constraints.maxWidth / displayW;
      final scaleY = constraints.maxHeight / displayH;
      final scale = scaleX < scaleY ? scaleX : scaleY;

      Widget canvas = GestureDetector(
        onTap: () {
          // Clicking empty area deselects
          setState(() => _selectedItemId = null);
        },
        child: Container(
          width: canvasW * scale,
          height: canvasH * scale,
          decoration: BoxDecoration(
            color: Colors.black,
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Stack(
            children: [
              ..._screenItems!.where((item) => item is Map<String, dynamic>).map((item) {
                    final m = item as Map<String, dynamic>;
                    final posStr = m['position']?.toString();
                    final sizeStr = m['size']?.toString();
                    final type = (m['type'] ?? '').toString();
                    final id = m['id']?.toString() ?? '';
                    final visibleStr = (m['visible'] ?? 'true').toString();
                    final visible = visibleStr != 'false' && visibleStr != '0';
                    final isSelected = _selectedItemId == id;
                    final itemOpacity = visible ? 1.0 : 0.5;

                    final pos = _parsePair(posStr);
                    double x = pos[0];
                    double y = pos[1];
                    double w = 0;
                    double h = 0;

                    if (sizeStr != null) {
                      final sz = _parsePair(sizeStr);
                      w = sz[0];
                      h = sz[1];
                    }

                    // For digits type, compute size from symbol_size and length
                    if (type == 'digits' && w == 0 && h == 0) {
                      final symSize = _parsePair(m['symbol_size']?.toString());
                      final length = int.tryParse(m['length']?.toString() ?? '1') ?? 1;
                      final itemVertical = (m['is_vertical'] ?? '').toString();
                      if (itemVertical == '1' || itemVertical == 'true') {
                        w = symSize[0];
                        h = symSize[1] * length;
                      } else {
                        w = symSize[0] * length;
                        h = symSize[1];
                      }
                    }

                    if (w <= 0 || h <= 0) return const SizedBox.shrink();

                    // Resolve image src for image/image_array types
                    String? imgSrc;
                    if (type == 'image') {
                      imgSrc = m['src'] as String?;
                    } else if (type == 'image_array' && m['sources'] is List) {
                      final sources = m['sources'] as List;
                      if (sources.isNotEmpty) {
                        final frameIndex = _imageArrayFrame % sources.length;
                        final s = sources[frameIndex];
                        if (s is Map && s['src'] != null) {
                          imgSrc = s['src'] as String;
                        }
                      }
                    }

                    // Selection highlight border
                    final selectionDecoration = isSelected
                        ? BoxDecoration(border: Border.all(color: Colors.yellow, width: 2))
                        : null;

                    // If we have a loaded image, render it
                    if (imgSrc != null && _loadedImages.containsKey(imgSrc)) {
                      return Positioned(
                        left: x * scale,
                        top: y * scale,
                        width: w * scale,
                        height: h * scale,
                        child: Opacity(
                          opacity: itemOpacity,
                          child: GestureDetector(
                            onTap: () {
                              setState(() => _selectedItemId = id);
                            },
                            child: Container(
                              decoration: selectionDecoration,
                              child: Tooltip(
                                message: '$id ($type)\n$imgSrc\n${w.toInt()}x${h.toInt()} @ ${x.toInt()},${y.toInt()}',
                                child: Image.memory(
                                  _loadedImages[imgSrc]!,
                                  fit: BoxFit.fill,
                                  gaplessPlayback: true,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }

                    // Fallback: colored rectangle for non-image items
                    Color color;
                    switch (type) {
                      case 'image':
                        color = Colors.blue.withValues(alpha: 0.3);
                        break;
                      case 'text':
                        color = Colors.green.withValues(alpha: 0.3);
                        break;
                      case 'digits':
                        color = Colors.cyan.withValues(alpha: 0.3);
                        break;
                      case 'animation':
                        color = Colors.orange.withValues(alpha: 0.3);
                        break;
                      default:
                        color = Colors.purple.withValues(alpha: 0.3);
                    }

                    return Positioned(
                      left: x * scale,
                      top: y * scale,
                      width: w * scale,
                      height: h * scale,
                      child: Opacity(
                        opacity: itemOpacity,
                        child: GestureDetector(
                          onTap: () {
                            setState(() => _selectedItemId = id);
                          },
                          child: Tooltip(
                            message: '$id ($type)\n${w.toInt()}x${h.toInt()} @ ${x.toInt()},${y.toInt()}',
                            child: Container(
                              decoration: BoxDecoration(
                                color: color,
                                border: isSelected
                                    ? Border.all(color: Colors.yellow, width: 2)
                                    : Border.all(color: color.withValues(alpha: 0.8), width: 1),
                              ),
                            child: Center(
                              child: RotatedBox(
                                quarterTurns: _isVertical ? 3 : 0,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Padding(
                                    padding: const EdgeInsets.all(2),
                                    child: Text(
                                      id,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        shadows: const [Shadow(blurRadius: 2, color: Colors.black)],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          );

      // Rotate 90° clockwise for vertical skins
      if (_isVertical) {
        canvas = RotatedBox(quarterTurns: 1, child: canvas);
      }

      return SingleChildScrollView(
        child: Center(child: canvas),
      );
    });
  }

  // --- Properties panel ---

  String _formatScreenJson(List<dynamic> items) {
    final buf = StringBuffer();
    buf.writeln('{');
    buf.writeln('  "items": [');
    for (var i = 0; i < items.length; i++) {
      final item = items[i];
      if (item is! Map<String, dynamic>) continue;
      buf.writeln('    {');
      final keys = item.keys.toList();
      for (var k = 0; k < keys.length; k++) {
        final key = keys[k];
        final val = item[key];
        final comma = k < keys.length - 1 ? ',' : '';
        if (key == 'sources' && val is List) {
          // Format sources array with each object on its own lines
          buf.writeln('      "sources": [');
          for (var s = 0; s < val.length; s++) {
            final src = val[s];
            final srcComma = s < val.length - 1 ? ',' : '';
            if (src is Map) {
              buf.writeln('      {');
              final srcKeys = src.keys.toList();
              for (var sk = 0; sk < srcKeys.length; sk++) {
                final sKey = srcKeys[sk];
                final sVal = src[sKey]?.toString().replaceAll('\\', '\\\\').replaceAll('"', '\\"') ?? '';
                final skComma = sk < srcKeys.length - 1 ? ',' : '';
                buf.writeln('        "$sKey":"$sVal"$skComma');
              }
              buf.writeln('      }$srcComma');
            } else {
              buf.writeln('      ${jsonEncode(src)}$srcComma');
            }
          }
          buf.writeln('      ]$comma');
        } else if (val is List || val is Map) {
          final encoded = jsonEncode(val);
          buf.writeln('      "$key":$encoded$comma');
        } else {
          final escaped = val.toString().replaceAll('\\', '\\\\').replaceAll('"', '\\"');
          buf.writeln('      "$key":"$escaped"$comma');
        }
      }
      final itemComma = i < items.length - 1 ? ',' : '';
      buf.writeln('    }$itemComma');
    }
    buf.writeln('  ]');
    buf.write('}');
    return buf.toString();
  }

  Future<void> _saveScreenItems() async {
    if (_selectedPath == null || _screenItems == null) return;
    setState(() => _screenSaving = true);
    try {
      final json = _formatScreenJson(_screenItems!);
      await _repository!.uploadSkinFile(
        _skinName!,
        _selectedPath!,
        utf8.encode(json),
        context: context,
      );
      setState(() => _screenDirty = false);
    } finally {
      setState(() => _screenSaving = false);
    }
  }

  Widget _buildPropertiesPanel() {
    final item = _screenItems?.firstWhere(
      (i) => i is Map<String, dynamic> && i['id'] == _selectedItemId,
      orElse: () => null,
    );

    if (item is! Map<String, dynamic>) {
      return const SizedBox(width: 300);
    }

    final m = item;
    // Keys to display: id and type first (read-only), then rest
    const readOnlyKeys = {'id', 'type'};
    final allKeys = m.keys.toList();

    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text(
                  'PROPERTIES',
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                    letterSpacing: 1,
                  ),
                ),
                const Spacer(),
                if (_screenDirty)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.orange.shade100,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Modified',
                      style: TextStyle(color: Colors.orange.shade800, fontSize: 11),
                    ),
                  ),
              ],
            ),
          ),
          const Divider(height: 1),
          // Properties list
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(8),
              children: [
                for (final key in allKeys) ...[
                  if (key == 'sources')
                    _buildSourcesRow(m['sources'])
                  else if (readOnlyKeys.contains(key))
                    _buildReadOnlyRow(key, m[key]?.toString() ?? '')
                  else if (key == 'visible')
                    _buildBoolRow(key, m[key]?.toString() ?? 'true', (newValue) {
                      setState(() {
                        m[key] = newValue;
                        _screenDirty = true;
                      });
                    })
                  else if (key == 'position' || key == 'size' || key == 'symbol_size')
                    _buildPairRow(key, m[key]?.toString() ?? '0;0', (newValue) {
                      setState(() {
                        m[key] = newValue;
                        _screenDirty = true;
                      });
                    })
                  else if (key == 'src' && (m['type'] == 'image' || m['type'] == 'image_array'))
                    _buildImageSrcRow(key, m[key]?.toString() ?? '', (newValue) {
                      setState(() {
                        m[key] = newValue;
                        _screenDirty = true;
                      });
                    })
                  else
                    _buildEditableRow(key, m[key]?.toString() ?? '', (newValue) {
                      setState(() {
                        m[key] = newValue;
                        _screenDirty = true;
                      });
                    }),
                ],
              ],
            ),
          ),
          // Save button
          Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _screenSaving || !_screenDirty ? null : _saveScreenItems,
                icon: _screenSaving
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.save, size: 18),
                label: const Text('Save'),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReadOnlyRow(String key, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(
              key,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableRow(String key, String value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              key,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
          ),
          Expanded(
            child: TextFormField(
              key: ValueKey('$_selectedItemId-$key'),
              initialValue: value,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                border: OutlineInputBorder(),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPairRow(String key, String value, ValueChanged<String> onChanged) {
    final parts = _parsePair(value);
    final labelX = (key == 'position') ? 'x' : (key == 'size' ? 'w' : 'x');
    final labelY = (key == 'position') ? 'y' : (key == 'size' ? 'h' : 'y');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(key, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ),
          Text(labelX, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(width: 2),
          SizedBox(
            width: 60,
            child: TextFormField(
              key: ValueKey('$_selectedItemId-$key-x'),
              initialValue: parts[0].toInt().toString(),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                final x = v.isEmpty ? '0' : v;
                onChanged('$x;${parts[1].toInt()}');
              },
            ),
          ),
          const SizedBox(width: 8),
          Text(labelY, style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
          const SizedBox(width: 2),
          SizedBox(
            width: 60,
            child: TextFormField(
              key: ValueKey('$_selectedItemId-$key-y'),
              initialValue: parts[1].toInt().toString(),
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 13),
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                border: OutlineInputBorder(),
              ),
              onChanged: (v) {
                final y = v.isEmpty ? '0' : v;
                onChanged('${parts[0].toInt()};$y');
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBoolRow(String key, String value, ValueChanged<String> onChanged) {
    final current = (value == 'false' || value == '0') ? 'false' : 'true';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 90,
            child: Text(key, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ),
          Expanded(
            child: DropdownButtonFormField<String>(
              key: ValueKey('$_selectedItemId-$key'),
              initialValue: current,
              isDense: true,
              decoration: const InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                border: OutlineInputBorder(),
              ),
              style: const TextStyle(fontSize: 13, color: Colors.black),
              items: const [
                DropdownMenuItem(value: 'true', child: Text('true')),
                DropdownMenuItem(value: 'false', child: Text('false')),
              ],
              onChanged: (v) {
                if (v != null) onChanged(v);
              },
            ),
          ),
        ],
      ),
    );
  }

  List<String> get _imageFilePaths {
    if (_manifest == null) return [];
    return _manifest!
        .where((f) => _isImageFile(f.path))
        .map((f) => f.path)
        .toList()
      ..sort();
  }

  Widget _buildImageSrcRow(String key, String value, ValueChanged<String> onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(key, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
          ),
          Expanded(
            child: TextFormField(
              key: ValueKey('$_selectedItemId-$key'),
              initialValue: value,
              style: const TextStyle(fontSize: 13),
              decoration: InputDecoration(
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.folder_open, size: 18),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(maxWidth: 30, maxHeight: 30),
                  onPressed: () => _showImagePicker(value, onChanged),
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  /// Build a map of folder -> list of image paths in that folder.
  Map<String, List<String>> get _imageFolders {
    final result = <String, List<String>>{};
    for (final path in _imageFilePaths) {
      final slash = path.lastIndexOf('/');
      final folder = slash >= 0 ? path.substring(0, slash) : '';
      result.putIfAbsent(folder, () => []).add(path);
    }
    return result;
  }

  /// Get unique sorted folder paths that contain images.
  List<String> get _imageFolderList {
    final folders = _imageFolders.keys.toList()..sort();
    return folders;
  }

  /// Determine the starting folder from a src value. Falls back to first available folder.
  String _startingFolder(String currentSrc) {
    final slash = currentSrc.lastIndexOf('/');
    if (slash >= 0) {
      final folder = currentSrc.substring(0, slash);
      if (_imageFolders.containsKey(folder)) return folder;
    }
    // Fallback: first folder that has images, or empty
    final folders = _imageFolderList;
    return folders.isNotEmpty ? folders.first : '';
  }

  void _showImagePicker(String currentValue, ValueChanged<String> onChanged) {
    final folders = _imageFolderList;
    final folderContents = _imageFolders;
    final startFolder = _startingFolder(currentValue);

    showDialog(
      context: context,
      builder: (ctx) {
        String selectedFolder = startFolder;
        String? hoveredPath = currentValue;
        Uint8List? previewBytes;
        bool previewLoading = false;

        // Try to load initial preview
        if (_loadedImages.containsKey(currentValue)) {
          previewBytes = _loadedImages[currentValue];
        }

        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            final images = folderContents[selectedFolder] ?? [];

            void loadPreview(String path) {
              if (_loadedImages.containsKey(path)) {
                setDialogState(() {
                  hoveredPath = path;
                  previewBytes = _loadedImages[path];
                  previewLoading = false;
                });
              } else {
                setDialogState(() {
                  hoveredPath = path;
                  previewBytes = null;
                  previewLoading = true;
                });
                _repository!.getSkinFile(_skinName!, path, context: context).then((bytes) {
                  if (bytes.isNotEmpty) {
                    final data = Uint8List.fromList(bytes);
                    _loadedImages[path] = data;
                    setDialogState(() {
                      previewBytes = data;
                      previewLoading = false;
                    });
                  } else {
                    setDialogState(() => previewLoading = false);
                  }
                });
              }
            }

            return AlertDialog(
              title: const Text('Select image'),
              contentPadding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              content: SizedBox(
                width: 700,
                height: 500,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Left: folder tree
                    SizedBox(
                      width: 160,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ListView.builder(
                          itemCount: folders.length,
                          itemBuilder: (ctx, i) {
                            final folder = folders[i];
                            final displayName = folder.isEmpty ? '(root)' : folder;
                            final isSel = folder == selectedFolder;
                            return InkWell(
                              onTap: () => setDialogState(() => selectedFolder = folder),
                              child: Container(
                                color: isSel ? Theme.of(context).primaryColor.withValues(alpha: 0.15) : null,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                                child: Row(
                                  children: [
                                    Icon(Icons.folder, size: 16, color: Colors.amber.shade700),
                                    const SizedBox(width: 4),
                                    Expanded(
                                      child: Text(
                                        displayName,
                                        style: TextStyle(fontSize: 12, fontWeight: isSel ? FontWeight.bold : FontWeight.normal),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Center: image list in current folder
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ListView.builder(
                          itemCount: images.length,
                          itemBuilder: (ctx, i) {
                            final path = images[i];
                            final filename = path.split('/').last;
                            final isSel = path == hoveredPath;
                            return InkWell(
                              onTap: () => loadPreview(path),
                              onDoubleTap: () {
                                onChanged(path);
                                Navigator.of(ctx).pop();
                              },
                              child: Container(
                                color: isSel ? Colors.blue.withValues(alpha: 0.12) : null,
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                child: Row(
                                  children: [
                                    _loadedImages.containsKey(path)
                                        ? SizedBox(
                                            width: 24,
                                            height: 24,
                                            child: Image.memory(_loadedImages[path]!, fit: BoxFit.contain),
                                          )
                                        : Icon(Icons.image_outlined, size: 20, color: Colors.grey.shade500),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        filename,
                                        style: TextStyle(fontSize: 12, fontWeight: isSel ? FontWeight.bold : FontWeight.normal),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Right: preview
                    SizedBox(
                      width: 200,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey.shade300),
                          borderRadius: BorderRadius.circular(4),
                          color: Colors.grey.shade100,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: previewLoading
                                  ? const Center(child: CircularProgressIndicator(strokeWidth: 2))
                                  : previewBytes != null
                                      ? Padding(
                                          padding: const EdgeInsets.all(8),
                                          child: Image.memory(previewBytes!, fit: BoxFit.contain, gaplessPlayback: true),
                                        )
                                      : Center(
                                          child: Text('No preview', style: TextStyle(color: Colors.grey.shade500, fontSize: 12)),
                                        ),
                            ),
                            if (hoveredPath != null)
                              Padding(
                                padding: const EdgeInsets.all(6),
                                child: Text(
                                  hoveredPath!.split('/').last,
                                  style: const TextStyle(fontSize: 11),
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: hoveredPath != null && hoveredPath != currentValue
                      ? () {
                          onChanged(hoveredPath!);
                          Navigator.of(ctx).pop();
                        }
                      : null,
                  child: const Text('Select'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _confirmDeleteSource(List sources, int index) async {
    final src = sources[index] is Map ? (sources[index]['src']?.toString() ?? '[$index]') : '[$index]';
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete source'),
        content: Text('Delete "$src"?'),
        actions: [
          TextButton(onPressed: () => Navigator.of(ctx).pop(false), child: const Text('Cancel')),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      setState(() {
        sources.removeAt(index);
        _screenDirty = true;
      });
    }
  }

  Widget _buildSourcesRow(dynamic sources) {
    if (sources is! List) {
      return _buildReadOnlyRow('sources', '(none)');
    }
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: const EdgeInsets.only(left: 8),
      title: Row(
        children: [
          Text(
            'sources (${sources.length})',
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const Spacer(),
          SizedBox(
            width: 24,
            height: 24,
            child: IconButton(
              icon: const Icon(Icons.add, size: 16),
              padding: EdgeInsets.zero,
              tooltip: 'Add source',
              onPressed: () {
                _showImagePicker('', (newPath) {
                  setState(() {
                    sources.add({'src': newPath});
                    _screenDirty = true;
                  });
                });
              },
            ),
          ),
        ],
      ),
      children: [
        ReorderableListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          buildDefaultDragHandles: false,
          itemCount: sources.length,
          onReorder: (oldIndex, newIndex) {
            setState(() {
              if (newIndex > oldIndex) newIndex--;
              final item = sources.removeAt(oldIndex);
              sources.insert(newIndex, item);
              _screenDirty = true;
            });
          },
          itemBuilder: (ctx, i) {
            final srcValue = sources[i] is Map ? (sources[i]['src']?.toString() ?? '') : sources[i].toString();
            return Padding(
              key: ValueKey('$_selectedItemId-sources-reorder-$i-$srcValue'),
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  ReorderableDragStartListener(
                    index: i,
                    child: Icon(Icons.drag_handle, size: 16, color: Colors.grey.shade400),
                  ),
                  const SizedBox(width: 2),
                  SizedBox(
                    width: 20,
                    child: Text('$i', style: TextStyle(fontSize: 11, color: Colors.grey.shade500)),
                  ),
                  Expanded(
                    child: TextFormField(
                      key: ValueKey('$_selectedItemId-sources-$i-$srcValue'),
                      initialValue: srcValue,
                      style: const TextStyle(fontSize: 12),
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.folder_open, size: 16),
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(maxWidth: 28, maxHeight: 28),
                          onPressed: () {
                            final currentSrc = sources[i] is Map ? (sources[i]['src']?.toString() ?? '') : '';
                            _showImagePicker(currentSrc, (newPath) {
                              setState(() {
                                if (sources[i] is Map) {
                                  sources[i]['src'] = newPath;
                                } else {
                                  sources[i] = {'src': newPath};
                                }
                                _screenDirty = true;
                              });
                            });
                          },
                        ),
                      ),
                      onChanged: (v) {
                        if (sources[i] is Map) {
                          sources[i]['src'] = v;
                        } else {
                          sources[i] = {'src': v};
                        }
                        _screenDirty = true;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 28,
                    height: 28,
                    child: IconButton(
                      icon: Icon(Icons.close, size: 14, color: Colors.red.shade300),
                      padding: EdgeInsets.zero,
                      tooltip: 'Delete',
                      onPressed: () => _confirmDeleteSource(sources, i),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCodeEditor() {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(_iconForFile(_selectedPath ?? ''), size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _selectedPath ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              if (_codeDirty)
                Container(
                  margin: const EdgeInsets.only(right: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.orange.shade100,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'Modified',
                    style: TextStyle(color: Colors.orange.shade800, fontSize: 11),
                  ),
                ),
              ElevatedButton.icon(
                onPressed: () {
                  final filename = (_selectedPath ?? 'file').split('/').last;
                  dl.downloadBytes(
                    Uint8List.fromList(utf8.encode(_codeController.text)),
                    filename,
                  );
                },
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Download'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _codeSaving ? null : _saveCode,
                icon: _codeSaving
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.save, size: 18),
                label: const Text('Save'),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: TextField(
            controller: _codeController,
            maxLines: null,
            expands: true,
            textAlignVertical: TextAlignVertical.top,
            style: const TextStyle(
              fontFamily: 'Courier',
              fontSize: 13,
            ),
            decoration: const InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.all(12),
            ),
            onChanged: (_) {
              if (!_codeDirty) setState(() => _codeDirty = true);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildImageViewer() {
    return Column(
      children: [
        Container(
          color: Colors.grey.shade100,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              const Icon(Icons.image_outlined, size: 16),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  _selectedPath ?? '',
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              ElevatedButton.icon(
                onPressed: _imageBytes == null
                    ? null
                    : () {
                        final filename = (_selectedPath ?? 'image').split('/').last;
                        dl.downloadBytes(Uint8List.fromList(_imageBytes!), filename);
                      },
                icon: const Icon(Icons.download, size: 18),
                label: const Text('Download'),
              ),
              const SizedBox(width: 8),
              ElevatedButton.icon(
                onPressed: _replaceImage,
                icon: const Icon(Icons.upload, size: 18),
                label: const Text('Replace'),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: _imageBytes == null
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: InteractiveViewer(
                    maxScale: 5,
                    child: Image.memory(
                      Uint8List.fromList(_imageBytes!),
                      fit: BoxFit.contain,
                      gaplessPlayback: true,
                    ),
                  ),
                ),
        ),
      ],
    );
  }
}
