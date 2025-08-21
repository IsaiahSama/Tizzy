import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tizzy_watch/core/providers/countdown_provider.dart';
import 'package:tizzy_watch/domain/countdown.dart';

class NewCountdownModal extends ConsumerStatefulWidget {
  const NewCountdownModal({super.key});

  @override
  NewCountdownModalState createState() => NewCountdownModalState();
}

class NewCountdownModalState extends ConsumerState<NewCountdownModal> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  DateTime? _selectedDateTime;

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
                  labelText: 'Countdown Title',
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
                      child: Text(_selectedDateTime == null
                          ? 'No date & time chosen'
                          : 'End: '
                              '${_selectedDateTime!.toLocal().toString().substring(0, 16)}'),
                    ),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
                        );
                        if (date != null && context.mounted) {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (time != null) {
                            final combined = DateTime(
                              date.year,
                              date.month,
                              date.day,
                              time.hour,
                              time.minute,
                            );
                            setState(() => _selectedDateTime = combined);
                          } else {
                            // If only date picked, still allow
                            setState(() => _selectedDateTime = date);
                          }
                        }
                      },
                      child: const Text('Choose Date & Time'),
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
                      if (_formKey.currentState!.validate() && _selectedDateTime != null) {
                        final newCountdown = Countdown(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: _titleController.text,
                          enddate: _selectedDateTime!,
                          completed: false,
                        );
                        ref.read(countdownsProvider.notifier).addCountdown(newCountdown);
                        Navigator.of(context).pop();
                      } else if (_selectedDateTime == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Please select a date and time')),
                        );
                      }
                    },
                    child: const Text('Create Countdown'),
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
