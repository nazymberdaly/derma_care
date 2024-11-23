import 'package:derma_care/core/constants/app_colors.dart';
import 'package:derma_care/presentation/chat/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://cyfdlsalkxtwvsrofrek.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN5ZmRsc2Fsa3h0d3Zzcm9mcmVrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzIzMzYxNDYsImV4cCI6MjA0NzkxMjE0Nn0.IQjoG4KVH0P82goryop7I2rlF7ZEgE9VFEtLqeYymP4',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: AppColors.primary,
        colorScheme: const ColorScheme.light(
          primary: AppColors.primary,
        ),
        useMaterial3: true,
      ),
      home: const ChatPage(
        skinType: '',
        skinConcern: '',
      ),
    );
  }
}
