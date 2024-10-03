import 'package:flutter/material.dart';

class DefaultImage extends StatelessWidget {
  final String filePath;
  const DefaultImage({super.key, required this.filePath});

  @override
  Widget build(BuildContext context) => Image.asset(
        filePath,
        height: 150,
        width: double.infinity,
        fit: BoxFit.cover,
      );
}
