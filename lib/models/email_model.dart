import 'package:equatable/equatable.dart';

class Email extends Equatable {
  final int? id;
  final String? email;
  final String? message;
  final String? title;
  final String? description;
  final String? imgLink;
  const Email(
      {required this.id,
      required this.email,
      required this.message,
      required this.description,
      required this.imgLink,
      required this.title});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: json['id'],
      email: json['email'],
      message: json['message'],
      title: json['title'],
      description: json['description'],
      imgLink: json['img_link'],
    );
  }

  @override
  List<Object?> get props => [id, email, message, title, description, imgLink];
}
