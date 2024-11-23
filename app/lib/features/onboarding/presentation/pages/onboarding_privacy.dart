import 'package:derma_care/core/constants/app_colors.dart';
import 'package:derma_care/core/generated/assets.gen.dart';
import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:derma_care/core/presentation/widgets/custom_button.dart';
import 'package:derma_care/core/presentation/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingPrivacy extends StatelessWidget {
  const OnboardingPrivacy({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: AppColors.primaryLightest,
                shape: BoxShape.circle,
              ),
              child: Assets.icons.security.svg(),
            ),
            const SizedBox(height: 32),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'We Care About Your Privacy',
                style: TextStyle(
                  fontFamily: FontFamily.roboto,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 4),
                    blurRadius: 6,
                    spreadRadius: -1,
                  ),
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    offset: const Offset(0, 2),
                    blurRadius: 4,
                    spreadRadius: -2,
                  ),
                ],
              ),
              padding: const EdgeInsets.all(16),
              child: const Text(
                '''
DermCare uses your camera to analyze your skin condition. We take your privacy seriously:

• Images are processed locally on your device
• We do not store or share your images without consent
• Your data is encrypted and secure
''',
                style: TextStyle(
                  fontFamily: FontFamily.inter,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                  height: 2.5,
                ),
              ),
            ),
            const Spacer(),
            CustomButton(
              onPressed: () => context.go('/experience-setup'),
              text: 'Next',
            ),
          ],
        ),
      ),
    );
  }
}
