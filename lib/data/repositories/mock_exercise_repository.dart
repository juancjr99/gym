import '../../domain/entities/exercise.dart';
import '../../domain/repositories/exercise_repository.dart';

class MockExerciseRepository implements ExerciseRepository {
  static final List<Exercise> _exercises = [
    // Ejercicios de Pecho
    Exercise(
      id: '1',
      name: 'Press de Banca',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.chest, MuscleGroup.triceps, MuscleGroup.shoulders],
      description: 'Ejercicio fundamental para el desarrollo del pecho',
    ),
    Exercise(
      id: '2',
      name: 'Flexiones',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.chest, MuscleGroup.triceps, MuscleGroup.shoulders],
      description: 'Ejercicio básico de peso corporal para pecho',
    ),
    Exercise(
      id: '3',
      name: 'Press Inclinado con Mancuernas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.chest, MuscleGroup.shoulders],
      description: 'Enfocado en la parte superior del pecho',
    ),

    // Ejercicios de Espalda
    Exercise(
      id: '4',
      name: 'Dominadas',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.back, MuscleGroup.biceps],
      description: 'Ejercicio compuesto para desarrollo de espalda',
    ),
    Exercise(
      id: '5',
      name: 'Remo con Barra',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.back, MuscleGroup.biceps],
      description: 'Excelente para grosor de espalda',
    ),
    Exercise(
      id: '6',
      name: 'Peso Muerto',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.back, MuscleGroup.legs, MuscleGroup.glutes],
      description: 'Rey de los ejercicios compuestos',
    ),

    // Ejercicios de Piernas
    Exercise(
      id: '7',
      name: 'Sentadillas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.glutes],
      description: 'Ejercicio fundamental para piernas',
    ),
    Exercise(
      id: '8',
      name: 'Prensa de Piernas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.glutes],
      description: 'Alternativa segura a las sentadillas',
    ),
    Exercise(
      id: '9',
      name: 'Extensiones de Cuádriceps',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.legs],
      description: 'Aislamiento de cuádriceps',
    ),

    // Ejercicios de Hombros
    Exercise(
      id: '10',
      name: 'Press Militar',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.shoulders, MuscleGroup.triceps],
      description: 'Desarrollo completo de hombros',
    ),
    Exercise(
      id: '11',
      name: 'Elevaciones Laterales',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.shoulders],
      description: 'Aislamiento del deltoides medio',
    ),

    // Ejercicios de Brazos
    Exercise(
      id: '12',
      name: 'Curl de Bíceps',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.biceps],
      description: 'Ejercicio básico para bíceps',
    ),
    Exercise(
      id: '13',
      name: 'Extensiones de Tríceps',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.triceps],
      description: 'Aislamiento de tríceps',
    ),

    // Ejercicios Abdominales
    Exercise(
      id: '14',
      name: 'Plancha',
      type: ExerciseType.time,
      muscleGroups: [MuscleGroup.abs],
      description: 'Ejercicio isométrico para core',
    ),
    Exercise(
      id: '15',
      name: 'Abdominales',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.abs],
      description: 'Ejercicio básico abdominal',
    ),

    // Cardio
    Exercise(
      id: '16',
      name: 'Correr en Cinta',
      type: ExerciseType.time,
      muscleGroups: [MuscleGroup.cardio, MuscleGroup.legs],
      description: 'Ejercicio cardiovascular',
    ),
    Exercise(
      id: '17',
      name: 'Bicicleta Estática',
      type: ExerciseType.time,
      muscleGroups: [MuscleGroup.cardio, MuscleGroup.legs],
      description: 'Bajo impacto cardiovascular',
    ),
  ];

  @override
  Future<List<Exercise>> getAllExercises() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return List.from(_exercises);
  }

  @override
  Future<Exercise?> getExerciseById(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    try {
      return _exercises.firstWhere((exercise) => exercise.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createExercise(Exercise exercise) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _exercises.add(exercise);
  }

  @override
  Future<void> updateExercise(Exercise exercise) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _exercises.indexWhere((e) => e.id == exercise.id);
    if (index != -1) {
      _exercises[index] = exercise;
    }
  }

  @override
  Future<void> deleteExercise(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _exercises.removeWhere((exercise) => exercise.id == id);
  }

  @override
  Future<List<Exercise>> getExercisesByMuscleGroup(MuscleGroup muscleGroup) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _exercises
        .where((exercise) => exercise.muscleGroups.contains(muscleGroup))
        .toList();
  }

  @override
  Future<List<Exercise>> getExercisesByType(ExerciseType type) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _exercises.where((exercise) => exercise.type == type).toList();
  }

  @override
  Future<List<Exercise>> searchExercises(String query) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final lowercaseQuery = query.toLowerCase();
    return _exercises
        .where((exercise) =>
            exercise.name.toLowerCase().contains(lowercaseQuery) ||
            (exercise.description?.toLowerCase().contains(lowercaseQuery) ?? false))
        .toList();
  }
}
