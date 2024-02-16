import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/cubit/email_cubit/email_cubit.dart';
import 'package:test_/models/email_model.dart';

class EditView extends StatelessWidget {
  final Email email;

  const EditView({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final EmailCubit cubit = BlocProvider.of<EmailCubit>(context);
    cubit.emailController.text = email.email!;
    cubit.titleController.text = email.title!;
    cubit.descriptionController.text = email.description!;
    cubit.imgLinkController.text = email.imgLink!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: cubit.emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: cubit.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: cubit.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextFormField(
              controller: cubit.imgLinkController,
              decoration: const InputDecoration(labelText: 'ImgLink'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () => _editEmail(cubit, context),
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );
  }

  void _editEmail(EmailCubit cubit, BuildContext context) {
    if (cubit.formKey.currentState!.validate()) {
      cubit
          .editEmail(
              id: email.id,
              email: cubit.emailController.text,
              description: cubit.descriptionController.text,
              title: cubit.titleController.text,
              imglink: cubit.imgLinkController.text)
          .then((value) {
        cubit.getEmails();
        Navigator.of(context).pop();
      }).catchError((error) {});
    }
  }
}
