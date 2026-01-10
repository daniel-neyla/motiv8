import 'package:flutter/material.dart';

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
        Text(
          'This stays private. Just for you.',
          style: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
        ),
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
        TextButton.icon(
          label: Text("Skip if you'd rather not"),
          icon: Icon(Icons.close),
          onPressed: () {},
          style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all(
              colorScheme.onSurface.withAlpha(150),
            ),
          ),
        ),
      ],
    );
  }
}
