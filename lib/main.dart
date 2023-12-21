import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_keyboard_pc/bloc/scripts_bloc/scripts_bloc.dart';
import 'package:smart_keyboard_pc/screens/home/home.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  if (File("smart_keyboard_background.exe").existsSync()) {
    Process.run('./smart_keyboard_background.exe', ['']);
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => ScriptsBloc()..add(ScriptsInitEvent())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'SmartKeyboardApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFBF00)),
          useMaterial3: true,
        ),
        home: const Home(),
      ),
    );
  }
}
