import 'package:equatable/equatable.dart';
import '../../../domain/entities/entities.dart';

abstract class RoutinesEvent extends Equatable {
  const RoutinesEvent();

  @override
  List<Object?> get props => [];
}

class LoadRoutines extends RoutinesEvent {
  const LoadRoutines();
}

class CreateRoutine extends RoutinesEvent {
  const CreateRoutine(this.routine);

  final Routine routine;

  @override
  List<Object?> get props => [routine];
}

class UpdateRoutine extends RoutinesEvent {
  const UpdateRoutine({
    required this.routineId,
    required this.name,
    this.description,
  });

  final String routineId;
  final String name;
  final String? description;

  @override
  List<Object?> get props => [routineId, name, description];
}

class DeleteRoutine extends RoutinesEvent {
  const DeleteRoutine({required this.routineId});

  final String routineId;

  @override
  List<Object?> get props => [routineId];
}
