import 'package:get/get.dart';
import 'package:intl/intl.dart';

class UserProfileController extends GetxController {
  var wifeName = "Stefanyy Martin".obs;
  var husbandName = "John Martin".obs;
  var email = "stefanyy@gmail.com".obs;

  var dateOfBirth = "11/20/2000".obs;
  var lastPeriod = "23/03/2025".obs;

  void updateName({required String who, required String name}) {
    if (who == "wife") wifeName.value = name;
    if (who == "husband") husbandName.value = name;
  }

  void updateDate(String field, DateTime date) {
    final formatted = DateFormat('dd/MM/yyyy').format(date);
    if (field == "dob") dateOfBirth.value = formatted;
    if (field == "lastPeriod") lastPeriod.value = formatted;
  }
}
