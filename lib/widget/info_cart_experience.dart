import 'package:flutter/material.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home_screen.dart';

Widget infoCardExperience() {
  return Container(
    padding: const EdgeInsets.all(18),
    decoration: BoxDecoration(
      color: AppConstant.panelColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '💼 Professional Experience',
          style: TextStyle(
            color: AppConstant.accentBlue,
            fontSize: 16,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 12),
        Divider(color: Colors.black45),
        SizedBox(height: 10),
        InfoCardExperienceWidget(
          name: 'Freelance Developer',
          location: 'Remote',
          job: 'Fullstack Developer',
          duration: '2019 - Present',
        ),
        SizedBox(height: 14),
        InfoCardExperienceWidget(
          name: 'Software Engineer Intern',
          location: 'Lagos, Nigeria',
          job: 'Fullstack Developer',
          duration: '2021 - 2022',
        ),
      ],
    ),
  );
}
