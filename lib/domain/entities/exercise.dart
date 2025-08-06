import 'package:equatable/equatable.dart';

enum ExerciseType { weight, time, bodyweight }

enum MuscleGroup {
  chest,
  back,
  shoulders,
  biceps,
  triceps,
  forearms,
  abs,
  legs,
  glutes,
  calves,
  cardio,
  fullBody
}

class Exercise extends Equatable {
  const Exercise({
    required this.id,
    required this.name,
    required this.type,
    required this.muscleGroups,
    this.description,
    this.imageUrl,
    this.isCustom = false,
  });

  final String id;
  final String name;
  final ExerciseType type;
  final List<MuscleGroup> muscleGroups;
  final String? description;
  final String? imageUrl;
  final bool isCustom;

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        muscleGroups,
        description,
        imageUrl,
        isCustom,
      ];

  Exercise copyWith({
    String? id,
    String? name,
    ExerciseType? type,
    List<MuscleGroup>? muscleGroups,
    String? description,
    String? imageUrl,
    bool? isCustom,
  }) {
    return Exercise(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      muscleGroups: muscleGroups ?? this.muscleGroups,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      isCustom: isCustom ?? this.isCustom,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'muscleGroups': muscleGroups.map((e) => e.name).toList(),
      'description': description,
      'imageUrl': imageUrl,
      'isCustom': isCustom,
    };
  }

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      name: json['name'] as String,
      type: ExerciseType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      muscleGroups: (json['muscleGroups'] as List<dynamic>)
          .map((e) => MuscleGroup.values.firstWhere((mg) => mg.name == e))
          .toList(),
      description: json['description'] as String?,
      imageUrl: json['imageUrl'] as String?,
      isCustom: json['isCustom'] as bool? ?? false,
    );
  }
}
