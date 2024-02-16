import 'package:equatable/equatable.dart';

class PostParams extends Equatable {
  final String email;
  final String? description;
  final String? title;
  final String? imgLink;

  const PostParams(
      {required this.email, this.description, this.title, this.imgLink});

  @override
  List<Object?> get props => [email, description, title, imgLink];
}
