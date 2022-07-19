import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:bakerie_haven/models/todo.dart';
part 'todos_event.dart';
part 'todos_state.dart';

enum TodoAction { Increment, Decrement, Reset } //metho

class TodosBloc extends Bloc<TodosEvent, TodosState> {
  /*List<Todo> todos = [
    Todo(id: '1', talk: 'Sample Todo', description: 'This is a test To Do'),
    Todo(id: '1', talk: 'Sample Todo', description: 'This is a test To Do'),
  ];*/
  TodosBloc() : super(TodosInitial()) {
    on<TodosEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
