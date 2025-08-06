import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../widgets/main_navigation.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const MainNavigation(),
      appBar: AppBar(
        title: const Text('Gym Tracker'),
        actions: [
          IconButton(
            icon: PhosphorIcon(PhosphorIcons.gear()),
            onPressed: () => context.push('/settings'),
          ),
        ],
      ),
    );
  }
}
