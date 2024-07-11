import 'dart:async';
import 'dart:ui';

import 'package:fast_immutable_collections/fast_immutable_collections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/cdapp_theme.dart';
import 'package:flutter_dojo_apps/home/utils/show_project_selection_bottom_sheet.dart';
import 'package:flutter_dojo_apps/home/view/widgets/display_selected_project.dart';
import 'package:flutter_dojo_apps/home/view/widgets/pause_timer_button.dart';
import 'package:flutter_dojo_apps/home/view/widgets/select_project_button.dart';
import 'package:flutter_dojo_apps/home/view/widgets/start_timer_button.dart';
import 'package:flutter_dojo_apps/shared/data/providers/selected_project_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const _projectList =
    IListConst(['TF1+', 'Decathlon', 'Leroy Merlin', 'Carrefour']);

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    required this.title,
    super.key,
  });

  final String title;

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch();
  }

  void onUnselectProject() {
    ref.read(selectedProjectProvider.notifier).selectedProject = '';
  }

  void startTimer() {
    if (_stopwatch.isRunning) {
      _stopwatch.stop();
      _timer.cancel();
    } else {
      _stopwatch.start();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {});
      });
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final selectedProject = ref.watch(selectedProjectProvider);
    final timerButton = _stopwatch.isRunning
        ? PauseTimerButton(
            onTap: startTimer,
          )
        : StartTimerButton(
            onTap: startTimer,
          );

    return SingleChildScrollView(
      physics: const AlwaysScrollableBouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (selectedProject.isNotEmpty)
              DisplaySelectedProject(
                project: selectedProject,
                onUnselectProject: onUnselectProject,
              )
            else
              SelectProjectButton(
                onTap: () => showProjectSelectionBottomSheet(
                  context: context,
                  projectList: _projectList,
                ),
              ),
            Text(
              _stopwatch.elapsed.asPrettyString,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 70,
                fontFamily: 'ZillaSlab',
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            timerButton,
            const Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 48, bottom: 16),
                  child: AppText.titleLarge(
                    'Mes dernières tâches',
                    textAlign: TextAlign.start,
                  ),
                ),
                DayView(
                  duration: Duration(minutes: 45, seconds: 30),
                  title: 'TF1+',
                  icon: Icons.check_circle,
                  date: 'Lundi 20/03',
                ),
                SizedBox(
                  height: 16,
                ),
                DayView(
                  duration: Duration(hours: 1, minutes: 32, seconds: 15),
                  title: 'Decathlon',
                  icon: Icons.check_circle,
                  date: 'Lundi 18/03',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DayView extends StatelessWidget {
  const DayView({
    required this.duration,
    required this.title,
    required this.icon,
    required this.date,
    super.key,
  });

  final Duration duration;
  final String title;
  final IconData icon;
  final String date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppText.bodyMedium(
          date,
          color: theme.colors.primary,
        ),
        const SizedBox(
          height: 8,
        ),
        DecoratedBox(
          decoration: BoxDecoration(
            color: const Color(0x33FFFFFF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 12, bottom: 12, left: 16, right: 16),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(
                  width: 16,
                ),
                AppText.bodyMedium(
                  title,
                  color: theme.colors.primary,
                  fontWeight: FontWeight.w800,
                ),
                const Spacer(),
                AppText.titleMedium(
                  duration.asPrettyString,
                  color: theme.colors.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

extension on Duration {
  String get asPrettyString => '${inHours.toString().padLeft(2, '0')}:'
      '${inMinutes.remainder(60).toString().padLeft(2, '0')}:'
      '${inSeconds.remainder(60).toString().padLeft(2, '0')}';
}
