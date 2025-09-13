import 'package:flutter/material.dart';
import 'package:my_profile/model/tech_stack_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 40),
        Text(
          "About Me",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 20),
        // صورة شخصية
        CircleAvatar(
          radius: 60,
          backgroundImage: NetworkImage(
            Provider.of<ApiServiceFirebase>(
              context,
              listen: false,
            ).profileModel.imageUrl, // ضع رابط صورتك هنا
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
        Container(
          alignment: Alignment.center,
          height: 50,
          width: 700,
          child: ListView.builder(
            scrollDirection: Axis.horizontal, // 👈 يضمن أنها عمودية
            itemCount:
                Provider.of<ApiServiceFirebase>(
                  context,
                ).profileModel.techStack.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Row(
                children: [
                  HomeScreen.techCircle(
                    TechStack.teck(
                      Provider.of<ApiServiceFirebase>(
                        context,
                      ).profileModel.techStack[index].name,
                    ),
                  ),
                  SizedBox(width: 6),
                ],
              );
            },
          ),
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
    );
  }
}
