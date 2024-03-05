import 'package:app_inspection_system/store/reducers/index.dart';
import 'package:flutter/material.dart';
import 'package:app_inspection_system/routers/routers.dart';
import 'package:app_inspection_system/store/index.dart';
import 'package:app_inspection_system/store/action/user_action.dart';
import 'package:flutter_redux/flutter_redux.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('登录')),
      body: Padding(
        padding: const EdgeInsets.all(20.0), // 添加内边距以优化视觉效果
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch, // 使子Widget水平拉伸以填充列宽
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: '用户名',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16), // 添加间距
            TextField(
              controller: passwordController,
              obscureText: true, // 隐藏密码
              decoration: const InputDecoration(
                labelText: '密码',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16), // 添加间距
            ElevatedButton(
              style: ButtonStyle(
                minimumSize:
                    MaterialStateProperty.all(const Size(double.infinity, 56)),
              ),
              onPressed: () {
                StoreWrapper.store.dispatch(
                    SetUserInfo(UserState(userName: 'test', isLoggedIn: true)));
                Routes.navigateTo(context, Routes.inspectionListPage,
                    params: {}, replace: true);
              },
              child: const Text('登录'),
            ),
            StoreConnector<AppState, ViewModel>(
              converter: (store) => ViewModel.fromStore(store.state),
              builder: (context, viewModel) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Username: ${viewModel.userName}'),
                    Text('Is Logged In: ${viewModel.isLoggedIn.toString()}'),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class ViewModel {
  final String userName;
  final bool isLoggedIn;

  ViewModel({required this.userName, required this.isLoggedIn});

  static ViewModel fromStore(AppState state) {
    return ViewModel(
      userName: state.userState.userName,
      isLoggedIn: state.userState.isLoggedIn,
    );
  }
}
