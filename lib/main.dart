import 'package:banking_app/Cubits/Bloc%20Observer/bloc_observer.dart';
import 'package:banking_app/Cubits/Home%20Page%20Cubit/home_page_cubit.dart';
import 'package:banking_app/Modules/Home%20Screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  Bloc.observer = MyBlocObserver();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomePageCubit()..createDatabase(),
      child: MaterialApp(
        title: 'Banking Application',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
