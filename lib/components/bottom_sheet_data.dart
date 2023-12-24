class BottomSheetData {
  late void Function(String) updateTextSelectedDays;
  late void Function(List<bool>) updateSelectedDays;

  BottomSheetData({
    required this.updateTextSelectedDays,
    required this.updateSelectedDays,
  });
}
