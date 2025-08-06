import 'package:flutter/material.dart';
import '../../domain/entities/entities.dart';

class CreateRoutineData {
  String? name;
  String? description;
  RoutineType? type;
  List<RoutineExercise> exercises = [];

  void reset() {
    name = null;
    description = null;
    type = null;
    exercises.clear();
  }

  bool get isValid => name != null && type != null;
  
  Routine toRoutine() {
    if (!isValid) throw StateError('Routine data is not valid');
    
    return Routine(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name!,
      description: description,
      type: type!,
      exercises: exercises,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

class CreateRoutineProvider extends ChangeNotifier {
  final CreateRoutineData _data = CreateRoutineData();
  
  CreateRoutineData get data => _data;
  
  void setBasicInfo(String name, String? description) {
    _data.name = name;
    _data.description = description;
    notifyListeners();
  }
  
  void setType(RoutineType type) {
    _data.type = type;
    notifyListeners();
  }
  
  void addExercise(RoutineExercise exercise) {
    _data.exercises.add(exercise);
    notifyListeners();
  }
  
  void removeExercise(int index) {
    _data.exercises.removeAt(index);
    // Reordenar
    for (int i = 0; i < _data.exercises.length; i++) {
      _data.exercises[i] = _data.exercises[i].copyWith(order: i);
    }
    notifyListeners();
  }
  
  void updateExercise(int index, RoutineExercise exercise) {
    _data.exercises[index] = exercise;
    notifyListeners();
  }
  
  void reset() {
    _data.reset();
    notifyListeners();
  }
}
