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
          mainAxisAlignment: Mian,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: SvgPicture.asset("assets/openai.svg",
              color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}