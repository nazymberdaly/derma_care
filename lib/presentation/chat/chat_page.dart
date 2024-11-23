import 'package:derma_care/core/constants/app_colors.dart';
import 'package:derma_care/core/generated/assets.gen.dart';
import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:derma_care/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({
    required this.skinType,
    required this.skinConcern,
    super.key,
  });

  final String skinType;
  final String skinConcern;

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> messages = [];
  final _user = types.User(
    id: UniqueKey().toString(),
  );

  void _handleSendPressed(types.PartialText message) {
    final textMessage = types.TextMessage(
      id: UniqueKey().toString(),
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      text: message.text,
    );

    _addMessage(textMessage);
  }

  void _addMessage(types.Message message) {
    setState(() {
      messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'DermCare Assistant',
              style: TextStyle(
                fontFamily: FontFamily.roboto,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.secondaryDark,
              ),
            ),
            Text(
              'AI-powered skincare insights',
              style: TextStyle(
                fontFamily: FontFamily.inter,
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.secondary,
              ),
            ),
          ],
        ),
        centerTitle: false,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color(0xFFCCCCCC),
              ),
            ),
          ),
        ),
      ),
      body: Chat(
        theme: DefaultChatTheme(
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
          messageMaxWidth: context.mediaSize.width * 0.65,
          inputBackgroundColor: Colors.white,
          inputTextStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: AppColors.secondaryDark,
          ),
          inputTextColor: AppColors.secondaryDark,
          inputTextCursorColor: AppColors.primary,
          inputTextDecoration: const InputDecoration(
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
              borderSide: BorderSide(
                color: Color(0xFFCCCCCC),
              ),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFCCCCCC),
              ),
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
          ),
          sendButtonIcon: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Assets.icons.send.svg(),
          ),
        ),
        scrollPhysics: const BouncingScrollPhysics(),
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        messages: messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}
