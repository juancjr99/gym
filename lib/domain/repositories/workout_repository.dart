import '../entities/workout_record.dart';

abstract class WorkoutRepository {
  Future<List<WorkoutRecord>> getAllWorkouts();
  Future<WorkoutRecord?> getWorkoutById(String id);
  Future<void> createWorkout(WorkoutRecord workout);
  Future<void> updateWorkout(WorkoutRecord workout);
  Future<void> deleteWorkout(String id);
  Future<List<WorkoutRecord>> getWorkoutsByRoutineId(String routineId);
  Future<List<WorkoutRecord>> getWorkoutsByDateRange(DateTime start, DateTime end);
  Future<WorkoutRecord?> getLastWorkoutForExercise(String exerciseId);
  Future<List<WorkoutRecord>> getWorkoutsThisWeek();
  Future<List<WorkoutRecord>> getWorkoutsThisMonth();
}
