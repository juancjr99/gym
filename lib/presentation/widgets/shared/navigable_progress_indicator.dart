import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NavigableProgressIndicator extends StatelessWidget {
  const NavigableProgressIndicator({
    super.key,
    required this.currentStep,
    this.totalSteps = 3,
    this.onStepTapped,
    this.canNavigateForward = false,
  });

  final int currentStep;
  final int totalSteps;
  final void Function(int step)? onStepTapped;
  final bool canNavigateForward;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: _buildProgressRow(context),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: _buildStepLabels(context),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildProgressRow(BuildContext context) {
    final widgets = <Widget>[];
    
    for (int i = 0; i < totalSteps; i++) {
      widgets.add(_buildStepIndicator(context, i + 1));
      
      if (i < totalSteps - 1) {
        widgets.add(const SizedBox(width: 12));
        widgets.add(
          Expanded(
            child: Container(
              height: 2,
              color: (i + 1) < currentStep
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
            ),
          ),
        );
        widgets.add(const SizedBox(width: 12));
      }
    }
    
    return widgets;
  }

  Widget _buildStepIndicator(BuildContext context, int step) {
    final isCompleted = step < currentStep;
    final isCurrent = step == currentStep;
    final canTap = _canTapStep(step);
    
    Widget indicator = Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        color: (isCompleted || isCurrent)
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.outline,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: isCompleted
            ? PhosphorIcon(
                PhosphorIcons.check(),
                color: Colors.white,
                size: 16,
              )
            : Text(
                '$step',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );

    if (canTap) {
      return GestureDetector(
        onTap: () => onStepTapped?.call(step),
        child: AnimatedScale(
          scale: canTap ? 1.0 : 1.0,
          duration: const Duration(milliseconds: 150),
          child: indicator,
        ),
      );
    }

    return indicator;
  }

  bool _canTapStep(int step) {
    if (onStepTapped == null) return false;
    
    // Solo permite navegar hacia atrás o al paso actual
    // No permite avanzar a pasos futuros a menos que canNavigateForward sea true
    if (step < currentStep) return true; // Puede ir hacia atrás
    if (step == currentStep) return false; // Ya está en el paso actual
    if (step > currentStep && canNavigateForward) return true; // Puede avanzar si está permitido
    
    return false; // No puede ir a pasos futuros por defecto
  }

  List<Widget> _buildStepLabels(BuildContext context) {
    const labels = ['Información', 'Tipo', 'Ejercicios'];
    
    return labels.map((label) {
      final index = labels.indexOf(label) + 1;
      final isActive = index <= currentStep;
      
      return Text(
        label,
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: isActive
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.onSurfaceVariant,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      );
    }).toList();
  }
}
