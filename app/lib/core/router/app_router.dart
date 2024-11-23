import 'package:derma_care/features/experience-setup/presentation/pages/completion_page.dart';
import 'package:derma_care/features/experience-setup/presentation/pages/personalization_page.dart';
import 'package:derma_care/features/onboarding/presentation/pages/onboarding_features.dart';
import 'package:derma_care/features/onboarding/presentation/pages/onboarding_privacy.dart';
import 'package:derma_care/features/onboarding/presentation/pages/onboarding_welcome.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  final router = GoRouter(
    initialLocation: '/onboarding',
    routes: [
      GoRoute(
        path: '/onboarding',
        builder: (_, __) => const OnboardingWelcome(),
        routes: [
          GoRoute(
            path: 'features',
            builder: (_, __) => const OnboardingFeatures(),
            routes: [
              GoRoute(
                path: 'privacy',
                builder: (_, __) => const OnboardingPrivacy(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/experience-setup',
        builder: (_, __) => const PersonalizationPage(),
        routes: [
          GoRoute(
            path: 'completion',
            builder: (_, state) => CompletionPage(
              skinConcern: state.uri.queryParameters['skinConcern']!,
              skinType: state.uri.queryParameters['skinType']!,
            ),
          ),
        ],
      ),
    ],
  );
}
