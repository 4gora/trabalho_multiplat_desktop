import 'package:flutter/material.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dart:io';
import 'screens/tela_login.dart';

void main() async {
  // Inicialização assíncrona do Flutter
  WidgetsFlutterBinding.ensureInitialized();

  // Configuração do sqflite para Windows
  if (Platform.isWindows) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  // Executa o app com tela de login
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false, // Remove banner de debug
      home: LoginScreen(), // Tela inicial de login
    ),
  );
}
