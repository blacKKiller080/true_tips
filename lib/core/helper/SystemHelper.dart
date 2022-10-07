import 'package:true_tips_mobile/core/constants/system.dart';

class SystemHelper {
  static String baseURL = System.MAIN_URL;

  static String urlV1(String uri) {
    return "$baseURL/api/V1/$uri";
  }

  static String img(dynamic img) {
    return "$baseURL/$img";
  }
}
