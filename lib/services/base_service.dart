import 'package:yisty_app/data/stores/ui_store.dart';
import 'package:yisty_app/services/rest_client/rest_client.dart';

abstract class BaseService {
  BaseService({this.client, this.uiStore});

  RestClient client;
  UiStore uiStore;
}