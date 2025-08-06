import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../domain/entities/entities.dart';
import 'exercise_card.dart';

class ExercisesListView extends StatelessWidget {
  const ExercisesListView({
    super.key,
    required this.exercises,
    required this.onRemoveExercise,
    required this.onEditExercise,
    required this.onAddExercise,
    this.onAddSection,
    this.currentSectionTitle,
  });

  final List<RoutineExercise> exercises;
  final Function(int) onRemoveExercise;
  final Function(int, RoutineExercise) onEditExercise;
  final VoidCallback onAddExercise;
  final VoidCallback? onAddSection;
  final String? currentSectionTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildHeader(context),
        _buildExercisesList(),
      ],
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            'Ejercicios (${exercises.length})',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          if (onAddSection != null)
            TextButton.icon(
              onPressed: onAddSection,
              icon: PhosphorIcon(PhosphorIcons.plus(), size: 16),
              label: const Text('Sección'),
            ),
          TextButton.icon(
            onPressed: onAddExercise,
            icon: PhosphorIcon(PhosphorIcons.plus(), size: 16),
            label: const Text('Ejercicio'),
          ),
        ],
      ),
    );
  }

  Widget _buildExercisesList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final routineExercise = exercises[index];
          final exercise = BasicExercises.all.firstWhere(
            (e) => e.id == routineExercise.exerciseId,
            orElse: () => const Exercise(
              id: 'unknown',
              name: 'Ejercicio Desconocido',
              type: ExerciseType.weight,
              muscleGroups: [],
            ),
          );
          
          return ExerciseCard(
            exercise: exercise,
            routineExercise: routineExercise,
            onEdit: (updatedExercise) => onEditExercise(index, updatedExercise),
            onRemove: () => onRemoveExercise(index),
          );
        },
      ),
    );
  }
}
