import 'package:yisty_app/data/stores/ui_store.dart';

class UiSingleton {
  factory UiSingleton() {
    return _singleton;
  }

  UiSingleton._internal();

  static final UiSingleton _singleton = UiSingleton._internal();
  static final UiStore _uiStore = UiStore();

  UiStore uiStore() {
    return _uiStore;
  }
}
