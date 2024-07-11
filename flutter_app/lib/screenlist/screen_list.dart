import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/cdapp_theme.dart';
import 'package:flutter_dojo_apps/home/view/home_view.dart';
import 'package:flutter_dojo_apps/statistics/view/statistics_view.dart';
import 'package:flutter_dojo_apps/task_list/view/task_list_view.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class ScreenList extends StatefulWidget {
  const ScreenList({super.key});

  @override
  State<ScreenList> createState() => _ScreenList2State();
}

class _ScreenList2State extends State<ScreenList>
    with TickerProviderStateMixin {
  int _selectedIndex = 0;
  late final animationController = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  );

  late Tween<double> _tween = Tween(begin: 0, end: 0);
  void changeTab(int index) {
    setState(() {
      _tween = Tween(
        begin: _tween.evaluate(animationController),
        end: index.toDouble(),
      );
      _selectedIndex = index;
    });
    animationController.animateTo(index / 3);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final page = switch (_selectedIndex) {
      0 => const HomeView(title: 'test'),
      1 => const StatisticsView(),
      2 => const TaskListView(),
      3 => const SizedBox.shrink(),
      _ => throw UnimplementedError(),
    };

    SalomonBottomBarItem salomonBarItem({
      required String title,
      required IconData icon,
      required int index,
    }) {
      return SalomonBottomBarItem(
        title: AppText.bodyMedium(
          title,
          color: _selectedIndex == index
              ? theme.colors.surface
              : theme.colors.onSurface,
        ),
        icon: Icon(icon, color: theme.colors.onSurface),
        activeIcon: Icon(
          icon,
          color: theme.colors.surface,
        ),
        selectedColor: theme.colors.primary,
        unselectedColor: theme.colors.primary,
      );
    }

    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        extendBody: true,
        bottomNavigationBar: Container(
          padding: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(
            border: GradientBoxBorder(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white.withOpacity(0.4),
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0),
                  Colors.white.withOpacity(0.1),
                ],
              ),
            ),
            color: theme.colors.surface.withOpacity(0.4),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
            gradient: LinearGradient(
              colors: [
                theme.colors.surface.withOpacity(0.4),
                theme.colors.surface.withOpacity(0.8),
              ],
              begin: Alignment.center,
              tileMode: TileMode.mirror,
            ),
          ),
          child: SalomonBottomBar(
            selectedColorOpacity: 1,
            onTap: changeTab,
            currentIndex: _selectedIndex,
            items: <SalomonBottomBarItem>[
              salomonBarItem(
                icon: Icons.home_outlined,
                title: 'Accueil',
                index: 0,
              ),
              salomonBarItem(
                title: 'Analyse',
                icon: Icons.bar_chart_outlined,
                index: 1,
              ),
              salomonBarItem(
                title: 'Taches',
                icon: Icons.fact_check_outlined,
                index: 2,
              ),
              salomonBarItem(
                title: 'Profile',
                icon: Icons.person,
                index: 3,
              ),
            ],
          ),
        ),
        body: Stack(
          children: [
            Image.asset(
              'assets/Background.png',
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
            SafeArea(child: page),
          ],
        ),
      ),
    );
  }
}
