import 'package:flutter/material.dart';
import 'package:my_profile/model/education_history_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:provider/provider.dart';

class EditInfoCardEducation extends StatefulWidget {
  EditInfoCardEducation({
    super.key,
    required this.isEdit,
    required this.educationHistoryModel,
  });
  final bool isEdit;
  final EducationHistoryModel educationHistoryModel;
  @override
  State<EditInfoCardEducation> createState() => _EditInfoCardEducationState();
}

class _EditInfoCardEducationState extends State<EditInfoCardEducation> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _degreeController = TextEditingController(
    text: "",
  );
  final TextEditingController _descriptionController = TextEditingController(
    text: "",
  );
  final TextEditingController _dateStartController = TextEditingController(
    text: "",
  );
  final TextEditingController _dateEndController = TextEditingController(
    text: "",
  );

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _degreeController.text = widget.educationHistoryModel.degree;
      _descriptionController.text = widget.educationHistoryModel.description;
      _dateStartController.text = widget.educationHistoryModel.startDate;
      _dateEndController.text = widget.educationHistoryModel.endDate;
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
                       Text(
                      (widget.isEdit) ?  'Edit':'Add New',
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
                    'degree',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _degreeController,
                    decoration: const InputDecoration(hintText: 'Enter degree'),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your degree"
                                : null,
                  ),
                  const SizedBox(height: 24),
                  // وصف المشروع
                  const Text(
                    ' Description',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _descriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Enter description',
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your description"
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
                            widget.educationHistoryModel.degree =
                                _degreeController.text;
                            widget.educationHistoryModel.description =
                                _descriptionController.text;
                            widget.educationHistoryModel.startDate =
                                _dateStartController.text;
                            widget.educationHistoryModel.endDate =
                                _dateEndController.text;
                            if (widget.isEdit) {
                              await Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).updateEducationHistory(
                                widget.educationHistoryModel,
                              );
                            } else {
                              await Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).addEducationHistory(
                                widget.educationHistoryModel,
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
