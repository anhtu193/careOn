import 'package:care_on/repositories/disease_repository.dart';

class DiseasePresenter {
  final DiseaseRepository repository = DiseaseRepository();

  Future<List<String>> fetchDiseasesStartingWithLetter(String letter) {
    return repository.fetchDiseasesStartingWithLetter(letter);
  }

  Future<Map<String, dynamic>> fetchDiseaseInfo(String diseaseName) {
    return repository.fetchDiseaseInfo(diseaseName);
  }
}
