import 'package:equatable/equatable.dart';

class Question extends Equatable {
  const Question({
    required this.id,
    required this.text,
    required this.answers,
  });

  final String id;

  final String text;

  final List<String> answers;

  const Question.empty({this.id = '', this.text = '', this.answers = const []});

  @override
  List<Object?> get props => [id, text, answers];
}
