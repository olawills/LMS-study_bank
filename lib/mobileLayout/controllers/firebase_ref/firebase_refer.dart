import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

final firestore = FirebaseFirestore.instance;
Reference get firebaseStorage => FirebaseStorage.instance.ref();

final userRf = firestore.collection('users');

final questionPaperReference = firestore.collection('questionPapers');
DocumentReference questionReference({
  required String paperId,
  required String questionId,
}) =>
    questionPaperReference.doc(paperId).collection("questions").doc(questionId);
