import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/cdapp_theme.dart';
import 'package:flutter_dojo_apps/screenlist/screen_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  final program = await FragmentProgram.fromAsset('shaders/myshader.frag');

  runApp(
    ProviderScope(
      child: MyApp(
        program: program,
      ),
    ),
  );
}

// void paint(Canvas canvas, Size size, FragmentShader shader) {
//   // Draws a rectangle with the shader used as a color source.
//   canvas.drawRect(
//     Rect.fromLTWH(0, 0, size.width, size.height),
//     Paint()..shader = shader,
//   );

//   // Draws a stroked rectangle with the shader only applied to the fragments
//   // that lie within the stroke.
//   canvas.drawRect(
//     Rect.fromLTWH(0, 0, size.width, size.height),
//     Paint()
//       ..style = PaintingStyle.stroke
//       ..shader = shader,
//   );
// }

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.program});

  final FragmentProgram program;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: dojo,
      home: CustomPaint(
        child: const ScreenList(),
        painter: MyCustomPainter(),
      ),
    );
  }
}

class MyCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size, FragmentShader shader) {
    // Draws a rectangle with the shader used as a color source.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()..shader = shader,
    );

    // Draws a stroked rectangle with the shader only applied to the fragments
    // that lie within the stroke.
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Paint()
        ..style = PaintingStyle.stroke
        ..shader = shader,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
