import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym/domain/entities/routine.dart' show RoutineType, Routine;
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../bloc/routines/routines_bloc.dart';
import '../bloc/routines/routines_event.dart';
import '../bloc/routines/routines_state.dart';
import '../../data/repositories/mock_routine_repository.dart';
import 'create_routine_page.dart';
import 'routine_detail_page.dart';

class RoutinesPage extends StatelessWidget {
  const RoutinesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoutinesBloc(
        routineRepository: MockRoutineRepository(),
      )..add(const LoadRoutines()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Rutinas'),
        ),
        body: BlocBuilder<RoutinesBloc, RoutinesState>(
          builder: (context, state) {
            if (state is RoutinesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            
            if (state is RoutinesError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 64,
                      color: Theme.of(context).colorScheme.error,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Error al cargar rutinas',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      state.message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () {
                        context.read<RoutinesBloc>().add(const LoadRoutines());
                      },
                      child: const Text('Reintentar'),
                    ),
                  ],
                ),
              );
            }
            
            if (state is RoutinesLoaded) {
              if (state.routines.isEmpty) {
                return const _EmptyRoutinesView();
              }
              
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.routines.length,
                itemBuilder: (context, index) {
                  final routine = state.routines[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: ListTile(
                      leading: Icon(
                        routine.type == RoutineType.circuit
                            ? Icons.loop
                            : Icons.fitness_center,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      title: Text(
                        routine.name,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (routine.description != null)
                            Text(routine.description!),
                          const SizedBox(height: 4),
                          Text(
                            '${routine.exercises.length} ejercicios • ${routine.type == RoutineType.circuit ? 'Circuito' : 'Tradicional'}',
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.onSurfaceVariant,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      trailing: PopupMenuButton(
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
                              _duplicateRoutine(context, routine);
                              break;
                            case 'delete':
                              _showDeleteConfirmation(context, routine);
                              break;
                          }
                        },
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => RoutineDetailPage(routine: routine),
                          ),
                        );
                      },
                    ),
                  );
                },
              );
            }
            
            return const _EmptyRoutinesView();
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _navigateToCreateRoutine(context),
          icon: PhosphorIcon(PhosphorIcons.plus()),
          label: const Text('Crear Rutina'),
        ),
      ),
    );
  }

  void _navigateToCreateRoutine(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<RoutinesBloc>(),
          child: const CreateRoutinePage(),
        ),
      ),
    ).then((_) {
      // Recargar rutinas cuando se regrese de crear rutina
      if (context.mounted) {
        context.read<RoutinesBloc>().add(const LoadRoutines());
      }
    });
  }

  void _duplicateRoutine(BuildContext context, routine) {
    final duplicatedRoutine = Routine(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: '${routine.name} (Copia)',
      description: routine.description,
      type: routine.type,
      exercises: routine.exercises,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    context.read<RoutinesBloc>().add(CreateRoutine(duplicatedRoutine));
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Rutina duplicada exitosamente'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, routine) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Eliminar rutina'),
        content: Text('¿Estás seguro de que quieres eliminar "${routine.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancelar'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              context.read<RoutinesBloc>().add(
                DeleteRoutine(routineId: routine.id),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _EmptyRoutinesView extends StatelessWidget {
  const _EmptyRoutinesView();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.fitness_center,
            size: 64,
            color: Colors.grey,
          ),
          SizedBox(height: 16),
          Text(
            'No tienes rutinas creadas',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Crea tu primera rutina para empezar',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }
}
