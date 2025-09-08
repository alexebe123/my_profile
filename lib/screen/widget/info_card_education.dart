import 'package:flutter/material.dart';
import 'package:my_profile/notifiers/api_service_firebase.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home/home_screen.dart';
import 'package:provider/provider.dart';

Widget infoCardEducation(BuildContext context) {
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
          '🎓 Education History',
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
          width: double.infinity,
          child: ListView.builder(
            itemCount: Provider.of<ApiServiceFirebase>(context).educationHistory.length,
            itemBuilder: (context, index) {
              return InfoCardEducationWidget(
                educationInstitution:
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).educationHistory[index].degree,
                educationCompany:
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).educationHistory[index].description,
                educationYear:
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).educationHistory[index].startDate +
                    " - " +
                    Provider.of<ApiServiceFirebase>(
                      context,
                    ).educationHistory[index].endDate,
              );
            },
          ),
        ),
      ],
    ),
  );
}
