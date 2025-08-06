import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_constants.dart';
import '../providers/create_routine_provider.dart';
import '../widgets/shared/navigable_progress_indicator.dart';

class CreateRoutineBasicPage extends StatefulWidget {
  const CreateRoutineBasicPage({super.key});

  @override
  State<CreateRoutineBasicPage> createState() => _CreateRoutineBasicPageState();
}

class _CreateRoutineBasicPageState extends State<CreateRoutineBasicPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _continueToTypeSelection() {
    if (_formKey.currentState!.validate()) {
      // Guardar datos en el provider
      context.read<CreateRoutineProvider>().setBasicInfo(
        _nameController.text.trim(),
        _descriptionController.text.trim().isEmpty 
            ? null 
            : _descriptionController.text.trim(),
      );
      
      context.go(AppConstants.createRoutineTypeSelectionRoute);
    }
  }

  void _onStepTapped(int step) {
    // En el paso 1, no permite navegar a otros pasos
    // porque es el primer paso del flujo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Rutina'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Progreso
                NavigableProgressIndicator(
                  currentStep: 1,
                  onStepTapped: _onStepTapped,
                ),
                
                const SizedBox(height: 32),
                
                // Título de sección
                Text(
                  'Información Básica',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                
                const SizedBox(height: 8),
                
                Text(
                  'Comencemos con la información básica de tu rutina',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                
                const SizedBox(height: 32),
                
                // Nombre de la rutina
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Nombre de la rutina *',
                    hintText: 'Ej: Rutina de Pecho y Tríceps',
                    border: const OutlineInputBorder(),
                    prefixIcon: PhosphorIcon(PhosphorIcons.textT()),
                  ),
                  textCapitalization: TextCapitalization.words,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'El nombre es obligatorio';
                    }
                    if (value.trim().length < 3) {
                      return 'El nombre debe tener al menos 3 caracteres';
                    }
                    return null;
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Descripción
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción (opcional)',
                    hintText: 'Describe el objetivo de esta rutina...',
                    border: const OutlineInputBorder(),
                    prefixIcon: PhosphorIcon(PhosphorIcons.notepad()),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                  textCapitalization: TextCapitalization.sentences,
                ),
                
                const SizedBox(height: 40),
                
                // Botón continuar
                SizedBox(
                  width: double.infinity,
                  child: FilledButton.icon(
                    onPressed: _continueToTypeSelection,
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
      ),
    );
  }
}
