import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/theme/theme_bloc.dart';
import '../bloc/theme/theme_event.dart';
import '../bloc/theme/theme_state.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.fitness_center),
                  title: const Text('Configuración de Entrenamiento'),
                  subtitle: const Text('Tiempo de descanso, unidades'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showWorkoutSettingsDialog(context);
                  },
                ),
                const Divider(height: 1),
                BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, state) {
                    ThemeMode currentThemeMode = ThemeMode.system;
                    
                    if (state is ThemeInitial) {
                      currentThemeMode = state.themeMode;
                    } else if (state is ThemeChanged) {
                      currentThemeMode = state.themeMode;
                    }
                    
                    String themeText = 'Sistema';
                    IconData themeIcon = Icons.brightness_auto;
                    
                    switch (currentThemeMode) {
                      case ThemeMode.light:
                        themeText = 'Claro';
                        themeIcon = Icons.light_mode;
                        break;
                      case ThemeMode.dark:
                        themeText = 'Oscuro';
                        themeIcon = Icons.dark_mode;
                        break;
                      case ThemeMode.system:
                        themeText = 'Sistema';
                        themeIcon = Icons.brightness_auto;
                        break;
                    }
                    
                    return ListTile(
                      leading: Icon(themeIcon),
                      title: const Text('Tema'),
                      subtitle: Text(themeText),
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () {
                        _showThemeDialog(context);
                      },
                    );
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.backup),
                  title: const Text('Copia de seguridad'),
                  subtitle: const Text('Exportar e importar datos'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showBackupDialog(context);
                  },
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 16),
          
          Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.info),
                  title: const Text('Acerca de'),
                  subtitle: const Text('Versión, desarrollador'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showAboutDialog(context);
                  },
                ),
                const Divider(height: 1),
                ListTile(
                  leading: const Icon(Icons.help),
                  title: const Text('Ayuda y soporte'),
                  subtitle: const Text('Tutorial, contacto'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    _showHelpDialog(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showWorkoutSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Configuración de Entrenamiento'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Tiempo de descanso por defecto'),
              subtitle: const Text('90 segundos'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // TODO: Implementar configuración de descanso
              },
            ),
            ListTile(
              title: const Text('Unidad de peso'),
              subtitle: const Text('Kilogramos (kg)'),
              trailing: const Icon(Icons.edit),
              onTap: () {
                // TODO: Implementar configuración de unidades
              },
            ),
            SwitchListTile(
              title: const Text('Vibración en descansos'),
              subtitle: const Text('Vibrar cuando termine el descanso'),
              value: true,
              onChanged: (value) {
                // TODO: Implementar configuración de vibración
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccionar Tema'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            BlocBuilder<ThemeBloc, ThemeState>(
              builder: (context, state) {
                ThemeMode currentThemeMode = ThemeMode.system;
                
                if (state is ThemeInitial) {
                  currentThemeMode = state.themeMode;
                } else if (state is ThemeChanged) {
                  currentThemeMode = state.themeMode;
                }
                
                return Column(
                  children: [
                    RadioListTile<ThemeMode>(
                      title: const Text('Claro'),
                      subtitle: const Text('Siempre usar tema claro'),
                      value: ThemeMode.light,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(SetTheme(false));
                        Navigator.of(context).pop();
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('Oscuro'),
                      subtitle: const Text('Siempre usar tema oscuro'),
                      value: ThemeMode.dark,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(SetTheme(true));
                        Navigator.of(context).pop();
                      },
                    ),
                    RadioListTile<ThemeMode>(
                      title: const Text('Sistema'),
                      subtitle: const Text('Seguir configuración del sistema'),
                      value: ThemeMode.system,
                      groupValue: currentThemeMode,
                      onChanged: (value) {
                        context.read<ThemeBloc>().add(SetTheme(false));
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBackupDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Copia de seguridad'),
        content: const Text('Funcionalidad en desarrollo.\n\nPronto podrás exportar e importar tus rutinas y datos de entrenamiento.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showAboutDialog(
      context: context,
      applicationName: 'Gym Tracker',
      applicationVersion: '1.0.0',
      applicationIcon: const Icon(Icons.fitness_center, size: 64),
      children: [
        const Text('Una aplicación para registrar y monitorear tus entrenamientos en el gimnasio.'),
        const SizedBox(height: 16),
        const Text('Características:'),
        const Text('• Creación de rutinas personalizadas'),
        const Text('• Registro de entrenamientos'),
        const Text('• Seguimiento de progreso'),
        const Text('• Material Design 3'),
      ],
    );
  }

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ayuda y soporte'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('¿Cómo usar la aplicación?', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('1. Crea rutinas desde la pestaña "Rutinas"'),
            const Text('2. Agrega ejercicios a tus rutinas'),
            const Text('3. Inicia entrenamientos desde "Inicio"'),
            const Text('4. Revisa tu progreso en "Progreso"'),
            const SizedBox(height: 16),
            const Text('¿Necesitas ayuda?', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            const Text('Funcionalidad de soporte en desarrollo.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }
}
