import '../../data/models/question.dart';

abstract class QuestionsRepository {
  Future<List<Question>> readQuestions();
}
