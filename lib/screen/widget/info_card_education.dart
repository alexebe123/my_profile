import 'package:flutter/material.dart';
import 'package:my_profile/model/education_history_model.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:my_profile/screen/widget/edit_info_card_education.dart';
import 'package:provider/provider.dart';

Widget infoCardEducation(BuildContext context, bool isEdit) {
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
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '🎓 Education History',
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
                        return EditInfoCardEducation(
                          isEdit: false,
                          educationHistoryModel: EducationHistoryModel.empty(),
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
          width: double.infinity,
          child: ListView.builder(
            itemCount:
                Provider.of<ApiServiceFirebase>(
                  context,
                ).educationHistory.length,
            itemBuilder: (context, index) {
              return InfoCardEducationWidget(
                isEdit: isEdit,
                editEducationHistoryModel:
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).educationHistory[index],
              );
            },
          ),
        ),
      ],
    ),
  );
}
