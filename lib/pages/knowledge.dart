import 'package:cloud_firestore/cloud_firestore.dart';

class KnowledgeService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getKnowledge() async {
    try {
      final snapshot = await _firestore.collection('knowledge').get();

      return snapshot.docs.map((doc) {
        final data = doc.data();

        return {
          'id': doc.id,
          ...data,
        };
      }).toList();
    } catch (e) {
      print('Error mengambil knowledge: $e');
      return [];
    }
  }
}
