//import 'package:bakerie_haven/models/todos.dart';
part of 'todos_bloc.dart';

//import 'package:equatable/equatable.dart';
abstract class TodosState extends Equatable {
  const TodosState();
  
  @override
  List<Object> get props => [];
}

class TodosInitial extends TodosState {
  final List<Todo> todos;
  const TodosInitial({this.todos = const <Todo>[]});
}

class TodosLoading extends TodosState {}

class TodosLoaded extends TodosState {
  final List<Todo> todos;
  const TodosLoaded({this.todos = const <Todo>[]});
}
