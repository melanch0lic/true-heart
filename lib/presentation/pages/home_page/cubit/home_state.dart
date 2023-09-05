part of 'home_cubit.dart';

enum HomeStatus { initial, loading, loaded, error }

final class HomeState extends Equatable {
  const HomeState({
    this.questionIndex = -1,
    this.questions = const [],
    this.status = HomeStatus.initial,
    this.isAnswerMode = false,
    this.errorMessage,
  });

  final int questionIndex;
  final List<Question> questions;
  final HomeStatus status;
  final bool isAnswerMode;
  final String? errorMessage;

  @override
  List<Object?> get props => [questionIndex, questions, status, isAnswerMode, errorMessage];

  HomeState copyWith(
      {int? questionIndex, List<Question>? questions, HomeStatus? status, bool? isAnswerMode, String? errorMessage}) {
    return HomeState(
      questionIndex: questionIndex ?? this.questionIndex,
      questions: questions ?? this.questions,
      status: status ?? this.status,
      isAnswerMode: isAnswerMode ?? this.isAnswerMode,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
