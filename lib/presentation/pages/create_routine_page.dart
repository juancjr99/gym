import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/entities.dart';
import '../bloc/bloc.dart';

class CreateRoutinePage extends StatelessWidget {
  const CreateRoutinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<RoutinesBloc, RoutinesState>(
      listener: (context, state) {
        if (state is RoutineCreated) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Rutina creada exitosamente'),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: const _CreateRoutineForm(),
    );
  }
}

class _CreateRoutineForm extends StatelessWidget {
  const _CreateRoutineForm();

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    RoutineType selectedType = RoutineType.traditional;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Rutina'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (nameController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('El nombre de la rutina es obligatorio'),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
                return;
              }

              final newRoutine = Routine(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                name: nameController.text.trim(),
                description: descriptionController.text.trim().isEmpty
                    ? null
                    : descriptionController.text.trim(),
                type: selectedType,
                exercises: [],
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              );

              context.read<RoutinesBloc>().add(CreateRoutine(newRoutine));
              Navigator.of(context).pop();
            },
            child: const Text('Guardar'),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nombre de la rutina
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Nombre de la rutina',
                  hintText: 'Ej: Rutina de Pecho y Tríceps',
                  border: OutlineInputBorder(),
                ),
                textCapitalization: TextCapitalization.words,
                maxLines: 1,
              ),
              
              const SizedBox(height: 16),
              
              // Descripción
              TextFormField(
                controller: descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Descripción (opcional)',
                  hintText: 'Describe tu rutina...',
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              
              const SizedBox(height: 24),
              
              // Tipo de rutina
              Text(
                'Tipo de rutina',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              
              StatefulBuilder(
                builder: (context, setState) => Column(
                  children: [
                    RadioListTile<RoutineType>(
                      title: const Text('Tradicional'),
                      subtitle: const Text(
                        'Ejercicios con series y repeticiones específicas',
                      ),
                      value: RoutineType.traditional,
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                    RadioListTile<RoutineType>(
                      title: const Text('Circuito'),
                      subtitle: const Text(
                        'Ejercicios realizados en secuencia continua',
                      ),
                      value: RoutineType.circuit,
                      groupValue: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                  ],
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Información adicional
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.info_outline,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Información',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Después de crear la rutina, podrás agregar ejercicios, configurar series, repeticiones y otros parámetros.',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
