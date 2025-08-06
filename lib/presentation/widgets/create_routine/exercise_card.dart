import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../domain/entities/entities.dart';
import '../shared/config_item.dart';

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    super.key,
    required this.exercise,
    required this.routineExercise,
    required this.onEdit,
    required this.onRemove,
  });

  final Exercise exercise;
  final RoutineExercise routineExercise;
  final Function(RoutineExercise) onEdit;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (routineExercise.sectionTitle != null) ...[
              _buildSectionTag(context),
              const SizedBox(height: 8),
            ],
            _buildExerciseHeader(context),
            const SizedBox(height: 16),
            _buildConfiguration(),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTag(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: routineExercise.isCircuit
            ? Colors.orange.withValues(alpha: 0.1)
            : Colors.blue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        routineExercise.sectionTitle!,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: routineExercise.isCircuit ? Colors.orange : Colors.blue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildExerciseHeader(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exercise.name,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                exercise.muscleGroups.map((mg) => mg.name).join(', '),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onRemove,
          icon: PhosphorIcon(PhosphorIcons.trash()),
        ),
      ],
    );
  }

  Widget _buildConfiguration() {
    return Row(
      children: [
        if (!routineExercise.isCircuit) ...[
          ConfigItem(
            label: 'Series',
            value: '${routineExercise.targetSets ?? 3}',
            onTap: () {
              // TODO: Implementar edición
            },
          ),
          const SizedBox(width: 16),
          ConfigItem(
            label: 'Reps',
            value: '${routineExercise.targetReps ?? 10}',
            onTap: () {
              // TODO: Implementar edición
            },
          ),
        ] else ...[
          ConfigItem(
            label: 'Tiempo',
            value: '${routineExercise.targetTime ?? 45}s',
            onTap: () {
              // TODO: Implementar edición
            },
          ),
        ],
      ],
    );
  }
}
