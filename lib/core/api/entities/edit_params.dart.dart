import 'package:equatable/equatable.dart';

class EditParams extends Equatable {
  final String email;
  final String? description;
  final String? title;
  final String? imgLink;
  final int? id;

  const EditParams(
      {required this.email,
      this.description,
      this.title,
      this.imgLink,
      this.id});

  @override
  List<Object?> get props => [email, description, title, imgLink, id];
}
