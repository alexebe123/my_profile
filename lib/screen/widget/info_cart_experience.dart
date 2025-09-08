import 'package:flutter/material.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

Widget infoCardExperience(BuildContext context) {
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
        SizedBox(
          height: 200,
          width: 400,
          child: ListView.builder(
            itemCount:
                Provider.of<ApiServiceFirebase>(
                  context,
                ).experienceHistory.length,
            itemBuilder: (context, index) {
              final experience =
                  Provider.of<ApiServiceFirebase>(
                    context,
                  ).experienceHistory[index];
              return InfoCardExperienceWidget(
                name: experience.title,
                jobStyle: experience.jobStyle,
                job: experience.jobTech,
                duration: '${experience.startDate} - ${experience.endDate}',
              );
            },
          ),
        ),
      ],
    ),
  );
}
