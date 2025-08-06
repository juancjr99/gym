import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';
import '../../data/repositories/mock_exercise_repository.dart';

class RoutineDetailPage extends StatelessWidget {
  const RoutineDetailPage({
    super.key,
    required this.routine,
  });

  final Routine routine;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(routine.name),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: 'edit',
                child: Row(
                  children: [
                    Icon(Icons.edit),
                    SizedBox(width: 8),
                    Text('Editar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'duplicate',
                child: Row(
                  children: [
                    Icon(Icons.copy),
                    SizedBox(width: 8),
                    Text('Duplicar'),
                  ],
                ),
              ),
              const PopupMenuItem(
                value: 'delete',
                child: Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red),
                    SizedBox(width: 8),
                    Text('Eliminar', style: TextStyle(color: Colors.red)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              switch (value) {
                case 'edit':
                  // TODO: Implementar navegación a editar rutina
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Funcionalidad en desarrollo'),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                  break;
                case 'duplicate':
                  _duplicateRoutine(context);
                  break;
                case 'delete':
                  _showDeleteConfirmation(context);
                  break;
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Información básica
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          routine.type == RoutineType.circuit
                              ? Icons.loop
                              : Icons.fitness_center,
                          color: Theme.of(context).colorScheme.primary,
                          size: 32,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                routine.name,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              Text(
                                routine.type == RoutineType.circuit 
                                    ? 'Rutina en Circuito' 
                                    : 'Rutina Tradicional',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (routine.description != null) ...[
                      const SizedBox(height: 16),
                      Text(
                        'Descripción',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        routine.description!,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        _InfoChip(
                          icon: Icons.fitness_center,
                          label: '${routine.exercises.length} ejercicios',
                        ),
                        const SizedBox(width: 8),
                        if (routine.estimatedDuration != null)
                          _InfoChip(
                            icon: Icons.schedule,
                            label: '${routine.estimatedDuration} min',
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Lista de ejercicios
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Ejercicios',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 16),
                    
                    if (routine.exercises.isEmpty)
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .colorScheme
                              .surfaceContainerHighest
                              .withValues(alpha: 0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Theme.of(context)
                                .colorScheme
                                .outline
                                .withValues(alpha: 0.5),
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.fitness_center_outlined,
                              size: 48,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'No hay ejercicios configurados',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Edita la rutina para agregar ejercicios',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      )
                    else
                      ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: routine.exercises.length,
                        separatorBuilder: (context, index) => const SizedBox(height: 8),
                        itemBuilder: (context, index) {
                          final routineExercise = routine.exercises[index];
                          return _ExerciseCard(
                            routineExercise: routineExercise,
                            index: index,
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Botón de comenzar entrenamiento
            if (routine.exercises.isNotEmpty)
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: () {
                    // TODO: Navegar a página de entrenamiento
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Módulo de entrenamiento en desarrollo'),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text('Comenzar Entrenamiento'),
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _duplicateRoutine(BuildContext context) {
    // TODO: Implementar duplicar rutina
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Funcionalidad en desarrollo'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar rutina'),
        content: Text('¿Estás seguro de que quieres eliminar "${routine.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar diálogo
              Navigator.of(context).pop(); // Regresar a lista
              // TODO: Eliminar rutina desde aquí si es necesario
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({
    required this.icon,
    required this.label,
  });

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: Theme.of(context).colorScheme.onSecondaryContainer,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).colorScheme.onSecondaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  const _ExerciseCard({
    required this.routineExercise,
    required this.index,
  });

  final RoutineExercise routineExercise;
  final int index;

  @override
  Widget build(BuildContext context) {
    final exerciseRepository = MockExerciseRepository();
    
    return FutureBuilder<Exercise?>(
      future: exerciseRepository.getExerciseById(routineExercise.exerciseId),
      builder: (context, snapshot) {
        final exercise = snapshot.data;
        
        return Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  radius: 20,
                  child: Text(
                    '${index + 1}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        exercise?.name ?? 'Cargando...',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      if (exercise != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          exercise.muscleGroups.isNotEmpty
                              ? exercise.muscleGroups.map((group) => group.name).join(', ')
                              : 'Sin grupo muscular',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                      const SizedBox(height: 8),
                      _buildExerciseConfig(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildExerciseConfig() {
    List<Widget> configs = [];
    
    if (routineExercise.targetSets != null) {
      configs.add(_ConfigChip(
        label: '${routineExercise.targetSets} series',
        icon: Icons.repeat,
      ));
    }
    
    if (routineExercise.targetReps != null) {
      configs.add(_ConfigChip(
        label: '${routineExercise.targetReps} reps',
        icon: Icons.numbers,
      ));
    }
    
    if (routineExercise.targetWeight != null) {
      configs.add(_ConfigChip(
        label: '${routineExercise.targetWeight} kg',
        icon: Icons.fitness_center,
      ));
    }
    
    if (routineExercise.targetTime != null) {
      final minutes = routineExercise.targetTime! ~/ 60;
      final seconds = routineExercise.targetTime! % 60;
      String timeText;
      if (minutes > 0) {
        timeText = '${minutes}m ${seconds}s';
      } else {
        timeText = '${seconds}s';
      }
      configs.add(_ConfigChip(
        label: timeText,
        icon: Icons.schedule,
      ));
    }
    
    if (routineExercise.restTime != null) {
      configs.add(_ConfigChip(
        label: 'Descanso: ${routineExercise.restTime}s',
        icon: Icons.pause,
      ));
    }
    
    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: configs,
    );
  }
}

class _ConfigChip extends StatelessWidget {
  const _ConfigChip({
    required this.label,
    required this.icon,
  });

  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 14,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
