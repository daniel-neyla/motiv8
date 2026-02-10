import 'package:flutter/material.dart';

class CreateGoalPopover extends StatefulWidget {
  const CreateGoalPopover({super.key});

  @override
  State<CreateGoalPopover> createState() => _CreateGoalPopoverState();
}

class _CreateGoalPopoverState extends State<CreateGoalPopover> {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();
  final List<TextEditingController> _milestoneControllers = [];

  final Color _accentColor = const Color(
    0xFFA9C3B4,
  ); // Light green from screenshot
  final Color _textColor = const Color(0xFF4A7A5E);

  @override
  void initState() {
    super.initState();
    _addMilestone();
  }

  void _addMilestone() {
    setState(() {
      _milestoneControllers.add(TextEditingController());
    });
  }

  @override
  void dispose() {
    _goalController.dispose();
    _motivationController.dispose();
    for (var controller in _milestoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.only(
        left: 20,
        right: 20,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFEFF7F2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.track_changes,
                        color: _textColor,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'New Goal',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Serif',
                        color: Color(0xFF1F1F1F),
                      ),
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              "What's your goal?",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _goalController,
              decoration: InputDecoration(
                hintText: 'e.g., Run a marathon',
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.withAlpha(50)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: _textColor, width: 2),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Why does this matter? (optional)',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _motivationController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Describe your motivation...',
                filled: true,
                fillColor: const Color(0xFFFBFBFB),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey.withAlpha(30)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: _textColor.withAlpha(100),
                    width: 1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Milestones',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            ..._milestoneControllers.map(
              (controller) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: 'Add a milestone...',
                          filled: true,
                          fillColor: const Color(0xFFFBFBFB),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _addMilestone,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFBFBFB),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.withAlpha(30)),
                        ),
                        child: const Icon(
                          Icons.add,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _accentColor,
                  foregroundColor: _textColor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Create Goal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
