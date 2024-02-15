import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/repo/email_repo_impl.dart';
import 'package:test_/controller/cubit/email_state.dart';

class EmailCubit extends Cubit<EmailState> {
  final EmailRepository repository;
  String email = '';
  EmailCubit(this.repository) : super(EmailInitial());

  void setEmail(String newEmail) {
    email = newEmail;
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

  Future<void> deleteEmail(int emailId) async {
    try {
      await repository.deleteEmail(emailId);
      emit(EmailDeleted());
    } catch (e) {
      emit(EmailError('Failed to delete email: $e'));
    }
  }

  Future<void> postEmail(String email) async {
    try {
      await repository.postEmail(email);
      emit(EmailPosted());
    } catch (e) {
      emit(EmailError('Failed to post email: $e'));
    }
  }

  Future<void> editEmail(int emailId, String email) async {
    emit(EmailLoading());
    try {
      await repository.editEmail(emailId, email);
      emit(EmailEdit());
    } catch (e) {
      emit(EmailError('Failed to edit email: $e'));
    }
  }
}
