import 'package:flutter/material.dart';

class CloseDayOverlay extends StatefulWidget {
  const CloseDayOverlay({super.key});

  @override
  State<CloseDayOverlay> createState() => _CloseDayOverlay();
}

class _CloseDayOverlay extends State<CloseDayOverlay> {
  int currentStep = 0;

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

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(24),
          height: MediaQuery.of(context).size.height * 0.6,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          ),

          child: Column(
            children: [
              _Header(step: currentStep, onSkip: skip),
              Expanded(child: _buildStep()),
              _Footer(onNext: next),
            ],
          ),
        ),
        Positioned(top: 12, right: 12, child: _CloseButton(onClose: close)),
      ],
    );
  }

  Widget _buildStep() {
    switch (currentStep) {
      case 0:
        return const MoodBoard();
      case 1:
        return const SizedBox();
      case 2:
        return const SizedBox();
      case 3:
        return const SizedBox();
      default:
        return const SizedBox();
    }
  }
}

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
  final VoidCallback onSkip;

  const _Header({required this.step, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: double.infinity,
      child: Column(
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
                  Text('Step 1 of 5'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'How are you feeling?',

            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    ); // UI here
  }
}

class _Footer extends StatelessWidget {
  final VoidCallback onNext;

  const _Footer({required this.onNext});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(onPressed: () {}, child: Text('Back')),
        ),
        const SizedBox(width: 24),
        Expanded(
          child: ElevatedButton(
            onPressed: () {},
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(colorScheme.primary),
              foregroundColor: WidgetStateProperty.all(Colors.white),
            ),

            child: Row(
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

class MoodBoard extends StatefulWidget {
  const MoodBoard({super.key});

  @override
  State<MoodBoard> createState() => _MoodBoardState();
}

class _MoodBoardState extends State<MoodBoard> {
  int? selectedIndex;

  final moods = const ['😄', '🙂', '😐', '😞', '😤'];
  final moodDescriptions = const [
    'Great',
    'Good',
    'Okay',
    'Tough',
    'Frustrated',
  ];

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('This stays private. Just for you.'),
        SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(moods.length, (index) {
            final isSelected = selectedIndex == index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: isSelected
                      ? colorScheme.primary.withAlpha(20)
                      : colorScheme.surface,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSelected
                        ? colorScheme.primary
                        : colorScheme.outlineVariant,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(moods[index], style: const TextStyle(fontSize: 28)),
                    Text(moodDescriptions[index]),
                  ],
                ),
              ),
            );
          }),
        ),
        SizedBox(height: 24),
        Text("Skip if you'd rather not"),
      ],
    );
  }
}
