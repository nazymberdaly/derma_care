import 'package:flutter/material.dart';
import 'package:derma_care/core/constants/app_colors.dart';
import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:derma_care/core/generated/assets.gen.dart';

class CustomChatTheme {
  static DefaultChatTheme create(BuildContext context) {
    return DefaultChatTheme(
      secondaryColor: AppColors.primaryLight,
      receivedMessageBodyTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryDark,
      ),
      primaryColor: AppColors.primary,
      sentMessageBodyTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      messageMaxWidth: MediaQuery.of(context).size.width * 0.65,
      inputBackgroundColor: Colors.white,
      inputTextStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryDark,
      ),
      inputTextColor: AppColors.secondaryDark,
      inputTextCursorColor: AppColors.primary,
      inputTextDecoration: _buildInputDecoration(),
      sendButtonIcon: _buildSendButton(),
    );
  }

  static InputDecoration _buildInputDecoration() {
    return const InputDecoration(
      alignLabelWithHint: true,
      label: Text(
        'Type your concern here...',
        style: TextStyle(
          fontFamily: FontFamily.inter,
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: Color(0xFFCCCCCC),
        ),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Color(0xFFCCCCCC)),
        borderRadius: BorderRadius.all(Radius.circular(32)),
      ),
    );
  }

  static Widget _buildSendButton() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        shape: BoxShape.circle,
      ),
      child: Assets.icons.send.svg(),
    );
  }
}
