import 'package:equatable/equatable.dart';
import '../../../domain/entities/routine.dart';

abstract class RoutinesState extends Equatable {
  const RoutinesState();

  @override
  List<Object?> get props => [];
}

class RoutinesInitial extends RoutinesState {
  const RoutinesInitial();
}

class RoutinesLoading extends RoutinesState {
  const RoutinesLoading();
}

class RoutinesLoaded extends RoutinesState {
  const RoutinesLoaded({required this.routines});

  final List<Routine> routines;

  @override
  List<Object?> get props => [routines];
}

class RoutinesError extends RoutinesState {
  const RoutinesError({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}

class RoutineCreating extends RoutinesState {
  const RoutineCreating();
}

class RoutineCreated extends RoutinesState {
  const RoutineCreated({required this.routine});

  final Routine routine;

  @override
  List<Object?> get props => [routine];
}

class RoutineUpdated extends RoutinesState {
  const RoutineUpdated({required this.routine});

  final Routine routine;

  @override
  List<Object?> get props => [routine];
}

class RoutineDeleted extends RoutinesState {
  const RoutineDeleted({required this.routineId});

  final String routineId;

  @override
  List<Object?> get props => [routineId];
}
