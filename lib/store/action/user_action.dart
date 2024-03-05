import '../reducers/user_reducer.dart';
export '../reducers/user_reducer.dart';

// 带有用户信息的Action
class SetUserInfo {
  final UserState user;

  SetUserInfo(this.user);
}

// 退出登录
enum Actions { LogoutAction }
