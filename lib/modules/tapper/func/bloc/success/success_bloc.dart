import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/repository/counter_repo.dart';

part 'success_event.dart';
part 'success_state.dart';

class SuccessBloc extends Bloc<SuccessEvent, SuccessState> {
  final CounterRepository repository;
  SuccessBloc({required this.repository}) : super(const SuccessInitial()) {
    on<SuccessEvent>((event, emit) {});

    on<SuccessCallEvent>(_successHandler);

    on<InitialEvent>(_initalHandler);

    on<ResetCallEvent>(_resetHandler);

    // initalise
    add(InitialEvent());
  }

  _resetHandler(event, emit) async {
    // reset counter
    final counter = await repository.resetCounter();
    // update state
    emit(SuccessInitial(successCounter: counter));
  }

  _initalHandler(event, emit) async {
    // get counter
    final counter = await repository.getCounter();

    // update state
    emit(SuccessInitial(successCounter: counter ?? 0));
  }

  _successHandler(event, emit) async {
    final counter = await repository.setCounter();
    final current = state;
    if (current is SuccessInitial) {
      emit(current.copyWith(successCounter: counter));
    }
  }
}
