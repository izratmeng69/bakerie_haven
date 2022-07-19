import 'package:equatable/equatable.dart';

class Todo extends Equatable {
  final String id;
  final String task;
  final String description;
  bool? isCompleted;
  bool? isCancelled;
  //List<Todo> sample;
  Todo({
    required this.id,
    required this.task,
    required this.description,
    this.isCancelled,
    this.isCompleted,
    //  required this.sample,
  }) {
    isCancelled = null ?? false;
    isCompleted = null ?? false;
  }
  Todo CopyWith(
      {String? id,
      String? task,
      String? description,
      bool? isCompleted,
      bool? isCancelled}) {
    return Todo(
        id: id ?? this.id,
        task: task ?? this.task,
        description: description ?? this.description,
        isCancelled: isCancelled ?? this.isCancelled,
        isCompleted: this.isCompleted);
  }

  @override
  List<Object?> get props => [
        id,
        task,
        description,
        isCompleted,
        isCancelled,
      ];
}
