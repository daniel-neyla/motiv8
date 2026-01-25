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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'This stays private. Just for you.',
          style: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
        ),
        SizedBox(height: 24),
        _MoodGrid(
          selectedIndex: selectedIndex,
          moods: moods,
          moodDescriptions: moodDescriptions,
          colorScheme: colorScheme,
          setState: setState,
          onTap: (int index) {
            setState(() {
              selectedIndex = (selectedIndex == index) ? null : index;
            });
          },
        ),
        SizedBox(height: 24),
        Text(
          "Skip if you'd rather not",
          style: TextStyle(color: colorScheme.onSurface.withAlpha(150)),
        ),
        SizedBox(height: 24),
        // TextButton.icon(
        //   label: Text("Skip if you'd rather not"),
        //   icon: Icon(Icons.close),
        //   onPressed: () {},
        //   style: ButtonStyle(
        //     foregroundColor: WidgetStateProperty.all(
        //       colorScheme.onSurface.withAlpha(150),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class _MoodGrid extends StatelessWidget {
  final int? selectedIndex;
  final List<String> moods;
  final List<String> moodDescriptions;
  final ColorScheme colorScheme;
  final Function setState;
  final Function(int) onTap;

  const _MoodGrid({
    required this.selectedIndex,
    required this.moods,
    required this.moodDescriptions,
    required this.colorScheme,
    required this.setState,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      spacing: 6,
      runSpacing: 12,
      children: moods.map((mood) {
        final index = moods.indexOf(mood);
        return SizedBox(
          width: 96,
          child: _MoodTile(
            mood: mood,
            description: moodDescriptions[index],
            isSelected: selectedIndex == index,
            colorScheme: colorScheme,
            onTap: () => onTap(index),
          ),
        );
      }).toList(),
    );
  }
}

class _MoodTile extends StatelessWidget {
  final String mood;
  final String description;
  final bool isSelected;
  final ColorScheme colorScheme;
  final VoidCallback onTap;

  const _MoodTile({
    required this.mood,
    required this.description,
    required this.isSelected,
    required this.colorScheme,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
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
            Text(mood, style: const TextStyle(fontSize: 28)),
            Text(description),
          ],
        ),
      ),
    );
  }
}
