import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/cdapp_theme.dart';
import 'package:flutter_dojo_apps/screenlist/screen_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

Future<void> main() async {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShaderBuilder(
        (context, shader, child) {
          return CustomPaint(
            painter: ShaderPainter(shader: shader),
            size: MediaQuery.sizeOf(context),
            child: child,
          );
        },
        assetKey: 'assets/myshader.frag',
        child: const ScreenList(),
      ),
      title: 'Flutter Demo',
      theme: dojo,
    );
  }
}

class ShaderPainter extends CustomPainter {
  ShaderPainter({required this.shader});
  FragmentShader shader;
  @override
  void paint(Canvas canvas, Size size) {
    shader.setFloat(0, size.width);
    shader.setFloat(1, size.height);
    final paint = Paint()..shader = shader;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
