class AppConstants {
  // Rutas
  static const String homeRoute = '/';
  static const String routinesRoute = '/routines';
  static const String workoutRoute = '/workout';
  static const String historyRoute = '/history';
  static const String progressRoute = '/progress';
  static const String settingsRoute = '/settings';
  
  // Configuración de la app
  static const String appName = 'Gym Tracker';
  static const String appVersion = '1.0.0';
  
  // Base de datos
  static const String databaseName = 'gym_database.db';
  static const int databaseVersion = 1;
  
  // Configuración de ejercicios
  static const int defaultRestTimeSeconds = 60;
  static const int maxSetsPerExercise = 20;
  static const double maxWeightKg = 999.9;
  static const int maxReps = 999;
  static const int maxTimeMinutes = 999;
  
  // Preferencias
  static const String themePreferenceKey = 'theme_preference';
  static const String weightUnitPreferenceKey = 'weight_unit';
  static const String defaultRestTimeKey = 'default_rest_time';
}
