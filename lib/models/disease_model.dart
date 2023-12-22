class Disease {
  final String diseaseName;
  final String cause;
  final String diagnosis;
  final String overview;
  final String prevention;
  final String symptom;
  final String treatment;
  final String vulnerable;

  Disease(
      {required this.diseaseName,
      required this.cause,
      required this.diagnosis,
      required this.overview,
      required this.prevention,
      required this.symptom,
      required this.treatment,
      required this.vulnerable});

  Map<String, dynamic> toMap() {
    return {
      'diseaseName': diseaseName,
      'cause': cause,
      'diagnosis': diagnosis,
      'overview': overview,
      'prevention': prevention,
      'symptom': symptom,
      'treatment': treatment,
      'vulnerable': vulnerable,
    };
  }
}
