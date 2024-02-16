import 'package:test_/core/api/entities/post_params.dart';
import 'package:test_/models/email_model.dart';

abstract class EmailRepo {
  Future<List<Email>> getEmails();
  Future<void> deleteEmail(int emailId, String email);
  Future<void> postEmail({required PostParams postParams});
  Future<void> editEmail(
      String email, String description, String title, String imglink, int id);
}
