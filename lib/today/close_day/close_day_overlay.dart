import 'package:flutter/material.dart';
import 'package:motiv8/models/day_review.dart';
import 'package:motiv8/utils/day_phase.dart';
import 'mood_board_step.dart';
import 'reflection_step.dart';
import 'close_day_step.dart';
import 'day_review_step.dart';

class CloseDayOverlay extends StatefulWidget {
  final DayReview review;
  const CloseDayOverlay({super.key, required this.review});

  @override
  State<CloseDayOverlay> createState() => _CloseDayOverlay();
}

class _CloseDayOverlay extends State<CloseDayOverlay> {
  int currentStep = 0;
  List<CloseDayStep> get steps => [
    CloseDayStep(
      title: 'Day Review',
      body: Center(child: DayReviewStep(review: widget.review)),
    ),
    CloseDayStep(
      title: 'How did today feel?',
      body: Center(child: MoodBoard()),
    ),
    CloseDayStep(title: 'Reflect on your day', body: ReflectionStep()),
  ];

  void next() {
    if (currentStep < 3) {
      setState(() => currentStep++);
    } else {
      Navigator.pop(context);
    }
  }

  void skip() => next();

  void close() {
    Navigator.of(context).pop();
  }

  void incrementStep() {
    setState(() {
      currentStep++;
    });
  }

  void decrementStep() {
    setState(() {
      currentStep--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenHeight = mediaQuery.size.height;
    final keyboardInset = mediaQuery.viewInsets.bottom;

    debugPrint('Keyboard inset: $keyboardInset');
    return Stack(
      children: [
        AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(bottom: keyboardInset),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.easeOut,
            padding: EdgeInsets.all(24),
            height: screenHeight * 0.6,
            constraints: BoxConstraints(
              maxHeight: screenHeight - keyboardInset - 100,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24),
              ),
            ),
            child: Column(
              children: [
                _Header(
                  step: currentStep,
                  numOfSteps: steps.length,
                  title: steps[currentStep].title,
                ),
                const SizedBox(height: 12),

                Expanded(child: _buildStep()),

                _Footer(
                  onNext: next,
                  currentStep: currentStep,
                  numOfSteps: steps.length,
                  onClose: close,
                  onIncrementStep: incrementStep,
                  onDecrementStep: decrementStep,
                ),
              ],
            ),
          ),
        ),

        Positioned(top: 12, right: 12, child: _CloseButton(onClose: close)),
      ],
    );
  }

  Widget _buildStep() {
    return steps[currentStep].body;
  }
}

// Container(
//           padding: EdgeInsets.all(24),
//  height: MediaQuery.of(context).size.height * 0.6,
//           decoration: BoxDecoration(
//             color: Theme.of(context).colorScheme.surface,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
//           ),
//           child:

class _CloseButton extends StatelessWidget {
  final VoidCallback onClose;

  const _CloseButton({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      color: Theme.of(context).colorScheme.surface,
      elevation: 0,
      child: IconButton(
        icon: const Icon(Icons.close),
        onPressed: onClose,
        color: Theme.of(context).colorScheme.onSurface.withAlpha(150),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final int step;
  final int numOfSteps;
  final String title;

  const _Header({
    required this.step,
    required this.numOfSteps,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IconTheme(
            data: IconThemeData(color: colorScheme.onSurface.withAlpha(100)),
            child: DefaultTextStyle(
              style: TextStyle(color: colorScheme.onSurface.withAlpha(100)),
              child: Row(
                children: [
                  Icon(Icons.night_shelter_outlined),
                  SizedBox(width: 12),
                  Text('Close Day'),
                  SizedBox(width: 12),
                  Text('·'),
                  SizedBox(width: 12),
                  Text('Step ${step + 1} of $numOfSteps'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleLarge),
        ],
      ),
    ); // UI here
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onNext;
  final int currentStep;
  final int numOfSteps;
  final VoidCallback onClose;
  final VoidCallback onIncrementStep;
  final VoidCallback onDecrementStep;
  const _Footer({
    required this.onNext,
    required this.currentStep,
    required this.numOfSteps,
    required this.onClose,
    required this.onIncrementStep,
    required this.onDecrementStep,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        if (currentStep != 0)
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                onDecrementStep();
              },
              child: Text('Back'),
            ),
          ),

        if (currentStep != 0) const SizedBox(width: 24),

        Expanded(
          child: ElevatedButton(
            onPressed: () {
              if (currentStep == numOfSteps - 1) {
                onClose();
              } else {
                onIncrementStep();
              }
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(colorScheme.primary),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),

            child: currentStep == numOfSteps - 1
                ? const Text('Done')
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,

                    children: [
                      Text('Continue'),
                      const SizedBox(width: 12),
                      Icon(Icons.arrow_forward_ios, size: 12),
                    ],
                  ),
          ),
        ),
      ],
    ); // UI here
  }
}
