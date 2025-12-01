import 'package:aqua_mind/models/user_model.dart';

class DailyCalculate {
  static double calculateDailyWater(UserModel user) {
    double rawValue;

    if (user.gender.toLowerCase() == "erkek") {
      rawValue = user.weight * 35;
    } else {
      rawValue = user.weight * 31;
    }

    // En yakın yüzlüğe yuvarla
    double rounded = (rawValue / 100).round() * 100;

    return rounded;
  }
}
