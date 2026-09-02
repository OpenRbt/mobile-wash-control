import 'package:flutter/material.dart';
import 'package:mobile_wash_control/styles/app_theme.dart';

/// Keeps a page readable on a wide browser window without shrinking it on a
/// phone: the child is centred and never grows past [maxWidth].
class ContentContainer extends StatelessWidget {
  const ContentContainer({
    super.key,
    required this.child,
    this.maxWidth = AppTheme.contentMaxWidth,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(padding: padding, child: child),
      ),
    );
  }
}
