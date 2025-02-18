import 'package:client/design/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.greenBgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(),
              SizedBox(
                height: 200,
                width: 200,
                child: SvgPicture.asset(
                  "assets/openai.svg",
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Welcome To ChatGPT",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: AppColors.pinkBgColor,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "OpenAI is an AI research and deployment company. Our mission is to ensure that artificial general intelligence benefits all of humanity.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.pinkBgColor,
                ),
              ),
              Spacer(),
              ElevatedButton(onPressed: () {}, child: Row(
                children: [
                  Text("Try ChatGPT"),
                  SizedBox(wid)
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
