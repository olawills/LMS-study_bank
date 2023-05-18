import 'package:cloud_firestore/cloud_firestore.dart';

class QuestionModel {
  String id;
  String title;
  String? imageUrl;
  String description;
  int timeSeconds;
  List<Questions>? questions;
  int questionCount;

  QuestionModel(
      {required this.id,
      required this.title,
      this.imageUrl,
      required this.description,
      required this.timeSeconds,
      required this.questionCount,
      this.questions});

  // factory QuestionModel.fromJson(Map<String, dynamic> json) {
  //   return QuestionModel(
  //       id: json['id'],
  //       title: json['title'],
  //       description: json['description'],
  //       timeSeconds: json['time_seconds'],

  //       questionCount: 0);
  // }

  QuestionModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        title = json['title'] as String,
        imageUrl = json['image_url'] as String,
        description = json['description'] as String,
        timeSeconds = json['time_seconds'],
        questionCount = 0,
        questions = (json['questions'] as List)
            .map((dynamic e) => Questions.fromJson(e as Map<String, dynamic>))
            .toList();

  factory QuestionModel.fromSnapshot(DocumentSnapshot map) {
    return QuestionModel(
      id: map['id'],
      title: map['title'],
      imageUrl: map['image_url'],
      description: map['description'],
      timeSeconds: map['time_seconds'],
      questionCount: map['questions_count'] as int,
      questions: [],
    );
  }
  String timeInMins() => '${(timeSeconds / 60).ceil()}mins';

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = id;
  //   data['title'] = title;
  //   data['image_url'] = imageUrl;
  //   data['description'] = description;
  //   data['time_seconds'] = timeSeconds;

  //   return data;
  // }
}

class Questions {
  String id;
  String question;
  List<Answers> answers;
  String? correctAnswer;
  String? selectedAnswer;

  Questions(
      {required this.id,
      required this.question,
      required this.answers,
      this.correctAnswer});

  // factory Questions.fromSnapshot(DocumentSnapshot map) {
  //   return Questions(
  //     id: map['id'],
  //     question: map['questions'],
  //     answers: map['answers'],
  //   );
  // }

  Questions.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        question = json['question'],
        answers =
            (json['answers'] as List).map((e) => Answers.fromJson(e)).toList(),
        correctAnswer = json['correct_answer'];

  Questions.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : id = snapshot.id,
        question = snapshot['question'],
        answers = [],
        correctAnswer = snapshot['correct_answer'];

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['id'] = id;

  //   data['question'] = question;
  //   if (answers != null) {
  //     data['answers'] = answers.map((v) => v.toJson()).toList();
  //   }
  //   data['correct_answer'] = correctAnswer;
  //   return data;
  // }
}

class Answers {
  String? identifier;
  String? answer;

  Answers({this.identifier, this.answer});

  // factory Answers.fromSnapshot(DocumentSnapshot map) {
  //   return Answers(
  //     identifier: map['identifier'],
  //     answer: map['Answer'],
  //   );
  // }

  Answers.fromJson(Map<String, dynamic> json)
      : identifier = json['identifier'],
        answer = json['Answer'];

  Answers.fromFirestore(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : identifier = snapshot['identifier'] as String?,
        answer = snapshot['answer'] as String?;

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = Map<String, dynamic>();
  //   data['identifier'] = identifier;
  //   data['Answer'] = answer;
  //   return data;
  // }
}
