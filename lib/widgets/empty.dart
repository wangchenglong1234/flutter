import 'package:flutter/material.dart';

class EmptyContent extends StatelessWidget {
  const EmptyContent({Key? key, required this.isEmpty, required this.widget})
      : super(key: key);

  final Widget widget;
  final bool isEmpty;

  @override
  Widget build(BuildContext context) {
    if (isEmpty) {
      return const Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Icon(
            Icons.local_offer,
            color: Colors.grey,
            size: 48.0,
          ),
          Text("数据为空~")
        ],
      );
    }
    return widget;
  }
}
