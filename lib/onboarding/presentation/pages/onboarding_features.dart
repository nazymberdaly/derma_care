import 'package:derma_care/core/generated/assets.gen.dart';
import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:derma_care/core/presentation/widgets/custom_button.dart';
import 'package:derma_care/core/presentation/widgets/gradient_scaffold.dart';
import 'package:derma_care/onboarding/presentation/widgets/feature_card.dart';
import 'package:flutter/material.dart';

class OnboardingFeatures extends StatelessWidget {
  const OnboardingFeatures({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              'Key Features',
              style: TextStyle(
                fontFamily: FontFamily.roboto,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 48),
            FeatureCard(
              icon: Assets.icons.camera.svg(),
              title: 'AI Skin Analysis',
              description: 'Use your camera for instant skin condition identification.',
            ),
            const SizedBox(height: 32),
            FeatureCard(
              icon: Assets.icons.heart.svg(),
              title: 'Personalized Care Recommendations',
              description: 'Receive tailored solutions for issues like redness, pimples, and acne scars.',
            ),
            const SizedBox(height: 32),
            FeatureCard(
              icon: Assets.icons.lock.svg(),
              title: 'Secure & Private',
              description: 'Your images and data are safe with us.',
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {},
              text: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
