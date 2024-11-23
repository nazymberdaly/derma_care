// import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:derma_care/core/presentation/widgets/custom_button.dart';
import 'package:derma_care/core/presentation/widgets/gradient_scaffold.dart';
import 'package:derma_care/experience-setup/presentation/widgets/question_card.dart';
import 'package:flutter/material.dart';

class PersonalizationPage extends StatefulWidget {
  const PersonalizationPage({super.key});

  @override
  State<PersonalizationPage> createState() => _PersonalizationPageState();
}

class _PersonalizationPageState extends State<PersonalizationPage> {
  String? selectedSkinConcern;
  String? selectedSkinType;

  bool get canContinue => selectedSkinConcern != null && selectedSkinType != null;

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const Text(
              "Let's Personalize Your Experience",
              style: TextStyle(
                // fontFamily: FontFamily.roboto,
                fontSize: 26,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 32),
            QuestionCard(
              question: "What's your primary skin concern?",
              options: const [
                'Acne',
                'Scars',
                'Redness',
                'Other',
              ],
              selectedOption: selectedSkinConcern,
              onOptionSelected: (option) => setState(() => selectedSkinConcern = option),
            ),
            const SizedBox(height: 16),
            QuestionCard(
              question: "What's your skin type?",
              options: const [
                'Oily',
                'Dry',
                'Normal',
                'Sensitive',
              ],
              selectedOption: selectedSkinType,
              onOptionSelected: (option) => setState(() => selectedSkinType = option),
            ),
            const Spacer(),
            CustomButton(
              onPressed: canContinue ? () {} : null,
              text: 'Save & Continue',
            ),
          ],
        ),
      ),
    );
  }
}
