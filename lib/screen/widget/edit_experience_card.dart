import 'package:flutter/material.dart';
import 'package:my_profile/model/experience_history_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:provider/provider.dart';

class EditExperienceCard extends StatefulWidget {
  EditExperienceCard({
    super.key,
    required this.isEdit,
    required this.experienceHistoryModel,
  });
  final bool isEdit;
  final ExperienceHistoryModel experienceHistoryModel;
  @override
  State<EditExperienceCard> createState() => _EditExperienceCardState();
}

class _EditExperienceCardState extends State<EditExperienceCard> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController(
    text: "",
  );
  final TextEditingController _jobStyleController = TextEditingController(
    text: "",
  );
  final TextEditingController _jobTechController = TextEditingController(
    text: "",
  );
  final TextEditingController _dateEndController = TextEditingController(
    text: "",
  );
  final TextEditingController _dateStartController = TextEditingController(
    text: "",
  );

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _titleController.text = widget.experienceHistoryModel.title;
      _jobStyleController.text = widget.experienceHistoryModel.jobStyle;
      _jobTechController.text = widget.experienceHistoryModel.jobTech;
      _dateEndController.text = widget.experienceHistoryModel.endDate;
      _dateStartController.text = widget.experienceHistoryModel.startDate;
    }
    return Dialog(
      backgroundColor: const Color(0xFF1F222A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Edit',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white54),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  // اسم المشروع
                  const Text(
                    'title',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(hintText: 'Enter title'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your title"
                                : null,
                  ),
                  const SizedBox(height: 24),

                  const Text(
                    'job Style',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),

                  TextFormField(
                    controller: _jobStyleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter job Style',
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your job Style"
                                : null,
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'job Tech',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _jobTechController,
                    decoration: const InputDecoration(
                      hintText: 'Enter job job Tech',
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your jobTech"
                                : null,
                  ),
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'date Start',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: TextFormField(
                          controller: _dateStartController,
                          decoration: const InputDecoration(hintText: 'Start'),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? "Enter your degree"
                                      : null,
                        ),
                      ),
                      const SizedBox(width: 15),
                      const Text(
                        '--',
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      const SizedBox(width: 15),
                      SizedBox(
                        width: 80,
                        height: 80,
                        child: TextFormField(
                          controller: _dateEndController,
                          decoration: const InputDecoration(hintText: 'End'),
                          validator:
                              (value) =>
                                  value == null || value.isEmpty
                                      ? "Enter your degree"
                                      : null,
                        ),
                      ),
                    ],
                  ),
                  // أزرار الحفظ والإلغاء
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            // Logic to save changes
                            widget.experienceHistoryModel.title =
                                _titleController.text;
                            widget.experienceHistoryModel.jobStyle =
                                _jobStyleController.text;
                            widget.experienceHistoryModel.jobTech =
                                _jobTechController.text =
                                    widget.experienceHistoryModel.endDate =
                                        _dateEndController.text;
                            widget.experienceHistoryModel.startDate =
                                _dateStartController.text;
                            if (widget.isEdit) {
                              await Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).updateExperienceHistory(
                                widget.experienceHistoryModel,
                              );
                            } else {
                              await Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).addExperienceHistory(
                                widget.experienceHistoryModel,
                              );
                            }
                            Navigator.of(
                              context,
                            ).pop(); // Close dialog after saving
                          }
                        },
                        child: Text((widget.isEdit) ? 'Update' : 'Save'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
