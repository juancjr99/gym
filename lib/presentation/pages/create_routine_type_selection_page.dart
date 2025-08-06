import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../domain/entities/entities.dart';
import '../../core/constants/app_constants.dart';
import '../providers/create_routine_provider.dart';
import '../widgets/shared/navigable_progress_indicator.dart';

class CreateRoutineTypeSelectionPage extends StatefulWidget {
  const CreateRoutineTypeSelectionPage({super.key});

  @override
  State<CreateRoutineTypeSelectionPage> createState() =>
      _CreateRoutineTypeSelectionPageState();
}

class _CreateRoutineTypeSelectionPageState
    extends State<CreateRoutineTypeSelectionPage> {
  RoutineType? selectedType;

  void _continueToExercises() {
    if (selectedType != null) {
      context.read<CreateRoutineProvider>().setType(selectedType!);
      context.go(AppConstants.createRoutineExercisesRoute);
    }
  }

  void _onStepTapped(int step) {
    switch (step) {
      case 1:
        // Volver a información básica
        context.go(AppConstants.createRoutineBasicRoute);
        break;
      case 2:
        // Ya está en este paso
        break;
      case 3:
        // No puede avanzar hasta seleccionar tipo
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CreateRoutineProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Tipo de Rutina'),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Progreso
                  NavigableProgressIndicator(
                    currentStep: 2,
                    onStepTapped: _onStepTapped,
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Título
                  Text(
                    'Tipo de Rutina',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  
                  const SizedBox(height: 8),
                  
                  Text(
                    'Selecciona cómo quieres estructurar tu rutina "${provider.data.name}"',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Opciones de tipo
                  _TypeOptionCard(
                    icon: PhosphorIcons.barbell(),
                    title: 'Tradicional',
                    description: 'Ejercicios con series y repeticiones específicas. Ideal para fuerza e hipertrofia.',
                    examples: 'Ej: 3 series de 8-12 repeticiones',
                    isSelected: selectedType == RoutineType.traditional,
                    onTap: () => setState(() => selectedType = RoutineType.traditional),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _TypeOptionCard(
                    icon: PhosphorIcons.clockCounterClockwise(),
                    title: 'Circuito',
                    description: 'Ejercicios realizados en secuencia continua sin descanso. Ideal para cardio y resistencia.',
                    examples: 'Ej: 3 rondas de 45 segundos cada ejercicio',
                    isSelected: selectedType == RoutineType.circuit,
                    onTap: () => setState(() => selectedType = RoutineType.circuit),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  _TypeOptionCard(
                    icon: PhosphorIcons.lightning(),
                    title: 'Mixta',
                    description: 'Combina ejercicios tradicionales con secciones de circuito. Lo mejor de ambos mundos.',
                    examples: 'Ej: Fuerza + Circuito final',
                    isSelected: selectedType == RoutineType.mixed,
                    onTap: () => setState(() => selectedType = RoutineType.mixed),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Botón continuar
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: selectedType != null ? _continueToExercises : null,
                      icon: PhosphorIcon(PhosphorIcons.arrowRight()),
                      label: const Text('Continuar'),
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
    );
      },
    );
  }
}

class _TypeOptionCard extends StatelessWidget {
  const _TypeOptionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.examples,
    required this.isSelected,
    required this.onTap,
  });

  final PhosphorIconData icon;
  final String title;
  final String description;
  final String examples;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: isSelected ? 4 : 1,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: isSelected
                ? Border.all(
                    color: Theme.of(context).colorScheme.primary,
                    width: 2,
                  )
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: PhosphorIcon(
                  icon,
                  color: isSelected
                      ? Colors.white
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Theme.of(context).colorScheme.primary
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      examples,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected) ...[
                const SizedBox(width: 12),
                PhosphorIcon(
                  PhosphorIcons.checkCircle(),
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
