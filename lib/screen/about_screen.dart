import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About Me"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // صورة شخصية
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(
                "https://bpcfdupkxxalmryqdkym.supabase.co/storage/v1/object/public/images/1756482500823.jpg", // ضع رابط صورتك هنا
              ),
            ),
            SizedBox(height: 16),

            // الاسم
            Text(
              "Ala Eddine Abbassi",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),

            SizedBox(height: 8),

            // الوصف
            Text(
              "Mobile & Flutter Developer\nPassionate about building beautiful apps.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
            ),

            SizedBox(height: 24),

            // أيقونات التواصل
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.github),
                  onPressed: () {
                    // ضع رابط GitHub هنا
                  },
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.linkedin),
                  onPressed: () {
                    // ضع رابط LinkedIn هنا
                  },
                ),
                SizedBox(width: 16),
                IconButton(
                  icon: FaIcon(FontAwesomeIcons.twitter),
                  onPressed: () {
                    // ضع رابط Twitter هنا
                  },
                ),
              ],
            ),

            SizedBox(height: 24),

            // بطاقة للمزيد من التفاصيل
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[500],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                "I specialize in Flutter app development with a focus on clean code, responsive design, and modern UI/UX.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
