import 'user_reducer.dart';

class AppState {
  final UserState userState;
  AppState({
    required this.userState,
  });
}

AppState initAppState() {
  return AppState(userState: UserState());
}

AppState appReducer(AppState state, dynamic action) {
  return AppState(
    userState: userReducer(state.userState, action),
  );
}
