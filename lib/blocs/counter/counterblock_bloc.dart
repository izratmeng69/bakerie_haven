import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counterblock_event.dart';
part 'counterblock_state.dart';

class CounterblockBloc extends Bloc<CounterblockEvent, CounterblockState> {
  CounterblockBloc() : super(CounterblockInitial()) {
    on<CounterblockEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
