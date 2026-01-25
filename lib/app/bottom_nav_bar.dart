import 'package:flutter/material.dart';

import 'nav_item.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({
    super.key,
    required this.activeIndex,
    required this.onTap,
    required this.onAdd,
  });

  final int activeIndex;
  final ValueChanged<int> onTap;
  final VoidCallback onAdd;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.symmetric(horizontal: 48),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        border: const Border(top: BorderSide(color: Colors.black12)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NavItem(
            icon: Icons.today,
            label: 'Today',
            isActive: activeIndex == 0,
            onTap: () {
              setState(() => widget.onTap(0));
              setState(() => activeIndex = 0);
            },
          ),

          // Raised middle button
          Transform.translate(
            offset: const Offset(0, -24),
            child: GestureDetector(
              onTap: widget.onAdd,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.add,
                  color: Theme.of(context).colorScheme.surfaceContainer,
                ),
              ),
            ),
          ),

          NavItem(
            icon: Icons.eco, // temporary seedling
            label: 'Growth',
            isActive: activeIndex == 1,
            onTap: () {
              setState(() => widget.onTap(1));
              setState(() => activeIndex = 1);
            },
          ),
        ],
      ),
    );
  }
}
