import 'package:flutter/material.dart';
import 'package:motiv8/models/carry_over_decision.dart';

class CarryOverStep extends StatelessWidget {
  final List<CarryOverDecision> decisions;
  final void Function(CarryOverDecision, CarryOverAction) onActionChanged;

  const CarryOverStep({
    super.key,
    required this.decisions,
    required this.onActionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'What would you like to carry forward?',
        //   style: Theme.of(context).textTheme.titleMedium,
        // ),
        // const SizedBox(height: 8),
        Text(
          // 'Decide what deserves your energy tomorrow.',
          'What would you like to carry forward?',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
          ),
        ),
        const SizedBox(height: 24),
        ShaderMask(
          shaderCallback: (rect) {
            return const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black,
                Colors.black,
                Colors.transparent,
              ],
              stops: [0.0, 0.0, 0.9, 1.0],
            ).createShader(rect);
          },
          blendMode: BlendMode.dstIn,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 260, // tweak per design
            ),
            child: SingleChildScrollView(
              child: Column(
                children: decisions.map((decision) {
                  return _CarryOverTaskRow(
                    decision: decision,
                    onActionChanged: onActionChanged,
                  );
                }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _CarryOverTaskRow extends StatelessWidget {
  final CarryOverDecision decision;
  final void Function(CarryOverDecision, CarryOverAction) onActionChanged;

  const _CarryOverTaskRow({
    required this.decision,
    required this.onActionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.onSurface.withAlpha(30)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              decision.task.title,
              style: const TextStyle(fontSize: 15),
            ),
          ),

          _ActionChip(
            label: 'Carry',
            isActive: decision.action == CarryOverAction.carry,
            onTap: () => onActionChanged(decision, CarryOverAction.carry),
          ),
          const SizedBox(width: 8),
          _ActionChip(
            label: 'Let go',
            isActive: decision.action == CarryOverAction.discard,
            onTap: () => onActionChanged(decision, CarryOverAction.discard),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _ActionChip({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isActive
              ? colorScheme.primary.withAlpha(20)
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isActive
                ? colorScheme.primary.withAlpha(120)
                : colorScheme.onSurface.withAlpha(40),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: isActive
                ? colorScheme.primary
                : colorScheme.onSurface.withAlpha(150),
          ),
        ),
      ),
    );
  }
}
