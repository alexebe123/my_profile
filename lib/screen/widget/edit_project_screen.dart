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
  // القيمة الافتراضية للحالة // رابط الصورة (يمكنك تعديله حسب الحاجة)
  Uint8List? _imageBytes;

  Future<void> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.bytes != null) {
      setState(() {
        _imageBytes = result.files.single.bytes;
      });
      Provider.of<ApiServiceFirebase>(
        context,
        listen: false,
      ).uploadPhoto(_imageBytes!);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isEdit) {
      _projectNameController.text = widget.project.name;
      _projectDescriptionController.text = widget.project.description;
      _projectlinkGithubController.text = widget.project.linkGithub;
      _projectlinkDemoController.text = widget.project.linkLiveDemo;
      _selectedStatus =
          widget.project.status == 0
              ? "In Progress"
              : widget.project.status == 1
              ? "Completed"
              : widget.project.status == 2
              ? "Pending"
              : "Cancelled";
    }
    return Dialog(
      backgroundColor: const Color(0xFF1F222A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
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
                TextField(
                  controller: _projectNameController,
                  decoration: const InputDecoration(
                    hintText: 'Enter project name',
                  ),
                ),
                const SizedBox(height: 24),

                //Github رابط المشروع
                const Text(
                  'Project Link GitHub',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _projectlinkGithubController,
                  decoration: const InputDecoration(
                    hintText: 'Enter project link',
                  ),
                ),
                const SizedBox(height: 24),
                //live رابط المشروع
                const Text(
                  'Project Link Demo',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
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
                  decoration: const InputDecoration(hintText: 'Select status'),
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
                const SizedBox(height: 24),

                // وصف المشروع
                const Text(
                  'Project Description',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _projectDescriptionController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: 'Enter project description',
                  ),
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
                        color: const Color(0xFF2C323E),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          (_imageBytes == null )
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
                      onPressed: () {
                        // Logic to save changes
                        Navigator.of(
                          context,
                        ).pop(); // Close dialog after saving
                      },
                      child: const Text('Save'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
