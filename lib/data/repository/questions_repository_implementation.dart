import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository/questions_repository.dart';
import '../models/answer.dart';
import '../models/question.dart';

class QuestionsRepositoryImplementation implements QuestionsRepository {
  @override
  Future<List<Question>> readQuestions() async {
    CollectionReference questions = FirebaseFirestore.instance.collection('questions');
    final result = await questions.get();
    return result.docs
        .map((record) => Question(
            id: record.id,
            text: (record.data() as Map<String, dynamic>)['text'],
            answers: [...(record.data() as Map<String, dynamic>)['answers']]))
        .toList();
  }

  @override
  Future<void> addAnswerToQuestion(String userId, String questionId, String answerText) async {
    final CollectionReference questionsCollection = FirebaseFirestore.instance.collection('questions');
    final DocumentReference questionDocument = questionsCollection.doc(questionId);
    await questionDocument.collection('answers').add({
      'userId': userId,
      'text': answerText,
      'timestamp': FieldValue.serverTimestamp(),
      'likes': [],
    });
  }

  @override
  Future<List<Answer>> getAnswersForQuestion(String questionId) async {
    final CollectionReference questionsCollection = FirebaseFirestore.instance.collection('questions');
    final DocumentReference questionDocument = questionsCollection.doc(questionId);
    final QuerySnapshot answersQuery = await questionDocument.collection('answers').get();

    return answersQuery.docs
        .map((record) => Answer(
            userId: record.id,
            text: (record.data() as Map<String, dynamic>)['text'],
            timestamp: (record.data() as Map<String, dynamic>)['timestamp']))
        .toList();
  }

  @override
  Future<bool> doesUserAnswerExist(String userId, String questionId) async {
    final CollectionReference questionsCollection = FirebaseFirestore.instance.collection('questions');
    final DocumentReference questionDocument = questionsCollection.doc(questionId);
    final QuerySnapshot userAnswersQuery =
        await questionDocument.collection('answers').where('userId', isEqualTo: userId).get();

    return userAnswersQuery.docs.isNotEmpty;
  }
}
