import 'package:flutter/widgets.dart';
import 'package:yisty_app/data/stores/ui_store.dart';

class InheritedProvider extends InheritedWidget {
  const InheritedProvider({
    Widget child,
    @required this.uiStore,
  }) : assert(uiStore != null), super(child: child);

  final UiStore uiStore;

  @override
  bool updateShouldNotify(InheritedProvider oldWidget) => uiStore != oldWidget.uiStore;

  static InheritedProvider of(BuildContext context) => context.dependOnInheritedWidgetOfExactType<InheritedProvider>();
}
