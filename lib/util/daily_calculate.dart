import 'package:aqua_mind/models/user_model.dart';

class DailyCalculate {
  static double calculateDailyWater(UserModel user) {
    if (user.gender.toLowerCase() == "Erkek") {
      return user.weight * 35;
    } else {
      return user.weight * 31;
    }
  }
}
