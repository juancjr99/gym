import '../entities/routine.dart';

abstract class RoutineRepository {
  Future<List<Routine>> getAllRoutines();
  Future<Routine?> getRoutineById(String id);
  Future<void> createRoutine(Routine routine);
  Future<void> updateRoutine(Routine routine);
  Future<void> deleteRoutine(String id);
  Future<List<Routine>> getActiveRoutines();
  Future<List<Routine>> getRoutinesByType(RoutineType type);
}
