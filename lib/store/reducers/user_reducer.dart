import '../action/user_action.dart';

class UserState {
  String userName;
  bool isLoggedIn;

  UserState({
    this.userName = '--',
    this.isLoggedIn = false,
  });
// 基于现有状态创建新状态的工厂方法
  factory UserState.from(UserState source) {
    return UserState(
      userName: source.userName,
      isLoggedIn: source.isLoggedIn,
    );
  }
}

UserState userReducer(UserState state, dynamic action) {
  if (action is SetUserInfo) {
    return UserState.from(action.user);
  } else if (action == Actions.LogoutAction) {
    return UserState(isLoggedIn: false, userName: state.userName);
  }

  return state;
}
