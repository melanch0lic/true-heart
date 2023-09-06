import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_heart_app/domain/repository/questions_repository.dart';

import '../../../../data/models/question.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final String _userId;

  var rng = Random();

  late final TextEditingController _answerTextController;
  TextEditingController get answerTextController => _answerTextController;

  final QuestionsRepository _questionsRepository;

  HomeCubit(this._questionsRepository, this._userId) : super(const HomeState()) {
    _answerTextController = TextEditingController();
    getQuestions();
  }

  Future<void> getQuestions() async {
    emit(state.copyWith(status: HomeStatus.loading));
    await _questionsRepository.readQuestions().then((questions) async {
      final randomIndex = rng.nextInt(questions.length);
      emit(state.copyWith(questions: questions));
      final isAnswered = await _questionsRepository.doesUserAnswerExist(_userId, state.questions[randomIndex].id);
      emit(state.copyWith(status: HomeStatus.loaded, questionIndex: randomIndex, isAnswered: isAnswered));
    }).onError((error, stackTrace) {
      emit(state.copyWith(status: HomeStatus.error, errorMessage: error.toString()));
    });
  }

  Future<bool> doesUserAnswerExist(String userId, String questionId) async {
    return await _questionsRepository.doesUserAnswerExist(userId, questionId);
  }

  void onChangeQuestion() {
    emit(state.copyWith(questionIndex: rng.nextInt(state.questions.length)));
  }

  void onAnswerDialogButtonPressed() {
    emit(state.copyWith(isAnswerMode: true));
  }

  void onAnswerDialogButtonUnpressed() {
    emit(state.copyWith(isAnswerMode: false));
  }

  void onAnswerTextChanged(String text) {
    emit(state.copyWith(answerText: text));
  }

  Future<void> onSendAnswerPressed(String userId, String questionId, String answerText) async {
    if (answerText.isEmpty) return;
    emit(state.copyWith(status: HomeStatus.loading));
    await _questionsRepository.addAnswerToQuestion(userId, questionId, answerText);
    emit(
      state.copyWith(
        status: HomeStatus.loaded,
        answerText: '',
        isAnswerMode: false,
        questionIndex: rng.nextInt(
          state.questions.length,
        ),
      ),
    );
  }

  @override
  Future<void> close() {
    _answerTextController.dispose();
    return super.close();
  }
}
