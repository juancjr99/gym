import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../domain/entities/entities.dart';
import 'exercise_list_tile.dart';
import '../../../core/utils/muscle_group_utils.dart';

class ExerciseSelectionSheet extends StatefulWidget {
  const ExerciseSelectionSheet({
    super.key,
    required this.onExerciseSelected,
  });

  final Function(Exercise) onExerciseSelected;

  @override
  State<ExerciseSelectionSheet> createState() => _ExerciseSelectionSheetState();
}

class _ExerciseSelectionSheetState extends State<ExerciseSelectionSheet> {
  MuscleGroup? selectedMuscleGroup;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        children: [
          _buildHeader(context),
          _buildMuscleGroupFilters(),
          const SizedBox(height: 16),
          _buildExercisesList(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Text(
            'Seleccionar Ejercicio',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: PhosphorIcon(PhosphorIcons.x()),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleGroupFilters() {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        children: [
          _buildMuscleGroupChip(null, 'Todos'),
          ...MuscleGroup.values.map(
            (mg) => _buildMuscleGroupChip(
              mg,
              MuscleGroupUtils.getName(mg),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMuscleGroupChip(MuscleGroup? muscleGroup, String label) {
    final isSelected = selectedMuscleGroup == muscleGroup;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        label: Text(label),
        selected: isSelected,
        onSelected: (selected) {
          setState(() {
            selectedMuscleGroup = selected ? muscleGroup : null;
          });
        },
      ),
    );
  }

  Widget _buildExercisesList() {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _getFilteredExercises().length,
        itemBuilder: (context, index) {
          final exercise = _getFilteredExercises()[index];
          return ExerciseListTile(
            exercise: exercise,
            onTap: () {
              widget.onExerciseSelected(exercise);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  List<Exercise> _getFilteredExercises() {
    if (selectedMuscleGroup == null) {
      return BasicExercises.all;
    }
    return BasicExercises.getByMuscleGroup(selectedMuscleGroup!);
  }
}
