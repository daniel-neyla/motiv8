import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;

  const AppScaffold({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Motiv8', style: Theme.of(context).textTheme.titleLarge),
        centerTitle: false,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        elevation: 0,
      ),
      body: body,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 36),
        child: FloatingActionButton(
          onPressed: () {
            print('FAB pressed');
          },
          elevation: 4,
          shape: CircleBorder(),
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add, size: 28, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surfaceContainer,
        selectedIndex: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.today), label: 'Today'),
          NavigationDestination(icon: SizedBox.shrink(), label: ''),
          NavigationDestination(icon: Icon(Icons.eco), label: 'Growth'),
        ],
      ),
    );
  }
}
