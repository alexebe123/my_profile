import 'package:flutter/material.dart';

class ProfileSettings extends StatelessWidget {
  const ProfileSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1117),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            constraints: const BoxConstraints(maxWidth: 900),
            decoration: BoxDecoration(
              color: const Color(0xFF161B22),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // العنوان
                const Text(
                  "Profile Settings",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // صورة البروفايل + الشهادات
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          // صورة بروفايل
                          CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey.shade800,
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white70,
                              size: 30,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // قسم الشهادات
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D1117),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Certifications",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration(
                                    "Certificate Name",
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _inputDecoration(
                                          "Issue Date",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade700,
                                      ),
                                      child: const Text("Upload File"),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _inputDecoration(
                                          "Expire Date",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade700,
                                      ),
                                      child: const Text("Upload File"),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                ElevatedButton(
                                  onPressed: () {},
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: const Text("+ Add New Certificate"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 20),

                    // Basic Info + Work Experience
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          // Basic Information
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D1117),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Basic Information",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration("Full Name"),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration("Email Address"),
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration("Job Title"),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Work Experience
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFF0D1117),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Work Experience",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _inputDecoration(
                                          "Company Name",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: TextField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _inputDecoration(
                                          "Job Date",
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration("Job Title"),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                        decoration: _inputDecoration(
                                          "Dates (From - To)",
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.grey.shade700,
                                      ),
                                      child: const Text("Upload File"),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                TextField(
                                  maxLines: 3,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: _inputDecoration(
                                    "Responsibilities / Achievements",
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                      ),
                      child: const Text("Save Changes"),
                    ),
                    const SizedBox(width: 10),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade800,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 14,
                        ),
                      ),
                      child: const Text("Cancel"),
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

  // Decoration InputFields
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.white54),
      filled: true,
      fillColor: const Color(0xFF161B22),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
    );
  }
}
