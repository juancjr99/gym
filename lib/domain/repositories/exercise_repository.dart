import '../entities/exercise.dart';

abstract class ExerciseRepository {
  Future<List<Exercise>> getAllExercises();
  Future<Exercise?> getExerciseById(String id);
  Future<void> createExercise(Exercise exercise);
  Future<void> updateExercise(Exercise exercise);
  Future<void> deleteExercise(String id);
  Future<List<Exercise>> getExercisesByMuscleGroup(MuscleGroup muscleGroup);
  Future<List<Exercise>> getExercisesByType(ExerciseType type);
  Future<List<Exercise>> searchExercises(String query);
}
