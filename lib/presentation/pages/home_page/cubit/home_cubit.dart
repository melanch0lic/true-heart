import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_heart_app/domain/repository/questions_repository.dart';

import '../../../../data/models/question.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  var rng = Random();
  final QuestionsRepository _questionsRepository;

  HomeCubit(this._questionsRepository) : super(const HomeState()) {
    getQuestions();
  }

  void getQuestions() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _questionsRepository.readQuestions().then((questions) {
      emit(state.copyWith(
          status: HomeStatus.loaded, questions: questions, questionIndex: rng.nextInt(questions.length)));
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: error.toString()));
    });
  }

  void onChangeQuestion() {
    emit(state.copyWith(questionIndex: rng.nextInt(state.questions.length)));
  }

  void onAnswerButtonPressed() {
    emit(state.copyWith(isAnswerMode: true));
  }

  void onAnswerButtonUnpressed() {
    emit(state.copyWith(isAnswerMode: false));
  }
}
