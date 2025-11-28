import 'package:aqua_mind/models/user_model.dart';

class DailyCalculate {
  static double calculateDailyWater(UserModel user) {
    if (user.gender.toLowerCase() == "male") {
      return user.weight * 35;
    } else {
      return user.weight * 31;
    }
  }
}
