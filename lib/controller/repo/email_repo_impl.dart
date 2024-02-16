import 'package:dio/dio.dart';
import 'package:test_/core/api/end_points.dart';

import 'package:test_/controller/repo/email_repo.dart';
import 'package:test_/core/api/entities/edit_params.dart.dart';
import 'package:test_/core/api/entities/post_params.dart';
import 'package:test_/models/email_model.dart';

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
        final List<Email> emails =
            emailsJson.map((json) => Email.fromJson(json)).toList();
        return emails;
      } else {
        throw Exception('Failed to fetch emails');
      }
    } catch (e) {
      throw Exception('Failed to fetch emails: $e');
    }
  }

  @override
  Future<void> deleteEmail(int emailId, String email) async {
    try {
      final response = await _dio.delete(
          "${EndPoints.deleteEmail}?email=$email&id=$emailId",
          queryParameters: {"email": email, "id": emailId});
      if (response.statusCode != 200) {
        throw Exception('Failed to delete email');
      }
    } catch (e) {
      throw Exception('Failed to delete email: $e');
    }
  }

  @override
  Future<void> postEmail({required PostParams postParams}) async {
    try {
      final response = await _dio.post(EndPoints.postEmail, data: {
        "email": postParams.email,
        "description": postParams.description,
        "title": postParams.title,
        "img_link": postParams.imgLink
      });
      if (response.statusCode == 200) {
      } else {
        throw Exception('Failed to post email');
      }
    } catch (e) {
      throw Exception('Failed to post email: $e');
    }
  }

  @override
  Future<void> editEmail(String email, String description, String title,
      String imglink, int id) async {
    try {
      final response = await _dio.put(
        "${EndPoints.editEmail}?email=$email&id=$id&description=$description&img_link=$imglink&title=$title",
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to edit email');
      }
    } catch (e) {
      throw Exception('Failed to edit email: $e');
    }
  }
}
