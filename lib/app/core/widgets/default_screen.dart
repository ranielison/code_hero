import 'package:code_hero/app/core/widgets/no_animation_list.dart';
import 'package:flutter/material.dart';

class DefaultScreen extends StatelessWidget {
  final Widget child;
  final EdgeInsets? contentPadding;

  const DefaultScreen({
    Key? key,
    required this.child,
    this.contentPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: SafeArea(
        child: Padding(
          padding: contentPadding ?? const EdgeInsets.all(20),
          child: NoAnimationList(child: child),
        ),
      ),
    );
  }
}