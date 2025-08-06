import 'package:equatable/equatable.dart';

enum RoutineType { traditional, circuit }

class RoutineExercise extends Equatable {
  const RoutineExercise({
    required this.exerciseId,
    required this.order,
    this.targetSets,
    this.targetReps,
    this.targetWeight,
    this.targetTime,
    this.restTime,
    this.notes,
  });

  final String exerciseId;
  final int order;
  final int? targetSets;
  final int? targetReps;
  final double? targetWeight;
  final int? targetTime; // en segundos
  final int? restTime; // en segundos
  final String? notes;

  @override
  List<Object?> get props => [
        exerciseId,
        order,
        targetSets,
        targetReps,
        targetWeight,
        targetTime,
        restTime,
        notes,
      ];

  RoutineExercise copyWith({
    String? exerciseId,
    int? order,
    int? targetSets,
    int? targetReps,
    double? targetWeight,
    int? targetTime,
    int? restTime,
    String? notes,
  }) {
    return RoutineExercise(
      exerciseId: exerciseId ?? this.exerciseId,
      order: order ?? this.order,
      targetSets: targetSets ?? this.targetSets,
      targetReps: targetReps ?? this.targetReps,
      targetWeight: targetWeight ?? this.targetWeight,
      targetTime: targetTime ?? this.targetTime,
      restTime: restTime ?? this.restTime,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'order': order,
      'targetSets': targetSets,
      'targetReps': targetReps,
      'targetWeight': targetWeight,
      'targetTime': targetTime,
      'restTime': restTime,
      'notes': notes,
    };
  }

  factory RoutineExercise.fromJson(Map<String, dynamic> json) {
    return RoutineExercise(
      exerciseId: json['exerciseId'] as String,
      order: json['order'] as int,
      targetSets: json['targetSets'] as int?,
      targetReps: json['targetReps'] as int?,
      targetWeight: json['targetWeight'] as double?,
      targetTime: json['targetTime'] as int?,
      restTime: json['restTime'] as int?,
      notes: json['notes'] as String?,
    );
  }
}

class Routine extends Equatable {
  const Routine({
    required this.id,
    required this.name,
    required this.type,
    required this.exercises,
    required this.createdAt,
    required this.updatedAt,
    this.description,
    this.estimatedDuration,
    this.isActive = true,
  });

  final String id;
  final String name;
  final RoutineType type;
  final List<RoutineExercise> exercises;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? description;
  final int? estimatedDuration; // en minutos
  final bool isActive;

  @override
  List<Object?> get props => [
        id,
        name,
        type,
        exercises,
        createdAt,
        updatedAt,
        description,
        estimatedDuration,
        isActive,
      ];

  Routine copyWith({
    String? id,
    String? name,
    RoutineType? type,
    List<RoutineExercise>? exercises,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? description,
    int? estimatedDuration,
    bool? isActive,
  }) {
    return Routine(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      exercises: exercises ?? this.exercises,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      description: description ?? this.description,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
      isActive: isActive ?? this.isActive,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.name,
      'exercises': exercises.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'description': description,
      'estimatedDuration': estimatedDuration,
      'isActive': isActive,
    };
  }

  factory Routine.fromJson(Map<String, dynamic> json) {
    return Routine(
      id: json['id'] as String,
      name: json['name'] as String,
      type: RoutineType.values.firstWhere(
        (e) => e.name == json['type'],
      ),
      exercises: (json['exercises'] as List<dynamic>)
          .map((e) => RoutineExercise.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      description: json['description'] as String?,
      estimatedDuration: json['estimatedDuration'] as int?,
      isActive: json['isActive'] as bool? ?? true,
    );
  }
}
