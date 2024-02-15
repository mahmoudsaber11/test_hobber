import 'package:dio/dio.dart';
import 'package:test_/core/api/end_points.dart';

import 'package:test_/login/data/repo/email_repo.dart';
import 'package:test_/login/model/email_model.dart';

class EmailRepository implements EmailRepo {
  final Dio _dio = Dio();

  @override
  Future<List<Email>> getEmails() async {
    try {
      final response = await _dio.get(
        "https://emergingideas.ae/test_apis/read.php?email=mikehsch@gmail.com",
      );
      if (response.statusCode == 200) {
        final List<dynamic> emailsJson = response.data;
        print(emailsJson);
        final List<Email> emails =
            emailsJson.map((json) => Email.fromJson(json)).toList();
        print(emails);
        return emails;
      } else {
        throw Exception('Failed to fetch emails');
      }
    } catch (e) {
      throw Exception('Failed to fetch emails: $e');
    }
  }

  @override
  Future<void> deleteEmail(int emailId) async {
    try {
      final response =
          await _dio.delete('${EndPoints.deleteEmail}?emailId=$emailId');
      if (response.statusCode != 200) {
        throw Exception('Failed to delete email');
      }
    } catch (e) {
      throw Exception('Failed to delete email: $e');
    }
  }

  @override
  Future<void> postEmail(String email) async {
    try {
      final response = await _dio.post(
        EndPoints.postEmail,
        data: {'email': email},
      );
      if (response.statusCode == 200) {
        print('Email uploaded successfully');
      } else {
        throw Exception('Failed to post email');
      }
    } catch (e) {
      throw Exception('Failed to post email: $e');
    }
  }

  @override
  Future<void> editEmail(
    int emailId,
    String email,
  ) async {
    try {
      final response = await _dio
          .put('${EndPoints.editEmail}?emailId=$emailId', data: {email: email});
      if (response.statusCode != 200) {
        throw Exception('Failed to edit email');
      }
    } catch (e) {
      throw Exception('Failed to edit email: $e');
    }
  }
}
