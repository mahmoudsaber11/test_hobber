import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/repo/email_repo_impl.dart';
import 'package:test_/controller/cubit/email_cubit/email_state.dart';
import 'package:test_/core/entities/post_params.dart';

class EmailCubit extends Cubit<EmailState> {
  final EmailRepository repository;
  EmailCubit(this.repository) : super(EmailInitial()) {
    _initFormAttributes();
  }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imgLinkController = TextEditingController();
  late final GlobalKey<FormState> formKey;

  void _initFormAttributes() {
    formKey = GlobalKey<FormState>();
  }

  Future<void> dispose() {
    _disposeController();
    return super.close();
  }

  void _disposeController() {
    emailController.dispose();
    titleController.dispose();
    descriptionController.dispose();
    imgLinkController.dispose();
  }

  Future<void> getEmails() async {
    emit(EmailLoading());
    try {
      final emails = await repository.getEmails();
      emit(EmailLoaded(emails));
    } catch (e) {
      emit(EmailError('Failed to fetch emails: $e'));
    }
  }

  Future<void> postEmail({required PostParams postParams}) async {
    try {
      await repository.postEmail(
          postParams: PostParams(
              email: postParams.email,
              description: postParams.description,
              title: postParams.title,
              imgLink: postParams.imgLink));
      emit(EmailPosted());
    } catch (e) {
      emit(EmailError('Failed to post email: $e'));
    }
  }

  Future<void> editEmail(
      {required String email,
      required String description,
      required String title,
      required String imglink,
      required int id}) async {
    emit(EmailLoading());
    try {
      await repository.editEmail(email, description, title, imglink, id);
      emit(EmailEdit());
    } catch (e) {
      emit(EmailError('Failed to edit email: $e'));
    }
  }
}
