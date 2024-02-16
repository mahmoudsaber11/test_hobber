import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_/controller/cubit/delete_email/delete_email_state.dart';
import 'package:test_/controller/repo/email_repo_impl.dart';

class DeleteEmailCubit extends Cubit<DeleteEmailState> {
  final EmailRepository repository;
  DeleteEmailCubit(this.repository) : super(DeleteEmailInitial());

  Future<void> deleteEmail(int emailId, String email) async {
    try {
      emit(DeleteEmailLoading());
      await repository.deleteEmail(emailId, email);
      emit(DeleteEmails());
    } catch (e) {
      emit(DeleteEmailError('Failed to delete email: $e'));
    }
  }
}
