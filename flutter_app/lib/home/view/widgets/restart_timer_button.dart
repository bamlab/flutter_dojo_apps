import 'package:flutter/material.dart';
import 'package:flutter_bam_theme/cdapp_theme.dart';
import 'package:flutter_dojo_apps/home/view/widgets/timer_button.dart';

class RestartTimerButton extends StatelessWidget {
  const RestartTimerButton({
    required this.onTap,
    super.key,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colors;
    return TimerButton(
      padding: const EdgeInsets.all(20),
      onTap: onTap,
      backgroundColor: colors.primary,
      icon: Icon(
        Icons.rotate_left,
        size: 32,
        color: colors.onPrimary,
      ),
    );
  }
}