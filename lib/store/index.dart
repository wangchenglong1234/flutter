import 'package:redux/redux.dart';
import './reducers/index.dart';

class StoreWrapper {
  static final store = _createStore();

  static Store<AppState> _createStore() {
    // 创建并返回一个Store实例
    return Store(
      appReducer,
      initialState: initAppState(),
      // 可以添加中间件，例如loggerMiddleware
      middleware: [],
    );
  }
}
