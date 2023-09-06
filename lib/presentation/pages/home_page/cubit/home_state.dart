part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

final class HomeState extends Equatable {
  const HomeState({
    this.questionIndex = -1,
    this.questions = const [],
    this.isAnswered = false,
    this.status = HomeStatus.initial,
    this.isAnswerMode = false,
    this.answerText = '',
    this.errorMessage,
  });

  final int questionIndex;
  final List<Question> questions;
  final bool isAnswered;
  final HomeStatus status;
  final bool isAnswerMode;
  final String answerText;
  final String? errorMessage;

  @override
  List<Object?> get props => [questionIndex, questions, isAnswered, status, isAnswerMode, answerText, errorMessage];

  HomeState copyWith(
      {int? questionIndex,
      List<Question>? questions,
      bool? isAnswered,
      HomeStatus? status,
      bool? isAnswerMode,
      String? answerText,
      String? errorMessage}) {
    return HomeState(
      questionIndex: questionIndex ?? this.questionIndex,
      questions: questions ?? this.questions,
      isAnswered: isAnswered ?? this.isAnswered,
      status: status ?? this.status,
      isAnswerMode: isAnswerMode ?? this.isAnswerMode,
      answerText: answerText ?? this.answerText,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
