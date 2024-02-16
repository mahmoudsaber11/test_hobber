import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/cubit/email_cubit.dart';
import 'package:test_/controller/cubit/email_state.dart';
import 'package:test_/core/api/entities/post_params.dart';
import 'package:test_/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailCubit cubit = BlocProvider.of<EmailCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email App'),
      ),
      body: const HomeViewBody(),
      floatingActionButton: BlocBuilder<EmailCubit, EmailState>(
        builder: (context, state) {
          if (state is EmailLoaded) {}
          return Form(
            key: cubit.formKey,
            child: _floatingButton(context, cubit),
          );
        },
      ),
    );
  }

  FloatingActionButton _floatingButton(BuildContext context, EmailCubit cubit) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Email'),
                content: Column(
                  children: [
                    TextField(
                      controller: cubit.emailController,
                      decoration: const InputDecoration(labelText: 'Email'),
                    ),
                    TextField(
                      controller: cubit.titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                    ),
                    TextField(
                      controller: cubit.descriptionController,
                      decoration:
                          const InputDecoration(labelText: 'Description'),
                    ),
                    TextField(
                      controller: cubit.imgLinkController,
                      decoration: const InputDecoration(labelText: 'ImgLink'),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () => _email(cubit, context),
                    child: const Text('Add'),
                  ),
                ],
              );
            });
      },
      tooltip: 'Add Email',
      child: const Icon(Icons.add),
    );
  }

  void _email(EmailCubit cubit, BuildContext context) {
    if (cubit.formKey.currentState!.validate()) {
      cubit
          .postEmail(
              postParams: PostParams(
                  email: cubit.emailController.text,
                  title: cubit.titleController.text,
                  description: cubit.descriptionController.text,
                  imgLink: cubit.imgLinkController.text))
          .then((value) {
        cubit.getEmails();
        Navigator.of(context).pop();
      }).catchError((error) {
        print('Failed to add email: $error');
      });
    }
  }
}
