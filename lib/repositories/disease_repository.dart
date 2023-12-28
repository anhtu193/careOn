import 'package:cloud_firestore/cloud_firestore.dart';

class DiseaseRepository {
  final CollectionReference diseaseCollection =
      FirebaseFirestore.instance.collection('diseases');

  Future<List<String>> fetchDiseasesStartingWithLetter(String letter) async {
    try {
      QuerySnapshot querySnapshot =
          await diseaseCollection.where('letter', isEqualTo: letter).get();

      List<String> diseaseNames = [];
      for (DocumentSnapshot document in querySnapshot.docs) {
        var data = document.data() as Map<String, dynamic>;
        diseaseNames.add(data['diseaseName'] as String);
      }
      return diseaseNames;
    } catch (e) {
      print('Error fetching diseases: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> fetchDiseaseInfo(String diseaseName) async {
    try {
      QuerySnapshot querySnapshot = await diseaseCollection
          .where('diseaseName', isEqualTo: diseaseName)
          .limit(1)
          .get();

      if (querySnapshot.size > 0) {
        return querySnapshot.docs.first.data() as Map<String, dynamic>;
      } else {
        throw 'No matching document found';
      }
    } catch (e) {
      throw e;
    }
  }
}
