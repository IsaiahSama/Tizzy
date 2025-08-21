import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/providers/timer_provider.dart';
import 'package:tizzy_watch/domain/timer.dart';

class NewTimerModal extends ConsumerStatefulWidget {
  const NewTimerModal({super.key});

  @override
  NewTimerModalState createState() => NewTimerModalState();
}

class NewTimerModalState extends ConsumerState<NewTimerModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _selectedDate;

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Timer Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              StatefulBuilder(
                builder: (context, setState) => Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null 
                        ? 'No date chosen'
                        : 'End Date: ${_selectedDate!.toLocal().toString().split(' ')[0]}'),
                    ),
                    TextButton(
                      onPressed: () => showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                      ).then((picked) {
                        if (picked != null) {
                          setState(() => _selectedDate = picked);
                        }
                      }),
                      child: const Text('Choose Date'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate() && _selectedDate != null) {
                        final newTimer = Timer(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: _titleController.text,
                          enddate: _selectedDate!,
                          completed: false,
                        );
                        
                        ref.read(timersProvider.notifier).addTimer(newTimer);
                        Navigator.of(context).pop();
                      } else if (_selectedDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select an end date')),
                        );
                      }
                    },
                    child: const Text('Create Timer'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
