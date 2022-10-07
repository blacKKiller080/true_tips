import 'package:true_tips_mobile/core/constants/system.dart';
import 'package:true_tips_mobile/core/http/api_provider.dart';

class BaseRepository {
  ApiClient httpClient;

  BaseRepository(this.httpClient);

  String url(part) {
    return '${System.MAIN_URL}/$part';
  }

  String queryPart(String query, dynamic el, String name) {
    if (el != null) {
      if (query.isEmpty) {
        query += '?';
      } else {
        query += '&';
      }
      query += "$name=" + el.toString();
    }
    return query;
  }
}
