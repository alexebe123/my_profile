
  import 'package:flutter/material.dart';
import 'package:my_profile/res/app_constant.dart';
import 'package:my_profile/screen/home_screen.dart';

Widget infoCardEducation() {
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
        children: const [
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
          InfoCardEducationWidget(
            educationInstitution: "iBukas Developer Experiment Lab",
            educationCompany: "Bukas Global Investments",
            educationYear: "2022 - Present",
          ),
          SizedBox(height: 14),
          InfoCardEducationWidget(
            educationInstitution:
                "University of Benin (UniBen) opsefsf oqeqpokd",
            educationCompany: "B.Sc. Computer Science ",
            educationYear: "2018 - 2022",
          ),
        ],
      ),
    );
  }
