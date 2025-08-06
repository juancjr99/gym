import '../../domain/entities/routine.dart';
import '../../domain/repositories/routine_repository.dart';

class MockRoutineRepository implements RoutineRepository {
  static final List<Routine> _routines = [];

  @override
  Future<List<Routine>> getAllRoutines() async {
    // Simular latencia de red
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_routines);
  }

  @override
  Future<Routine?> getRoutineById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _routines.firstWhere((routine) => routine.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createRoutine(Routine routine) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _routines.add(routine);
  }

  @override
  Future<void> updateRoutine(Routine routine) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _routines.indexWhere((r) => r.id == routine.id);
    if (index != -1) {
      _routines[index] = routine;
    }
  }

  @override
  Future<void> deleteRoutine(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _routines.removeWhere((routine) => routine.id == id);
  }

  @override
  Future<List<Routine>> getActiveRoutines() async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _routines.where((routine) => routine.isActive).toList();
  }

  @override
  Future<List<Routine>> getRoutinesByType(RoutineType type) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _routines.where((routine) => routine.type == type).toList();
  }
}
