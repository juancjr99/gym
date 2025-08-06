import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../domain/entities/entities.dart';

class ExerciseListTile extends StatelessWidget {
  const ExerciseListTile({
    super.key,
    required this.exercise,
    required this.onTap,
  });

  final Exercise exercise;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        onTap: onTap,
        leading: _buildIcon(context),
        title: Text(exercise.name),
        subtitle: Text(
          exercise.muscleGroups.map((mg) => mg.name).join(', '),
        ),
        trailing: PhosphorIcon(PhosphorIcons.plus()),
      ),
    );
  }

  Widget _buildIcon(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      child: PhosphorIcon(
        PhosphorIcons.barbell(),
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }
}
