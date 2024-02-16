import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/cubit/email_cubit.dart';
import 'package:test_/controller/cubit/email_state.dart';

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
                      cubit.editEmail(
                          id: 610,
                          email: cubit.emailController.text,
                          description: "fdsfdsf",
                          title: "fsdfdsfsf",
                          imglink: "fdsfsdffs");
                    },
                    icon: const Icon(Icons.edit)),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    cubit.deleteEmail(email.id!, email.email!);
                  },
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
