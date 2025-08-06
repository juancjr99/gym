import 'exercise.dart';

class BasicExercises {
  static const List<Exercise> chest = [
    Exercise(
      id: 'bench_press',
      name: 'Press de Banca',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.chest, MuscleGroup.triceps],
      description: 'Ejercicio fundamental para el desarrollo del pecho',
    ),
    Exercise(
      id: 'push_ups',
      name: 'Flexiones',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.chest, MuscleGroup.triceps],
      description: 'Ejercicio de peso corporal para pecho y tríceps',
    ),
    Exercise(
      id: 'incline_dumbbell_press',
      name: 'Press Inclinado con Mancuernas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.chest, MuscleGroup.shoulders],
      description: 'Enfoque en la parte superior del pecho',
    ),
    Exercise(
      id: 'dumbbell_flys',
      name: 'Aperturas con Mancuernas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.chest],
      description: 'Ejercicio de aislamiento para el pecho',
    ),
  ];

  static const List<Exercise> back = [
    Exercise(
      id: 'pull_ups',
      name: 'Dominadas',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.back, MuscleGroup.biceps],
      description: 'Ejercicio fundamental para el desarrollo de la espalda',
    ),
    Exercise(
      id: 'deadlift',
      name: 'Peso Muerto',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.back, MuscleGroup.legs, MuscleGroup.glutes],
      description: 'Ejercicio compuesto para espalda y piernas',
    ),
    Exercise(
      id: 'barbell_rows',
      name: 'Remo con Barra',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.back, MuscleGroup.biceps],
      description: 'Fortalece la parte media de la espalda',
    ),
    Exercise(
      id: 'lat_pulldown',
      name: 'Jalón al Pecho',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.back, MuscleGroup.biceps],
      description: 'Ejercicio de máquina para dorsales',
    ),
  ];

  static const List<Exercise> legs = [
    Exercise(
      id: 'squats',
      name: 'Sentadillas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.glutes],
      description: 'Ejercicio fundamental para piernas y glúteos',
    ),
    Exercise(
      id: 'lunges',
      name: 'Zancadas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.glutes],
      description: 'Ejercicio unilateral para piernas',
    ),
    Exercise(
      id: 'leg_press',
      name: 'Prensa de Piernas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.legs, MuscleGroup.glutes],
      description: 'Ejercicio de máquina para piernas',
    ),
    Exercise(
      id: 'leg_curls',
      name: 'Curl de Piernas',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.legs],
      description: 'Ejercicio para isquiotibiales',
    ),
    Exercise(
      id: 'calf_raises',
      name: 'Elevaciones de Pantorrilla',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.calves],
      description: 'Ejercicio para pantorrillas',
    ),
  ];

  static const List<Exercise> shoulders = [
    Exercise(
      id: 'overhead_press',
      name: 'Press Militar',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.shoulders, MuscleGroup.triceps],
      description: 'Ejercicio fundamental para hombros',
    ),
    Exercise(
      id: 'lateral_raises',
      name: 'Elevaciones Laterales',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.shoulders],
      description: 'Aislamiento del deltoides medio',
    ),
    Exercise(
      id: 'rear_delt_flys',
      name: 'Aperturas Posteriores',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.shoulders],
      description: 'Ejercicio para deltoides posterior',
    ),
  ];

  static const List<Exercise> arms = [
    Exercise(
      id: 'bicep_curls',
      name: 'Curl de Bíceps',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.biceps],
      description: 'Ejercicio de aislamiento para bíceps',
    ),
    Exercise(
      id: 'tricep_dips',
      name: 'Fondos de Tríceps',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.triceps],
      description: 'Ejercicio para tríceps',
    ),
    Exercise(
      id: 'tricep_extensions',
      name: 'Extensiones de Tríceps',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.triceps],
      description: 'Ejercicio de aislamiento para tríceps',
    ),
    Exercise(
      id: 'hammer_curls',
      name: 'Curl Martillo',
      type: ExerciseType.weight,
      muscleGroups: [MuscleGroup.biceps, MuscleGroup.forearms],
      description: 'Variación de curl para bíceps y antebrazos',
    ),
  ];

  static const List<Exercise> core = [
    Exercise(
      id: 'plank',
      name: 'Plancha',
      type: ExerciseType.time,
      muscleGroups: [MuscleGroup.abs],
      description: 'Ejercicio isométrico para el core',
    ),
    Exercise(
      id: 'crunches',
      name: 'Abdominales',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.abs],
      description: 'Ejercicio básico para abdominales',
    ),
    Exercise(
      id: 'russian_twists',
      name: 'Giros Rusos',
      type: ExerciseType.bodyweight,
      muscleGroups: [MuscleGroup.abs],
      description: 'Ejercicio para oblicuos',
    ),
    Exercise(
      id: 'mountain_climbers',
      name: 'Mountain Climbers',
      type: ExerciseType.time,
      muscleGroups: [MuscleGroup.abs, MuscleGroup.cardio],
      description: 'Ejercicio dinámico para core y cardio',
    ),
  ];

  static List<Exercise> get all => [
        ...chest,
        ...back,
        ...legs,
        ...shoulders,
        ...arms,
        ...core,
      ];

  static List<Exercise> getByMuscleGroup(MuscleGroup muscleGroup) {
    return all.where((exercise) => exercise.muscleGroups.contains(muscleGroup)).toList();
  }

  static Map<MuscleGroup, List<Exercise>> get groupedExercises => {
        MuscleGroup.chest: chest,
        MuscleGroup.back: back,
        MuscleGroup.legs: legs,
        MuscleGroup.shoulders: shoulders,
        MuscleGroup.biceps: arms.where((e) => e.muscleGroups.contains(MuscleGroup.biceps)).toList(),
        MuscleGroup.triceps: arms.where((e) => e.muscleGroups.contains(MuscleGroup.triceps)).toList(),
        MuscleGroup.abs: core,
      };
}
