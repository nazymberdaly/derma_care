// import 'package:derma_care/core/generated/assets.gen.dart';
// import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:derma_care/core/presentation/widgets/custom_button.dart';
import 'package:derma_care/core/presentation/widgets/gradient_scaffold.dart';
import 'package:derma_care/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class OnboardingWelcome extends StatelessWidget {
  const OnboardingWelcome({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: Center(
        child: SizedBox(
          width: context.mediaSize.width * 0.7,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 150,
                // backgroundImage: Assets.images.onboardingWelcome.provider(),
              ),
              const SizedBox(height: 32),
              const Text(
                'Welcome to DermaCare:',
                style: TextStyle(
                  // fontFamily: FontFamily.roboto,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'Your Personal',
                style: TextStyle(
                  // fontFamily: FontFamily.roboto,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                'Dermatology Assistant',
                style: TextStyle(
                  // fontFamily: FontFamily.roboto,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Discover tailored skin care insights powered by AI',
                style: TextStyle(
                  // fontFamily: FontFamily.inter,
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              CustomButton(
                onPressed: () {},
                text: 'Get Started',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
