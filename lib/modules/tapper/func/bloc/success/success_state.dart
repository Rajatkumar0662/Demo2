part of 'success_bloc.dart';

class SuccessState extends Equatable {
  const SuccessState();

  @override
  List<Object?> get props => [];
}

class SuccessInitial extends SuccessState {
  final int successCounter;
  const SuccessInitial({
    this.successCounter = 0,
  });

  @override
  List<Object?> get props => [successCounter];

  SuccessInitial copyWith({
    int? successCounter,
  }) {
    return SuccessInitial(
      successCounter: successCounter ?? this.successCounter,
    );
  }
}
