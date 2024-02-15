import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/cubit/email_cubit.dart';
import 'package:test_/controller/cubit/email_state.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final EmailCubit cubit = BlocProvider.of<EmailCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Email App'),
      ),
      body: BlocBuilder<EmailCubit, EmailState>(
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
                  title: Text(email.email!),
                  leading: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.edit)),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      cubit.deleteEmail(email.id!);
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Add Email'),
                  content: TextField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    onChanged: (value) {
                      cubit.setEmail(value);
                    },
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        final enteredEmail = cubit.email;
                        cubit.postEmail(enteredEmail).then((value) {
                          cubit.getEmails();
                          Navigator.of(context).pop();
                        }).catchError((error) {
                          print('Failed to add email: $error');
                        });
                      },
                      child: const Text('Add'),
                    ),
                  ],
                );
              });
        },
        tooltip: 'Add Email',
        child: const Icon(Icons.add),
      ),
    );
  }
}
