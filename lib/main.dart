import 'package:curreny_converter/home/home.dart';
import 'package:data_repository/data_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AppView(
      dataRepository: DataRepository(),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({required this.dataRepository, super.key});

  final DataRepository dataRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => dataRepository,
      child: MaterialApp(
        title: 'Currency Converter',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF2C2C84)),
          useMaterial3: true,
        ),
        home: const TabBarPage(),
      ),
    );
  }
}
