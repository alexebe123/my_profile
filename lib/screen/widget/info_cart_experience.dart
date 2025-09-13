import 'package:flutter/material.dart';
import 'package:my_profile/model/experience_history_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:my_profile/screen/widget/edit_experience_card.dart';
import 'package:provider/provider.dart';

Widget infoCardExperience(BuildContext context, bool isEdit) {
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '💼 Professional Experience',
              style: TextStyle(
                color: AppConstant.accentBlue,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
            (isEdit)
                ? ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return EditExperienceCard(
                          isEdit: false,
                          experienceHistoryModel:
                              ExperienceHistoryModel.empty(),
                        );
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF333333),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Create New Project',
                    style: TextStyle(fontSize: 16),
                  ),
                )
                : SizedBox(),
          ],
        ),
        SizedBox(height: 12),
        Divider(color: Colors.black45),
        SizedBox(height: 10),
        SizedBox(
          height: 200,

          child: ListView.builder(
            itemCount:
                Provider.of<ApiServiceFirebase>(
                  context,
                ).experienceHistory.length,
            itemBuilder: (context, index) {
              return InfoCardExperienceWidget(
                isEdit: isEdit,
                experienceHistoryModel:
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).experienceHistory[index],
              );
            },
          ),
        ),
      ],
    ),
  );
}
