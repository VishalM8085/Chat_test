import 'package:client/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenBgColor,
      body: Center(
        child: Column(
          children: [
            SvgPicture.asset("assets/openai.svg",
            color: ,
            )
          ],
        ),
      ),
    );
  }
}