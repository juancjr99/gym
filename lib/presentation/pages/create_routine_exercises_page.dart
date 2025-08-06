import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../../domain/entities/entities.dart';
import '../bloc/bloc.dart';
import '../providers/create_routine_provider.dart';
import '../widgets/create_routine/create_routine_widgets.dart';
import '../widgets/shared/navigable_progress_indicator.dart';
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

  void _onStepTapped(int step) {
    switch (step) {
      case 1:
        // Volver a información básica
        context.go(AppConstants.createRoutineBasicRoute);
        break;
      case 2:
        // Volver a selección de tipo
        context.go(AppConstants.createRoutineTypeSelectionRoute);
        break;
      case 3:
        // Ya está en este paso
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateRoutineProvider>(
      builder: (context, provider, child) {
        final exercises = provider.data.exercises;
        final routineType = provider.data.type!;
        
        return Scaffold(
          appBar: _buildAppBar(exercises.isNotEmpty),
          body: SafeArea(
            child: Column(
              children: [
                NavigableProgressIndicator(
                  currentStep: 3,
                  onStepTapped: _onStepTapped,
                ),
                Expanded(
                  child: exercises.isEmpty
                      ? _buildEmptyView(provider, routineType)
                      : _buildExercisesList(exercises, routineType),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar(bool hasExercises) {
    return AppBar(
      title: const Text('Agregar Ejercicios'),
      actions: [
        if (hasExercises)
          TextButton(
            onPressed: _saveRoutine,
            child: const Text('Guardar'),
          ),
      ],
    );
  }

  Widget _buildEmptyView(CreateRoutineProvider provider, RoutineType routineType) {
    return EmptyExercisesView(
      routineName: provider.data.name!,
      routineType: routineType,
      onAddSection: routineType == RoutineType.mixed ? _addSection : null,
      onAddExercise: _showExerciseSelection,
    );
  }

  Widget _buildExercisesList(List<RoutineExercise> exercises, RoutineType routineType) {
    return ExercisesListView(
      exercises: exercises,
      onRemoveExercise: _removeExercise,
      onEditExercise: _editExercise,
      onAddExercise: _showExerciseSelection,
      onAddSection: routineType == RoutineType.mixed ? _addSection : null,
      currentSectionTitle: currentSectionTitle,
    );
  }

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
}
