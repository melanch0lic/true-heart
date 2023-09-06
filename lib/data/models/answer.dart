import 'package:equatable/equatable.dart';

class Answer extends Equatable {
  const Answer({
    required this.userId,
    required this.text,
    required this.timestamp,
  });

  final String userId;

  final String text;

  final String timestamp;

  const Answer.empty({this.userId = '', this.text = '', this.timestamp = ''});

  @override
  List<Object?> get props => [userId, text, timestamp];
}
