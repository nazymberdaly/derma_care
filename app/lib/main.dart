import 'package:derma_care/app.dart';
import 'package:derma_care/core/router/app_router.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    App(
      router: AppRouter().router,
    ),
  );
}
