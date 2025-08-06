import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../domain/entities/entities.dart';

class EmptyExercisesView extends StatelessWidget {
  const EmptyExercisesView({
    super.key,
    required this.routineName,
    required this.routineType,
    required this.onAddExercise,
    this.onAddSection,
  });

  final String routineName;
  final RoutineType routineType;
  final VoidCallback onAddExercise;
  final VoidCallback? onAddSection;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildHeader(context),
          const SizedBox(height: 32),
          _buildIllustration(context),
          const SizedBox(height: 32),
          _buildInstructions(context),
          const Spacer(),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          'Agregar Ejercicios',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Agrega ejercicios a tu rutina "$routineName"',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildIllustration(BuildContext context) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHigh,
        shape: BoxShape.circle,
      ),
      child: PhosphorIcon(
        PhosphorIcons.barbell(),
        size: 60,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );
  }

  Widget _buildInstructions(BuildContext context) {
    return Column(
      children: [
        Text(
          'Comienza agregando ejercicios',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'Selecciona de nuestra biblioteca de ejercicios básicos',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        if (onAddSection != null) ...[
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: onAddSection,
              icon: PhosphorIcon(PhosphorIcons.plus()),
              label: const Text('Agregar Sección'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
          const SizedBox(height: 12),
        ],
        SizedBox(
          width: double.infinity,
          child: FilledButton.icon(
            onPressed: onAddExercise,
            icon: PhosphorIcon(PhosphorIcons.plus()),
            label: const Text('Agregar Ejercicio'),
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
          ),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
