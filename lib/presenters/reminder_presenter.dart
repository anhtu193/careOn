import 'package:care_on/models/reminder_model.dart';
import 'package:care_on/repositories/reminder_repository.dart';

class ReminderPresenter {
  final ReminderRepository repository = ReminderRepository();

  Stream<List<Reminder>> getReminders() {
    return repository.getReminders();
  }

  Future<void> addReminder(Reminder reminder) {
    return repository.addReminder(reminder);
  }

  Future<void> deleteReminder(String reminderId) {
    return repository.deleteReminder(reminderId);
  }
}
