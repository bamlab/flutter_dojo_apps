import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/cdapp_theme.dart';
import 'package:flutter_dojo_apps/statistics/widgets/light_card.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

const days = [
  'Lun.',
  'Mar.',
  'Mer.',
  'Jeu.',
  'Ven.',
];

class TimeGraph extends StatelessWidget {
  const TimeGraph({required this.timeOfTasks, super.key});

  final List<Duration> timeOfTasks;

  @override
  Widget build(BuildContext context) {
    final maxTimeOfTask = timeOfTasks.reduce((a, b) => a > b ? a : b);

    return LightCard(
      child: SizedBox(
        child: Table(
          children: [
            TableRow(
              children: timeOfTasks
                  .map(
                    (timeOfTask) => _TimeOfTaskBar(
                      timeOfTask: timeOfTask,
                      maxTimeOfTask: maxTimeOfTask,
                      height: 190,
                    ),
                  )
                  .toList(),
            ),
            TableRow(
              children: timeOfTasks
                  .map(
                    (timeOfTask) => const Divider(
                      color: Colors.white,
                      thickness: 1,
                    ),
                  )
                  .toList(),
            ),
            TableRow(
              children: days
                  .map(
                    (day) => Center(
                      child: AppText.titleSmall(
                        day,
                        color: Colors.white,
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class _TimeOfTaskBar extends StatelessWidget {
  const _TimeOfTaskBar({
    required this.timeOfTask,
    required this.maxTimeOfTask,
    required this.height,
  });

  final Duration timeOfTask;
  final Duration maxTimeOfTask;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        children: [
          const Spacer(),
          AppText.titleLarge(
            '${timeOfTask.inHours}h',
            color: Colors.white,
          ),
          const AppGap.s(),
          _ChartBar(
            height:
                (height - 43) * timeOfTask.inMinutes / maxTimeOfTask.inMinutes,
          ),
        ],
      ),
    );
  }
}

class _ChartBar extends StatefulWidget {
  const _ChartBar({required this.height});

  final double height;

  @override
  State<_ChartBar> createState() => _ChartBarState();
}

class _ChartBarState extends State<_ChartBar> {
  double height = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        height = widget.height;
      });
    });

    return LightCard(
      border: GradientBoxBorder(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.white,
            Colors.white.withOpacity(0),
          ],
        ),
      ),
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(4),
        topRight: Radius.circular(4),
      ),
      child: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOut,
        child: SizedBox(
          height: height,
          width: theme.sizes.xl,
        ),
      ),
    );
  }
}
