import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

abstract class BaseService {
  BaseService({this.client, this.uiStore});

  RestClient client;
  UiStore uiStore;

  String serializeFilters(String url, Map<String, String> filters) {
    if (filters.isEmpty) {
      return url;
    } else {
      String filtersString = '';

      filters.forEach((String key, String value) {
        if (filtersString.isEmpty) {
          filtersString = '$key=$value';
        } else {
          filtersString = '$filtersString&$key=$value';
        }
      });

      return '$url?$filtersString';
    }
  }
}