import 'package:equatable/equatable.dart';

abstract class DeleteEmailState extends Equatable {
  const DeleteEmailState();

  @override
  List<Object> get props => [];
}

class DeleteEmailInitial extends DeleteEmailState {}

class DeleteEmailLoading extends DeleteEmailState {}

class DeleteEmails extends DeleteEmailState {}

class DeleteEmailError extends DeleteEmailState {
  final String message;

  const DeleteEmailError(this.message);

  @override
  List<Object> get props => [message];
}
