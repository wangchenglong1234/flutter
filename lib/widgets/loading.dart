import 'package:flutter/material.dart';

class LoadingContent extends StatelessWidget {
  const LoadingContent({Key? key, required this.loading, required this.widget})
      : super(key: key);

  final Widget widget;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Container(
        padding: const EdgeInsets.only(top: 30),
        child: const Column(
          children: [
            CircularProgressIndicator(),
            SizedBox(
              height: 10,
            ),
            Text('加载中...')
          ],
        ),
      );
    }
    return widget;
  }
}
