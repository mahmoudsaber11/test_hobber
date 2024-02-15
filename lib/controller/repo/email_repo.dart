import 'package:test_/models/email_model.dart';

abstract class EmailRepo {
  Future<List<Email>> getEmails();
  Future<void> deleteEmail(int emailId);
  Future<void> postEmail(String email);
  Future<void> editEmail(int emailId, String email);
}