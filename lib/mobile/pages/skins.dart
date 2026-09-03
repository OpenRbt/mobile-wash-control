import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mobile_wash_control/utils/file_bytes.dart';
import 'package:mobile_wash_control/utils/utils.dart';
import 'package:mobile_wash_control/utils/download.dart' as dl;

import '../../entity/entity.dart';
import '../../entity/vo/page_args_codes.dart';
import '../../repository/repository.dart';
import '../widgets/common/washNavigationDrawer.dart';

class SkinsPage extends StatefulWidget {
  const SkinsPage({Key? key}) : super(key: key);

  @override
  State<SkinsPage> createState() => _SkinsPageState();
}

class _SkinsPageState extends State<SkinsPage> {
  List<SkinInfo>? _skins;
  bool _loading = false;

  Future<void> _loadSkins(Repository repository) async {
    setState(() {
      _loading = true;
    });
    try {
      final skins = await repository.listSkins(context: context);
      setState(() {
        _skins = skins;
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Future<void> _uploadSkin(Repository repository) async {
    final nameController = TextEditingController();
    final name = await showDialog<String>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(context.tr('skins')),
          content: TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: context.tr('name'),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(context.tr('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, nameController.text.trim()),
              child: Text("OK"),
            ),
          ],
        );
      },
    );

    if (name == null || name.isEmpty) return;

    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );

    if (result == null || result.files.isEmpty) return;

    final file = result.files.first;
    final bytes = await readPickedFileBytes(file);
    if (bytes == null) return;

    await repository.uploadSkin(name, bytes, context: context);
    await _loadSkins(repository);
  }

  Future<void> _deleteSkin(Repository repository, String name) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(context.tr('delete')),
          content: Text("$name?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx, false),
              child: Text(context.tr('cancel')),
            ),
            TextButton(
              onPressed: () => Navigator.pop(ctx, true),
              child: Text(context.tr('delete')),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    await repository.deleteSkin(name, context: context);
    await _loadSkins(repository);
  }

  Future<void> _downloadSkin(Repository repository, String name) async {
    final bytes = await repository.downloadSkin(name, context: context);
    if (bytes.isEmpty) return;
    await dl.downloadBytes(Uint8List.fromList(bytes), '$name.zip');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("'$name.zip' downloaded")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialArgs = ModalRoute.of(context)?.settings.arguments;

    if (!isArgsValid(initialArgs, context)) {
      return const SizedBox.shrink();
    }

    var args = initialArgs as Map<PageArgCode, dynamic>;
    final Repository repository = args[PageArgCode.repository];

    if (_skins == null && !_loading) {
      _loadSkins(repository);
    }

    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr('skins')),
      ),
      drawer: WashNavigationDrawer(
        selected: SelectedPage.Skins,
        repository: repository,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _uploadSkin(repository),
        child: Icon(Icons.upload),
      ),
      body: _loading && _skins == null
          ? Center(child: CircularProgressIndicator())
          : _skins == null || _skins!.isEmpty
              ? Center(
                  child: Text(
                    context.tr('no_data'),
                    style: theme.textTheme.titleLarge,
                  ),
                )
              : ListView.builder(
                  itemCount: _skins!.length,
                  physics: ClampingScrollPhysics(),
                  itemBuilder: (context, index) {
                    final skin = _skins![index];
                    return Card(
                      child: ListTile(
                        title: Text(
                          skin.name,
                          style: theme.textTheme.titleMedium,
                        ),
                        subtitle: skin.label != null ? Text(skin.label!) : null,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.download),
                              onPressed: () => _downloadSkin(repository, skin.name),
                            ),
                            IconButton(
                              icon: Icon(Icons.delete_outline, color: Colors.red),
                              onPressed: () => _deleteSkin(repository, skin.name),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/mobile/skins/edit', arguments: {
                            PageArgCode.repository: repository,
                            PageArgCode.skinName: skin.name,
                          });
                        },
                      ),
                    );
                  },
                ),
    );
  }
}
