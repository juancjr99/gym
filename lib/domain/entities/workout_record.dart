import 'package:equatable/equatable.dart';

class SetRecord extends Equatable {
  const SetRecord({
    required this.setNumber,
    this.reps,
    this.weight,
    this.time, // en segundos
    this.isCompleted = false,
    this.notes,
  });

  final int setNumber;
  final int? reps;
  final double? weight;
  final int? time;
  final bool isCompleted;
  final String? notes;

  @override
  List<Object?> get props => [
        setNumber,
        reps,
        weight,
        time,
        isCompleted,
        notes,
      ];

  SetRecord copyWith({
    int? setNumber,
    int? reps,
    double? weight,
    int? time,
    bool? isCompleted,
    String? notes,
  }) {
    return SetRecord(
      setNumber: setNumber ?? this.setNumber,
      reps: reps ?? this.reps,
      weight: weight ?? this.weight,
      time: time ?? this.time,
      isCompleted: isCompleted ?? this.isCompleted,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'setNumber': setNumber,
      'reps': reps,
      'weight': weight,
      'time': time,
      'isCompleted': isCompleted,
      'notes': notes,
    };
  }

  factory SetRecord.fromJson(Map<String, dynamic> json) {
    return SetRecord(
      setNumber: json['setNumber'] as int,
      reps: json['reps'] as int?,
      weight: json['weight'] as double?,
      time: json['time'] as int?,
      isCompleted: json['isCompleted'] as bool? ?? false,
      notes: json['notes'] as String?,
    );
  }
}

class ExerciseRecord extends Equatable {
  const ExerciseRecord({
    required this.exerciseId,
    required this.sets,
    this.totalTime,
    this.personalRecord = false,
    this.notes,
  });

  final String exerciseId;
  final List<SetRecord> sets;
  final int? totalTime; // tiempo total en segundos
  final bool personalRecord;
  final String? notes;

  @override
  List<Object?> get props => [
        exerciseId,
        sets,
        totalTime,
        personalRecord,
        notes,
      ];

  ExerciseRecord copyWith({
    String? exerciseId,
    List<SetRecord>? sets,
    int? totalTime,
    bool? personalRecord,
    String? notes,
  }) {
    return ExerciseRecord(
      exerciseId: exerciseId ?? this.exerciseId,
      sets: sets ?? this.sets,
      totalTime: totalTime ?? this.totalTime,
      personalRecord: personalRecord ?? this.personalRecord,
      notes: notes ?? this.notes,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'exerciseId': exerciseId,
      'sets': sets.map((e) => e.toJson()).toList(),
      'totalTime': totalTime,
      'personalRecord': personalRecord,
      'notes': notes,
    };
  }

  factory ExerciseRecord.fromJson(Map<String, dynamic> json) {
    return ExerciseRecord(
      exerciseId: json['exerciseId'] as String,
      sets: (json['sets'] as List<dynamic>)
          .map((e) => SetRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalTime: json['totalTime'] as int?,
      personalRecord: json['personalRecord'] as bool? ?? false,
      notes: json['notes'] as String?,
    );
  }
}

class WorkoutRecord extends Equatable {
  const WorkoutRecord({
    required this.id,
    required this.routineId,
    required this.date,
    required this.exerciseRecords,
    this.totalDuration,
    this.notes,
    this.isCompleted = false,
  });

  final String id;
  final String routineId;
  final DateTime date;
  final List<ExerciseRecord> exerciseRecords;
  final int? totalDuration; // duración total en segundos
  final String? notes;
  final bool isCompleted;

  @override
  List<Object?> get props => [
        id,
        routineId,
        date,
        exerciseRecords,
        totalDuration,
        notes,
        isCompleted,
      ];

  WorkoutRecord copyWith({
    String? id,
    String? routineId,
    DateTime? date,
    List<ExerciseRecord>? exerciseRecords,
    int? totalDuration,
    String? notes,
    bool? isCompleted,
  }) {
    return WorkoutRecord(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      date: date ?? this.date,
      exerciseRecords: exerciseRecords ?? this.exerciseRecords,
      totalDuration: totalDuration ?? this.totalDuration,
      notes: notes ?? this.notes,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'routineId': routineId,
      'date': date.toIso8601String(),
      'exerciseRecords': exerciseRecords.map((e) => e.toJson()).toList(),
      'totalDuration': totalDuration,
      'notes': notes,
      'isCompleted': isCompleted,
    };
  }

  factory WorkoutRecord.fromJson(Map<String, dynamic> json) {
    return WorkoutRecord(
      id: json['id'] as String,
      routineId: json['routineId'] as String,
      date: DateTime.parse(json['date'] as String),
      exerciseRecords: (json['exerciseRecords'] as List<dynamic>)
          .map((e) => ExerciseRecord.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalDuration: json['totalDuration'] as int?,
      notes: json['notes'] as String?,
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
