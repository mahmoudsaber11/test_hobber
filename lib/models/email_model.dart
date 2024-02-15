class Email {
  final int? id;
  final String? email;
  final String? message;

  Email({required this.id, required this.email, required this.message});

  factory Email.fromJson(Map<String, dynamic> json) {
    return Email(
      id: json['id'],
      email: json['email'],
      message: json['message'],
    );
  }
}
