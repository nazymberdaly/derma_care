import 'package:derma_care/core/constants/app_colors.dart';
// import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  const QuestionCard({
    required this.question,
    required this.options,
    required this.selectedOption,
    required this.onOptionSelected,
    super.key,
  });

  final String question;
  final List<String> options;
  final String? selectedOption;
  final ValueChanged<String> onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: const TextStyle(
              // fontFamily: FontFamily.inter,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          ...List.generate(
            (options.length / 2).ceil(),
            (index) => Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _OptionCard(
                        text: options[index * 2],
                        isSelected: selectedOption == options[index * 2],
                        onOptionSelected: () => onOptionSelected(
                          options[index * 2],
                        ),
                      ),
                    ),
                    if (index * 2 + 1 < options.length) ...[
                      const SizedBox(width: 8),
                      Expanded(
                        child: _OptionCard(
                          text: options[index * 2 + 1],
                          isSelected: selectedOption == options[index * 2 + 1],
                          onOptionSelected: () => onOptionSelected(
                            options[index * 2 + 1],
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                if (index != (options.length / 2).ceil() - 1) const SizedBox(height: 8),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OptionCard extends StatelessWidget {
  const _OptionCard({
    required this.text,
    required this.isSelected,
    required this.onOptionSelected,
  });

  final String text;
  final bool isSelected;
  final VoidCallback onOptionSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onOptionSelected,
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primaryLight : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            width: 2,
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Text(
          text,
          style: const TextStyle(
            // fontFamily: FontFamily.inter,
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
