import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../pages/routines_page.dart';
import '../pages/history_page.dart';
import '../pages/progress_page.dart';
import 'home_dashboard.dart';

class MainNavigation extends StatelessWidget {
  const MainNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return const MainNavigationView();
  }
}

class MainNavigationView extends StatelessWidget {
  const MainNavigationView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Expanded(
            child: TabBarView(
              children: [
                const HomeDashboard(),
                const RoutinesPage(),
                const HistoryPage(),
                const ProgressPage(),
              ],
            ),
          ),
          Material(
            elevation: 8,
            child: TabBar(
              labelColor: Theme.of(context).colorScheme.primary,
              unselectedLabelColor: Theme.of(context).colorScheme.onSurfaceVariant,
              indicatorColor: Theme.of(context).colorScheme.primary,
              tabs: [
                Tab(
                  icon: PhosphorIcon(PhosphorIcons.house()),
                  text: 'Inicio',
                ),
                Tab(
                  icon: PhosphorIcon(PhosphorIcons.listChecks()),
                  text: 'Rutinas',
                ),
                Tab(
                  icon: PhosphorIcon(PhosphorIcons.clockCounterClockwise()),
                  text: 'Historial',
                ),
                Tab(
                  icon: PhosphorIcon(PhosphorIcons.chartLine()),
                  text: 'Progreso',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
