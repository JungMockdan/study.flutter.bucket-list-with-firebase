import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BucketService extends ChangeNotifier {
  final bucketCollection = FirebaseFirestore.instance.collection('bucket');

  Future<QuerySnapshot> read(String uid) async {
    // 내 bucketList 가져오기
    return bucketCollection.where('uid', isEqualTo: uid).get();
    // throw UnimplementedError(); // return 값 미구현 에러
  }

  void create(String job, String uid) async {
    // bucket 만들기
    bucketCollection.add({
      'uid': uid,
      'job': job,
      'isDone': false,
    });
    notifyListeners();
  }

  void update(String docId, bool isDone) async {
    // bucket isDone 업데이트
    await bucketCollection.doc(docId).update({'isDone': isDone});
    notifyListeners(); // 화면 갱신
  }

  void delete(String docId) async {
    // bucket 삭제
    await bucketCollection.doc(docId).delete();
    notifyListeners(); // 화면 갱신
  }
}
