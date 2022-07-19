//mport 'package:flutter/material.dart';

class Todo {
  final String id;
  final String task;
  final String description;
  bool? isCancelled;
  bool? isCompleted;
  Todo({required this.id, required this.task, required this.description});
}
