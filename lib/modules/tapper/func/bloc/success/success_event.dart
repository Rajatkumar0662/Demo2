part of 'success_bloc.dart';

class SuccessEvent extends Equatable {
  const SuccessEvent();

  @override
  List<Object> get props => [];
}

class SuccessCallEvent extends SuccessEvent {}

class ResetCallEvent extends SuccessEvent {}

class InitialEvent extends SuccessEvent {}
