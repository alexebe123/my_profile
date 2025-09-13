import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:my_profile/model/product_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'dart:typed_data';

import 'package:provider/provider.dart';

class EditProjectDialog extends StatefulWidget {
  EditProjectDialog({super.key, required this.project, required this.isEdit});
  final ProjectModel project;
  final bool isEdit;

  @override
  State<EditProjectDialog> createState() => _EditProjectDialogState();
}

class _EditProjectDialogState extends State<EditProjectDialog> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _projectlinkGithubController =
      TextEditingController(text: "");

  final TextEditingController _projectlinkDemoController =
      TextEditingController(text: "");

  final TextEditingController _projectNameController = TextEditingController(
    text: "",
  );

  final TextEditingController _projectDescriptionController =
      TextEditingController(text: "");

  String? _selectedStatus = "In Progress";
  String? _selectedType = "Mobile";
  // القيمة الافتراضية للحالة // رابط الصورة (يمكنك تعديله حسب الحاجة)
  Uint8List? _imageBytes;
  String imageError = "";
  bool edit = false;
  bool image = true;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        image = false;
        imageError = "";
        _imageBytes = result.files.single.bytes;
        edit = false;
      });
    }
  }

  @override
  initState() {
    super.initState();
    edit = widget.isEdit;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _projectNameController.text = widget.project.name;
      _projectDescriptionController.text = widget.project.description;
      _projectlinkGithubController.text = widget.project.linkGithub;
      _projectlinkDemoController.text = widget.project.linkLiveDemo;
      _selectedStatus = widget.project.status;
      _selectedType = widget.project.type;
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
                        'Edit Project',
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
                    'Project Name',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _projectNameController,
                    decoration: const InputDecoration(
                      hintText: 'Enter project name',
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your name"
                                : null,
                  ),
                  const SizedBox(height: 24),

                  //Github رابط المشروع
                  const Text(
                    'Project Link GitHub',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _projectlinkGithubController,
                    decoration: const InputDecoration(
                      hintText: 'Enter project link',
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your Github"
                                : null,
                  ),
                  const SizedBox(height: 24),
                  //live رابط المشروع
                  const Text(
                    'Project Link Demo',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _projectlinkDemoController,
                    decoration: const InputDecoration(
                      hintText: 'Enter project link Demo',
                    ),
                  ),
                  const SizedBox(height: 24),

                  // حالة المشروع
                  const Text(
                    'Project Status',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedStatus,
                    dropdownColor: const Color(
                      0xFF1F222A,
                    ), // لون خلفية قائمة الخيارات
                    style: const TextStyle(color: Colors.white70),
                    decoration: const InputDecoration(
                      hintText: 'Select status',
                    ),
                    items:
                        <String>[
                          'In Progress',
                          'Completed',
                          'Pending',
                          'Cancelled',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      _selectedStatus = newValue;
                    },
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<String>(
                    value: _selectedType,
                    dropdownColor: const Color(0xFF1F222A),
                    style: const TextStyle(color: Colors.white70),
                    decoration: const InputDecoration(hintText: 'Select Type'),
                    items:
                        <String>[
                          'web',
                          'Mobile',
                          'Desktop',
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                    onChanged: (String? newValue) {
                      _selectedType = newValue;
                    },
                  ),

                  const SizedBox(height: 24),

                  // وصف المشروع
                  const Text(
                    'Project Description',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: _projectDescriptionController,
                    maxLines: 4,
                    decoration: const InputDecoration(
                      hintText: 'Enter project description',
                    ),
                    validator:
                        (value) =>
                            value == null || value.isEmpty
                                ? "Enter your description"
                                : null,
                  ),
                  const SizedBox(height: 24),

                  // تعديل صورة المشروع
                  const Text(
                    'Change Project Image',
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                (imageError == "")
                                    ? Colors.transparent
                                    : Colors.red, // لون الإطار
                            width: 2, // سمك الإطار
                          ),
                          color: const Color(0xFF2C323E),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child:
                            (edit)
                                ? Image.network(widget.project.imageUrl)
                                : (_imageBytes == null)
                                ? Icon(
                                  Icons.image,
                                  size: 40,
                                  color: Colors.white54,
                                )
                                : Image.memory(_imageBytes!),
                      ),
                      const SizedBox(width: 16),
                      ElevatedButton(
                        onPressed: () async {
                          await pickImage();
                          // Logic to pick an image
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF2C323E,
                          ), // لون زر "Upload"
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white30),
                        ),
                        child: const Text('Upload'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),

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
                            if (_imageBytes == null && !image) {
                              setState(() {
                                imageError = "Error";
                              });
                              return;
                            }
                            widget.project.description =
                                _projectDescriptionController.text;
                            widget.project.name = _projectNameController.text;
                            widget.project.linkGithub =
                                _projectlinkGithubController.text;
                            widget.project.linkLiveDemo =
                                _projectlinkDemoController.text;
                            widget.project.status = _selectedStatus!;
                            widget.project.type = _selectedType!;
                            widget.project;
                            if (_imageBytes != null) {
                              widget.project.imageUrl =
                                  await Provider.of<ApiServiceFirebase>(
                                    context,
                                    listen: false,
                                  ).uploadPhoto(_imageBytes!);
                            }

                            if (widget.isEdit) {
                              await Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).updateProject(widget.project);
                            } else {
                              await Provider.of<ApiServiceFirebase>(
                                context,
                                listen: false,
                              ).addProject(widget.project);
                            }

                            // Logic to save changes
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
