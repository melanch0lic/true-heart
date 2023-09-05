import 'package:cloud_firestore/cloud_firestore.dart';

import '../../domain/repository/questions_repository.dart';
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
}
