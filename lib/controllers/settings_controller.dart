import 'package:get/get.dart';

class SettingsController extends GetxController {
  // Notification Settings
  var emailUpdates = true.obs;
  var smsUpdates = false.obs;
  var pushNotifications = true.obs;
  var appointmentReminders = true.obs;

  // Privacy Settings
  var profileVisible = true.obs;
  var showEmail = false.obs;
  var showPhoneNumber = false.obs;

  // Profile Edit
  var name = "".obs;
  var email = "".obs;
  var phone = "".obs;
  var nid = "".obs;
  var address = "".obs;
  var city = "".obs;

  void toggleEmailUpdates(bool val) => emailUpdates.value = val;
  void toggleSmsUpdates(bool val) => smsUpdates.value = val;
  void togglePushNotifications(bool val) => pushNotifications.value = val;
  void toggleAppointmentReminders(bool val) => appointmentReminders.value = val;

  void toggleProfileVisible(bool val) => profileVisible.value = val;
  void toggleShowEmail(bool val) => showEmail.value = val;
  void toggleShowPhoneNumber(bool val) => showPhoneNumber.value = val;

  void updateProfile(String newName, String newEmail, String newPhone) {
    name.value = newName;
    email.value = newEmail;
    phone.value = newPhone;
    Get.back();
    Get.snackbar("Success", "Profile updated successfully");
  }
}