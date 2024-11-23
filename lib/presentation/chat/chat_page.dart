import 'dart:developer';

import 'package:derma_care/core/constants/app_colors.dart';
import 'package:derma_care/core/generated/fonts.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:derma_care/presentation/chat/theme/chat_theme.dart';

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
  final List<types.Message> _messages = [];
  final _user = const types.User(id: 'user');
  final _assistant = const types.User(
    id: 'assistant',
    firstName: 'DermCare',
    lastName: 'Assistant',
  );
  bool _isLoading = false;

  String _formatPhotoAnalysis(String analysis) {
    return analysis.trim();
  }

  String _formatObservations(List<dynamic> observations) {
    return '🔍 **Key Observations:**\n\n${observations.map((o) => "• $o").join("\n")}';
  }

  String _formatRecommendations(List<dynamic> recommendations) {
    final recommendationsText = recommendations.map((section) {
      final details = section['details'] as List<String>;
      return '''
📍 **${section['title']}:**
${details.map((d) => "  • $d").join("\n")}''';
    }).join("\n\n");

    return '💡 **Personalized Recommendations:**\n$recommendationsText';
  }

  @override
  void initState() {
    super.initState();
    _activateAssistant();
  }

  Future<void> _activateAssistant() async {
    try {
      setState(() => _isLoading = true);

      final images = await ImagePicker().pickMultiImage();
      if (images.length != 3) {
        _showError('Please select exactly 3 images');
        return;
      }

      await _handleImageMessage(images[0]);
      await _processImagesWithAI(images);
    } catch (e, st) {
      log(e.toString(), stackTrace: st);
      _showError('An error occurred: ${e.toString()}');
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _handleImageMessage(XFile image) async {
    final bytes = await image.readAsBytes();
    final img = await decodeImageFromList(bytes);

    _addMessage(
      types.ImageMessage(
        id: UniqueKey().toString(),
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        name: image.name,
        size: bytes.length,
        uri: image.path,
        width: img.width.toDouble(),
        height: img.height.toDouble(),
      ),
    );
  }

  Future<void> _processImagesWithAI(List<XFile> images) async {
    final files = await Future.wait([
      for (var i = 0; i < 3; i++)
        MultipartFile.fromPath(
          ['face_front', 'face_left', 'face_right'][i],
          images[i].path,
        ),
    ]);

    final res = await Supabase.instance.client.functions.invoke(
      'generate-analysis',
      files: files,
    );

    final photoAnalysis = res.data['photoAnalysis'];
    final observations = res.data['observations'];
    final recommendations = res.data['recommendations'];

    _addMessage(
      types.TextMessage(
        author: _assistant,
        id: UniqueKey().toString(),
        text: _formatPhotoAnalysis(photoAnalysis),
      ),
    );
    _addMessage(
      types.TextMessage(
        author: _assistant,
        id: UniqueKey().toString(),
        text: _formatObservations(observations),
      ),
    );
    _addMessage(
      types.TextMessage(
        author: _assistant,
        id: UniqueKey().toString(),
        text: _formatRecommendations(recommendations),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

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
      _messages.insert(0, message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Chat(
        typingIndicatorOptions: TypingIndicatorOptions(
          typingUsers: _isLoading ? [_assistant] : [],
        ),
        theme: CustomChatTheme.create(context),
        messages: _messages,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
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
    );
  }
}
