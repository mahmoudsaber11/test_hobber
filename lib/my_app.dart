import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/repo/email_repo_impl.dart';
import 'package:test_/controller/cubit/email_cubit.dart';
import 'package:test_/views/home_view.dart';

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
        home: const HomeView(),
      ),
    );
  }
}
