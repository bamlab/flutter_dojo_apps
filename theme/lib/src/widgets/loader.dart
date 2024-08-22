import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/src/theme/themes_data.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

@visibleForTesting
enum AppLoaderSize {
  small,
  regular,
  big,
}

class AppLoader extends StatelessWidget {
  const AppLoader.small({super.key, this.color}) : size = AppLoaderSize.small;

  const AppLoader.regular({super.key, this.color})
      : size = AppLoaderSize.regular;

  const AppLoader.big({super.key, this.color}) : size = AppLoaderSize.big;

  final AppLoaderSize size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = this.color ?? theme.colors.secondary;

    final dimension = switch (size) {
      AppLoaderSize.small => theme.sizes.s,
      AppLoaderSize.regular => theme.sizes.xl,
      AppLoaderSize.big => theme.sizes.xxxl,
    };

    return SizedBox(
      height: dimension,
      width: dimension * 2,
      child: SpinKitRing(color: color, lineWidth: 2, size: dimension),
    );
  }
}
