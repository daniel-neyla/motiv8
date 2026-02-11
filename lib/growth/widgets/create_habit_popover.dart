import 'package:flutter/material.dart';

class CreateHabitPopover extends StatefulWidget {
  const CreateHabitPopover({super.key});

  @override
  State<CreateHabitPopover> createState() => _CreateHabitPopoverState();
}

class _CreateHabitPopoverState extends State<CreateHabitPopover> {
  String _habitType = 'Build';
  String _frequency = 'Daily';
  String _duration = '15 min';
  String _preferredTime = 'Morning';

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();

  final Color _accentColor = const Color(
    0xFFD4A57E,
  ); // Tan/Brown color from screenshot
  final Color _inactiveColor = const Color(0xFFF7F3EE);

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
                        color: const Color(0xFFFEF3E7),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.cached,
                        color: Color(0xFFE6A23C),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'New Habit',
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
            const SizedBox(height: 24),
            const Text(
              'What kind of habit?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: _buildToggleButton(
                    label: 'Build',
                    icon: Icons.cached,
                    isSelected: _habitType == 'Build',
                    onTap: () => setState(() => _habitType = 'Build'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildToggleButton(
                    label: 'Avoid',
                    icon: Icons.block,
                    isSelected: _habitType == 'Avoid',
                    onTap: () => setState(() => _habitType = 'Avoid'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'What habit do you want to build?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                hintText: 'e.g., Morning meditation',
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
                  borderSide: const BorderSide(
                    color: Color(0xFF4A7A5E),
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'How often?',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildChoiceChip('Daily'),
                _buildChoiceChip('Weekdays'),
                _buildChoiceChip('Weekly'),
                _buildChoiceChip('3x per week'),
              ],
            ),
            const SizedBox(height: 24),
            const Row(
              children: [
                Icon(Icons.track_changes, size: 18, color: Colors.grey),
                SizedBox(width: 8),
                Text(
                  'Link to a goal (optional)',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _goalController,
              decoration: InputDecoration(
                hintText: 'e.g., Improve mental clarity',
                filled: true,
                fillColor: const Color(0xFFF8F8F8),
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
            const SizedBox(height: 24),
            const Text(
              'Duration (optional)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: [
                _buildSmallChip('5 min'),
                _buildSmallChip('10 min'),
                _buildSmallChip('15 min'),
                _buildSmallChip('30 min'),
                _buildSmallChip('1 hour'),
              ],
            ),
            const SizedBox(height: 24),
            const Text(
              'Preferred time (optional)',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(child: _buildTimeChip('Morning')),
                const SizedBox(width: 8),
                Expanded(child: _buildTimeChip('Midday')),
                const SizedBox(width: 8),
                Expanded(child: _buildTimeChip('Evening')),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE5D1B8),
                  foregroundColor: const Color(0xFF8D6E63),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add Habit',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String label,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: isSelected ? _accentColor : _inactiveColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? Colors.white : Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey[600],
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChoiceChip(String label) {
    bool isSelected = _frequency == label;
    return GestureDetector(
      onTap: () => setState(() => _frequency = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? _accentColor : _inactiveColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildSmallChip(String label) {
    bool isSelected = _duration == label;
    return GestureDetector(
      onTap: () => setState(() => _duration = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[200] : _inactiveColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13,
            color: isSelected ? Colors.black : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildTimeChip(String label) {
    bool isSelected = _preferredTime == label;
    return GestureDetector(
      onTap: () => setState(() => _preferredTime = label),
      child: Container(
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: isSelected ? Colors.grey[200] : _inactiveColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(color: isSelected ? Colors.black : Colors.grey[600]),
        ),
      ),
    );
  }
}
