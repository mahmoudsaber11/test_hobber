import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/login/data/repo/email_repo_impl.dart';
import 'package:test_/login/presentation/cubit/email_cubit.dart';
import 'package:test_/login/presentation/view/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmailCubit(EmailRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Email App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const MyHomePage(),
      ),
    );
  }
}
