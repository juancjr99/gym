import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/entities.dart';
import '../bloc/bloc.dart';
import '../providers/create_routine_provider.dart';
import '../../core/constants/app_constants.dart';

class CreateRoutineExercisesPage extends StatefulWidget {
  const CreateRoutineExercisesPage({super.key});

  @override
  State<CreateRoutineExercisesPage> createState() =>
      _CreateRoutineExercisesPageState();
}

class _CreateRoutineExercisesPageState extends State<CreateRoutineExercisesPage> {
  String? currentSectionTitle;
  bool isCurrentSectionCircuit = false;
  
  void _addExercise(Exercise exercise) {
    final provider = context.read<CreateRoutineProvider>();
    final routineExercise = RoutineExercise(
      exerciseId: exercise.id,
      order: provider.data.exercises.length,
      targetSets: isCurrentSectionCircuit ? null : 3,
      targetReps: isCurrentSectionCircuit ? null : 10,
      targetTime: isCurrentSectionCircuit ? 45 : null,
      isCircuit: isCurrentSectionCircuit,
      sectionTitle: currentSectionTitle,
    );
    provider.addExercise(routineExercise);
  }

  void _removeExercise(int index) {
    context.read<CreateRoutineProvider>().removeExercise(index);
  }

  void _editExercise(int index, RoutineExercise updatedExercise) {
    context.read<CreateRoutineProvider>().updateExercise(index, updatedExercise);
  }

  void _addSection() {
    showDialog(
      context: context,
      builder: (context) => AddSectionDialog(
        onSectionAdded: (title, isCircuit) {
          setState(() {
            currentSectionTitle = title;
            isCurrentSectionCircuit = isCircuit;
          });
        },
      ),
    );
  }

  void _saveRoutine() {
    final provider = context.read<CreateRoutineProvider>();
    final routine = provider.data.toRoutine();

    context.read<RoutinesBloc>().add(CreateRoutine(routine));
    
    // Resetear provider y volver al inicio
    provider.reset();
    context.go(AppConstants.homeRoute);
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rutina creada exitosamente'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateRoutineProvider>(
      builder: (context, provider, child) {
        final exercises = provider.data.exercises;
        final routineType = provider.data.type!;
        
        return Scaffold(
          appBar: AppBar(
            title: const Text('Agregar Ejercicios'),
            actions: [
              if (exercises.isNotEmpty)
                TextButton(
                  onPressed: _saveRoutine,
                  child: const Text('Guardar'),
                ),
            ],
          ),
          body: SafeArea(
            child: Column(
              children: [
                // Progreso
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: PhosphorIcon(
                              PhosphorIcons.check(),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: PhosphorIcon(
                              PhosphorIcons.check(),
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Container(
                              height: 2,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Text(
                                '3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Información',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Tipo',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Ejercicios',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Contenido principal
                Expanded(
                  child: exercises.isEmpty
                      ? EmptyExercisesView(
                          routineName: provider.data.name!,
                          routineType: routineType,
                          onAddSection: routineType == RoutineType.mixed ? _addSection : null,
                          onAddExercise: _showExerciseSelection,
                        )
                      : ExercisesListView(
                          exercises: exercises,
                          onRemoveExercise: _removeExercise,
                          onEditExercise: _editExercise,
                          onAddExercise: _showExerciseSelection,
                          onAddSection: routineType == RoutineType.mixed ? _addSection : null,
                          currentSectionTitle: currentSectionTitle,
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showExerciseSelection() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (context) => ExerciseSelectionSheet(
        onExerciseSelected: _addExercise,
      ),
    );
  }
}

// Widgets auxiliares como clases separadas

class EmptyExercisesView extends StatelessWidget {
  const EmptyExercisesView({
    super.key,
    required this.routineName,
    required this.routineType,
    required this.onAddExercise,
    this.onAddSection,
  });

  final String routineName;
  final RoutineType routineType;
  final VoidCallback onAddExercise;
  final VoidCallback? onAddSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Text(
            'Agregar Ejercicios',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Agrega ejercicios a tu rutina "$routineName"',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          
          // Ilustración
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
              shape: BoxShape.circle,
            ),
            child: PhosphorIcon(
              PhosphorIcons.barbell(),
              size: 60,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          
          const SizedBox(height: 32),
          
          Text(
            'Comienza agregando ejercicios',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Selecciona de nuestra biblioteca de ejercicios básicos',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          
          const Spacer(),
          
          // Botones
          if (onAddSection != null) ...[
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                onPressed: onAddSection,
                icon: PhosphorIcon(PhosphorIcons.plus()),
                label: const Text('Agregar Sección'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onAddExercise,
              icon: PhosphorIcon(PhosphorIcons.plus()),
              label: const Text('Agregar Ejercicio'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

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
        // Header con contador
        Padding(
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
        ),
        
        // Lista de ejercicios
        Expanded(
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
        ),
      ],
    );
  }
}

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
            // Header con sección si existe
            if (routineExercise.sectionTitle != null) ...[
              Container(
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
              ),
              const SizedBox(height: 8),
            ],
            
            // Ejercicio
            Row(
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
            ),
            
            const SizedBox(height: 16),
            
            // Configuración
            Row(
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
            ),
          ],
        ),
      ),
    );
  }
}

class ConfigItem extends StatelessWidget {
  const ConfigItem({
    super.key,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surfaceContainerHigh,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
          // Header
          Padding(
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
          ),
          
          // Filtros por grupo muscular
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _buildMuscleGroupChip(null, 'Todos'),
                ...MuscleGroup.values.map((mg) => _buildMuscleGroupChip(mg, _getMuscleGroupName(mg))),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Lista de ejercicios
          Expanded(
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

  List<Exercise> _getFilteredExercises() {
    if (selectedMuscleGroup == null) {
      return BasicExercises.all;
    }
    return BasicExercises.getByMuscleGroup(selectedMuscleGroup!);
  }

  String _getMuscleGroupName(MuscleGroup muscleGroup) {
    switch (muscleGroup) {
      case MuscleGroup.chest:
        return 'Pecho';
      case MuscleGroup.back:
        return 'Espalda';
      case MuscleGroup.shoulders:
        return 'Hombros';
      case MuscleGroup.biceps:
        return 'Bíceps';
      case MuscleGroup.triceps:
        return 'Tríceps';
      case MuscleGroup.legs:
        return 'Piernas';
      case MuscleGroup.abs:
        return 'Abdomen';
      case MuscleGroup.glutes:
        return 'Glúteos';
      case MuscleGroup.calves:
        return 'Pantorrillas';
      case MuscleGroup.forearms:
        return 'Antebrazos';
      case MuscleGroup.cardio:
        return 'Cardio';
      case MuscleGroup.fullBody:
        return 'Cuerpo Completo';
    }
  }
}

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
        leading: Container(
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
        ),
        title: Text(exercise.name),
        subtitle: Text(
          exercise.muscleGroups.map((mg) => mg.name).join(', '),
        ),
        trailing: PhosphorIcon(PhosphorIcons.plus()),
      ),
    );
  }
}

class AddSectionDialog extends StatefulWidget {
  const AddSectionDialog({
    super.key,
    required this.onSectionAdded,
  });

  final Function(String, bool) onSectionAdded;

  @override
  State<AddSectionDialog> createState() => _AddSectionDialogState();
}

class _AddSectionDialogState extends State<AddSectionDialog> {
  final _controller = TextEditingController();
  bool isCircuit = false;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Agregar Sección'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _controller,
            decoration: const InputDecoration(
              labelText: 'Nombre de la sección',
              hintText: 'Ej: Calentamiento, Fuerza, Circuito final',
            ),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 16),
          SwitchListTile(
            title: const Text('Es circuito'),
            subtitle: const Text('Los ejercicios se harán en secuencia'),
            value: isCircuit,
            onChanged: (value) => setState(() => isCircuit = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        FilledButton(
          onPressed: _controller.text.trim().isEmpty
              ? null
              : () {
                  widget.onSectionAdded(_controller.text.trim(), isCircuit);
                  Navigator.pop(context);
                },
          child: const Text('Agregar'),
        ),
      ],
    );
  }
}
