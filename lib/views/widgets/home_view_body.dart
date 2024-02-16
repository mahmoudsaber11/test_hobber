import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/cubit/delete_email/delete_email_cubit.dart';
import 'package:test_/controller/cubit/delete_email/delete_email_state.dart';
import 'package:test_/controller/cubit/email_cubit/email_cubit.dart';
import 'package:test_/controller/cubit/email_cubit/email_state.dart';
import 'package:test_/controller/repo/email_repo_impl.dart';
import 'package:test_/views/edit_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailCubit cubit = BlocProvider.of<EmailCubit>(context);
    return BlocBuilder<EmailCubit, EmailState>(
      builder: (context, state) {
        if (state is EmailInitial) {
          cubit.getEmails();
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EmailLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is EmailLoaded) {
          final emails = state.emails;
          return ListView.builder(
            itemCount: emails.length,
            itemBuilder: (context, index) {
              final email = emails[index];
              return ListTile(
                title: Text(email.email ?? ''),
                leading: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context, // Make sure you're passing the context
                        MaterialPageRoute(
                          builder: (context) => EditView(
                            email: email,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit)),
                trailing: BlocProvider(
                  create: (context) => DeleteEmailCubit(EmailRepository()),
                  child: BlocBuilder<DeleteEmailCubit, DeleteEmailState>(
                    builder: (context, state) {
                      if (state is DeleteEmails) {
                        cubit
                            .getEmails(); // إعادة تحميل البريد الإلكتروني بعد الحذف
                      }
                      return IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<DeleteEmailCubit>(context)
                              .deleteEmail(email.id, email.email!);
                        },
                      );
                    },
                  ),
                ),
              );
            },
          );
        } else if (state is EmailError) {
          return Center(
            child: Text('Error: ${state.message}'),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
