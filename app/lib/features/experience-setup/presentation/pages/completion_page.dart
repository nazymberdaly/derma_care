import 'package:derma_care/core/constants/app_colors.dart';
import 'package:derma_care/core/generated/assets.gen.dart';
import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:derma_care/core/presentation/widgets/custom_button.dart';
import 'package:derma_care/core/presentation/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';

class CompletionPage extends StatelessWidget {
  const CompletionPage({
    required this.skinConcern,
    required this.skinType,
    super.key,
  });

  final String skinConcern;
  final String skinType;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              backgroundImage: Assets.images.experienceSetupCompletion.provider(),
            ),
            const SizedBox(height: 32),
            const Text(
              "You're Ready to Glow!",
              style: TextStyle(
                fontFamily: FontFamily.roboto,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Start exploring tailored insights and skincare tips',
              style: TextStyle(
                fontFamily: FontFamily.inter,
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              ),
            ),
            const SizedBox(height: 32),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Important: DermCare provides general advice based on AI analysis. For accurate diagnosis and treatment, always consult a licensed dermatologist.',
                style: TextStyle(
                  fontFamily: FontFamily.inter,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () {},
              text: 'Start Now',
              isExpanded: true,
            ),
            const SizedBox(height: 16),
            const Text(
              'Your personalized skin care journey begins here',
              style: TextStyle(
                fontFamily: FontFamily.inter,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
