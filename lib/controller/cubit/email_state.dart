import 'package:equatable/equatable.dart';
import 'package:test_/models/email_model.dart';

abstract class EmailState extends Equatable {
  const EmailState();

  @override
  List<Object> get props => [];
}

class EmailInitial extends EmailState {}

class EmailLoading extends EmailState {}

class EmailLoaded extends EmailState {
  final List<Email> emails;

  const EmailLoaded(this.emails);

  @override
  List<Object> get props => [emails];
}

class DeleteEmails extends EmailState {}

class EmailPosted extends EmailState {}

class EmailEdit extends EmailState {}

class EmailError extends EmailState {
  final String message;

  const EmailError(this.message);

  @override
  List<Object> get props => [message];
}
