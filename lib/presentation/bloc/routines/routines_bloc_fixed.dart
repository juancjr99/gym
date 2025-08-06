import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/routine_repository.dart';
import 'routines_event.dart';
import 'routines_state.dart';

class RoutinesBloc extends Bloc<RoutinesEvent, RoutinesState> {
  RoutinesBloc({
    required RoutineRepository routineRepository,
  })  : _routineRepository = routineRepository,
        super(const RoutinesInitial()) {
    on<LoadRoutines>(_onLoadRoutines);
    on<CreateRoutine>(_onCreateRoutine);
    on<UpdateRoutine>(_onUpdateRoutine);
    on<DeleteRoutine>(_onDeleteRoutine);
  }

  final RoutineRepository _routineRepository;

  Future<void> _onLoadRoutines(
    LoadRoutines event,
    Emitter<RoutinesState> emit,
  ) async {
    emit(const RoutinesLoading());
    try {
      final routines = await _routineRepository.getAllRoutines();
      emit(RoutinesLoaded(routines: routines));
    } catch (error) {
      emit(RoutinesError(message: error.toString()));
    }
  }

  Future<void> _onCreateRoutine(
    CreateRoutine event,
    Emitter<RoutinesState> emit,
  ) async {
    emit(const RoutineCreating());
    try {
      await _routineRepository.createRoutine(event.routine);
      emit(RoutineCreated(routine: event.routine));
      // Reload routines to show updated list
      add(LoadRoutines());
    } catch (error) {
      emit(RoutinesError(message: error.toString()));
    }
  }

  Future<void> _onUpdateRoutine(
    UpdateRoutine event,
    Emitter<RoutinesState> emit,
  ) async {
    emit(const RoutinesLoading());
    try {
      final routine = await _routineRepository.getRoutineById(event.routineId);
      if (routine != null) {
        final updatedRoutine = routine.copyWith(
          name: event.name,
          description: event.description,
          updatedAt: DateTime.now(),
        );
        await _routineRepository.updateRoutine(updatedRoutine);
        emit(RoutineUpdated(routine: updatedRoutine));
        
        // Reload routines to show updated list
        add(LoadRoutines());
      } else {
        emit(const RoutinesError(message: 'Rutina no encontrada'));
      }
    } catch (error) {
      emit(RoutinesError(message: error.toString()));
    }
  }

  Future<void> _onDeleteRoutine(
    DeleteRoutine event,
    Emitter<RoutinesState> emit,
  ) async {
    emit(const RoutinesLoading());
    try {
      await _routineRepository.deleteRoutine(event.routineId);
      emit(RoutineDeleted(routineId: event.routineId));
      
      // Reload routines to show updated list
      add(LoadRoutines());
    } catch (error) {
      emit(RoutinesError(message: error.toString()));
    }
  }
}
