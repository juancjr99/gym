import '../../domain/entities/entities.dart';

class MuscleGroupUtils {
  const MuscleGroupUtils._();

  static String getName(MuscleGroup muscleGroup) {
    switch (muscleGroup) {
      case MuscleGroup.chest:
        return 'Pecho';
      case MuscleGroup.back:
        return 'Espalda';
      case MuscleGroup.shoulders:
        return 'Hombros';
      case MuscleGroup.biceps:
        return 'Bíceps';
      case MuscleGroup.triceps:
        return 'Tríceps';
      case MuscleGroup.legs:
        return 'Piernas';
      case MuscleGroup.abs:
        return 'Abdomen';
      case MuscleGroup.glutes:
        return 'Glúteos';
      case MuscleGroup.calves:
        return 'Pantorrillas';
      case MuscleGroup.forearms:
        return 'Antebrazos';
      case MuscleGroup.cardio:
        return 'Cardio';
      case MuscleGroup.fullBody:
        return 'Cuerpo Completo';
    }
  }

  static List<MuscleGroup> getAll() => MuscleGroup.values;

  static List<MuscleGroup> getPrimary() => [
    MuscleGroup.chest,
    MuscleGroup.back,
    MuscleGroup.shoulders,
    MuscleGroup.legs,
    MuscleGroup.abs,
  ];

  static List<MuscleGroup> getArms() => [
    MuscleGroup.biceps,
    MuscleGroup.triceps,
    MuscleGroup.forearms,
  ];
}
