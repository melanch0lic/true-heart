import '../../data/models/answer.dart';
import '../../data/models/question.dart';

abstract class QuestionsRepository {
  Future<List<Question>> readQuestions();
  Future<void> addAnswerToQuestion(String userId, String questionId, String answerText);
  Future<List<Answer>> getAnswersForQuestion(String questionId);
  Future<bool> doesUserAnswerExist(String userId, String questionId);
}
