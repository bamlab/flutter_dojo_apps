// ignore_for_file: avoid-long-functions

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/cdapp_theme.dart';
import 'package:flutter_bam_theme/src/theme/data/box_shadow.dart';
import 'package:flutter_bam_theme/src/theme/data/breakpoints.dart';
import 'package:flutter_bam_theme/src/theme/data/colors.dart';
import 'package:flutter_bam_theme/src/theme/data/cupertino_navigation_bar_theme.dart';
import 'package:flutter_bam_theme/src/theme/data/durations.dart';
import 'package:flutter_bam_theme/src/theme/data/radius.dart';
import 'package:flutter_bam_theme/src/theme/data/sizes.dart';
import 'package:flutter_shaders/flutter_shaders.dart';

/// CDApp custom [ThemeData]. `ThemeMode.valIsere` version.
ThemeData get dojo {
  const colors = ThemeColorsData.light();

  return _getThemeDataFromColors(colors);
}

ThemeData get dojoDark {
  const colors = ThemeColorsData.dark();

  return _getThemeDataFromColors(colors);
}

ThemeData _getThemeDataFromColors(
  ThemeColorsData colors,
) {
  final fallbackTheme = ThemeData.fallback();
  final textTheme = ThemeTypographyData.fromColors(colors);
  const borderRadiusTheme = ThemeRadiusData.regular();
  const sizesTheme = ThemeSizeData.regular();

  return fallbackTheme.copyWith(
    cupertinoOverrideTheme: CupertinoThemeData(
      barBackgroundColor: colors.background,
      textTheme: CupertinoTextThemeData(
        navActionTextStyle: textTheme.bodyMedium,
        navLargeTitleTextStyle: textTheme.titleMedium,
        navTitleTextStyle: textTheme.titleSmall,
        dateTimePickerTextStyle: textTheme.bodyMedium,
      ),
    ),
    extensions: [
      const ThemeRadiusDataExtension(radius: borderRadiusTheme),
      const ThemeSizeDataExtension(sizes: sizesTheme),
      ThemeColorsDataExtension(colors: colors),
      const ThemeBreakpointsDataExtension(
        breakpoints: ThemeBreakpointsData.regular(),
      ),
      const ThemeDurationsDataExtension(
        durations: ThemeDurationsData.regular(),
      ),
      ThemeBoxShadowDataExtension(shadows: ThemeBoxShadowData.regular()),
      CupertinoNavigationBarThemeExtension(
        cupertinoNavigationBarTheme: CupertinoNavigationBarTheme.regular(
          sizes: sizesTheme,
        ),
      ),
    ],
    inputDecorationTheme: fallbackTheme.inputDecorationTheme.copyWith(
      errorStyle: textTheme.bodyMedium!.copyWith(color: colors.onError),
      errorMaxLines: 1,
      contentPadding: EdgeInsets.symmetric(
        vertical: sizesTheme.s,
        horizontal: sizesTheme.m,
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colors.onError, width: 2),
        gapPadding: sizesTheme.xs,
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.primary,
          width: 2,
        ),
        gapPadding: sizesTheme.xs,
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.onError,
          width: 2,
        ),
        gapPadding: sizesTheme.xs,
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.grey100,
          width: 2,
        ),
        gapPadding: sizesTheme.xs,
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: colors.grey100,
          width: 2,
        ),
        gapPadding: sizesTheme.xs,
      ),
    ),
    colorScheme: colors.colorsScheme,
    highlightColor: colors.secondary.withOpacity(0.1),
    scaffoldBackgroundColor: colors.background,
    splashColor: colors.secondary.withOpacity(0.3),
    iconTheme: IconThemeData(
      color: colors.text,
      size: sizesTheme.l,
    ),
    textTheme: textTheme,
    appBarTheme: AppBarTheme(
      backgroundColor: colors.background,
      elevation: 0,
      // The height of the Material app bar to match the height of the
      // Cupertino navigation bar.
      toolbarHeight: kMinInteractiveDimensionCupertino,
      titleTextStyle: textTheme.headlineSmall!.copyWith(
        color: colors.onPrimary,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: colors.background,
      selectedLabelStyle:
          textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      unselectedLabelStyle:
          textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(borderRadiusTheme.s),
      ),
    ),
    cardTheme: fallbackTheme.cardTheme.copyWith(
      color: colors.colorsScheme.surface,
      shadowColor: colors.colorsScheme.shadow,
      surfaceTintColor: colors.colorsScheme.surfaceTint,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(borderRadiusTheme.s),
        side: BorderSide(color: colors.colorsScheme.onSurface),
      ),
    ),
    chipTheme: fallbackTheme.chipTheme.copyWith(
      backgroundColor: colors.grey50,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(borderRadiusTheme.m),
      ),
      side: BorderSide.none,
      elevation: 0,
      padding: EdgeInsets.symmetric(
        horizontal: sizesTheme.s,
        vertical: sizesTheme.xxxs,
      ),
      labelPadding: EdgeInsets.zero,
    ),
    dividerTheme: fallbackTheme.dividerTheme.copyWith(
      space: 1,
      thickness: 1,
      color: colors.grey50,
    ),
    listTileTheme: fallbackTheme.listTileTheme.copyWith(
      contentPadding: sizesTheme.asInsets.m.horizontalOnly,
      horizontalTitleGap: sizesTheme.xxs,
      minLeadingWidth: sizesTheme.xl,
      iconColor: colors.colorsScheme.onSurface,
    ),
    snackBarTheme: const SnackBarThemeData(elevation: 0),
    tabBarTheme: TabBarTheme(
      indicator: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: colors.primary,
            width: sizesTheme.xxxs,
          ),
        ),
      ),
      indicatorSize: TabBarIndicatorSize.label,
      labelPadding: sizesTheme.asInsets.m.horizontalOnly,
      labelStyle: textTheme.bodyMedium!.copyWith(height: 1),
      labelColor: colors.primary,
      unselectedLabelColor: colors.primaryLight,
      unselectedLabelStyle: textTheme.bodyMedium!.copyWith(height: 1),
    ),
  );
}

/// Extension for [ThemeData] to add getters for each theme extensions.
///
/// See: [ThemeExtension].
/// Eg. [radius], [sizes], [colors], [breakpoints].
extension ThemeDataX on ThemeData {
  /// Returns [ThemeRadiusData].
  ///
  /// Must be call in a sub-tree of a [Theme] widget, with the
  /// [ThemeRadiusDataExtension] registered.
  ThemeRadiusData get radius => extension<ThemeRadiusDataExtension>()!.radius;

  /// Returns [ThemeSizeData].
  ///
  /// Must be call in a sub-tree of a [Theme] widget, with the
  /// [ThemeSizeDataExtension] registered.
  ThemeSizeData get sizes => extension<ThemeSizeDataExtension>()!.sizes;

  /// Returns [ThemeBreakpointsData].
  ///
  /// Must be call in a sub-tree of a [Theme] widget, with the
  /// [ThemeBreakpointsDataExtension] registered.
  ThemeBreakpointsData get breakpoints =>
      extension<ThemeBreakpointsDataExtension>()!.breakpoints;

  /// Returns [ThemeBreakpointsData].
  ///
  /// Must be call in a sub-tree of a [Theme] widget, with the
  /// [ThemeBreakpointsDataExtension] registered.
  ThemeDurationsData get durations =>
      extension<ThemeDurationsDataExtension>()!.durations;

  /// Returns [ThemeBoxShadowData].
  ///
  /// Must be call in a sub-tree of a [Theme] widget, with the
  /// [ThemeBoxShadowDataExtension] registered.
  ThemeBoxShadowData get shadows =>
      extension<ThemeBoxShadowDataExtension>()!.shadows;

  /// Returns [ThemeColorsData].
  ///
  /// Must be call in a sub-tree of a [Theme] widget, with the
  /// [ThemeColorsDataExtension] registered.
  ThemeColorsData get colors => extension<ThemeColorsDataExtension>()!.colors;

  /// Returns [CupertinoNavigationBarTheme].
  ///
  /// Must be call in a sub-tree of a [Theme] widget, with the
  /// [CupertinoNavigationBarThemeExtension] registered.
  CupertinoNavigationBarTheme get cupertinoNavigationBarTheme =>
      extension<CupertinoNavigationBarThemeExtension>()!
          .cupertinoNavigationBarTheme;
}

/// An intermediary class that holds the [BuildContext].
/// It allows us to group every theme related [ThemeExtension] in one getter,
/// avoiding having to much context extensions in the app.
class ThemeState {
  const ThemeState(this.context);
  final BuildContext context;
}

/// Extends [BuildContext] with [ThemeState] to provide access to Theme related
/// capabilities such as:
/// * [ScreenDimensionsAwareness]
extension ThemeStateX on BuildContext {
  /// Provides theme data and utils function that need context to be computed.
  ///
  /// Eg. [ThemeBreakpointsData]
  ThemeState get themeState => ThemeState(this);
}

/// Extends the ThemeState class with some awareness of the screen dimensions
/// based on the [BuildContext] and [MediaQuery].
/// e.g. [isLargeScreen]
extension ScreenDimensionsAwareness on ThemeState {
  /// Based on [MediaQuery] `size` and [Theme] `breakpoints`.
  bool get isLargeScreen {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return mediaQuery.size.width >= theme.breakpoints.horizontalBreakpoint;
  }
}
