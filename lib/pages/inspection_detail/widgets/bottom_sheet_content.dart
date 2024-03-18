import 'package:app_inspection_system/model/inspection_list_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// 在StatefulWidget或StatelessWidget的build方法内调用
void onShowBottomSheet(BuildContext context, InspectionDetailListData data) {
  showModalBottomSheet<void>(
    context: context,
    shape: Border.all(style: BorderStyle.none),
    barrierColor: Colors.transparent,
    isScrollControlled: true,
    enableDrag: false,
    backgroundColor: Colors.black.withOpacity(0.1), // 设置背景为透明
    builder: (BuildContext context) {
      final bottomInset = MediaQuery.of(context).viewInsets.bottom;
      return SafeArea(
        bottom: false, // 确保底部安全区域不会影响到透明效果
        child: Stack(
          children: [
            Positioned.fill(
                child: Container(
              color: Colors.transparent,
            )),
            Positioned(
              bottom: bottomInset, // 键盘弹出时，底部距离屏幕底部的距离就是键盘高度
              left: 0,
              right: 0,
              child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height -
                        bottomInset -
                        1, // 自定义额外减少的空间，用于视觉效果或其他需求
                  ),
                  child: SingleChildScrollView(
                      child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.zero),
                          // 返回您想要展示的自定义Widget
                          padding: const EdgeInsets.all(16.0),
                          child: SheetContainer(
                            data: data,
                          )))),
            ),
          ],
        ),
      );
    },
  );
}

// 使用 Hook 的无状态组件
class SheetContainer extends HookWidget {
  const SheetContainer({super.key, required this.data});
  final InspectionDetailListData data;

  @override
  Widget build(BuildContext context) {
    // final count = useState<int>(0);

    // useEffect(() {}, []);

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25.0),
                      bottomLeft: Radius.circular(25.0),
                      topRight: Radius.circular(0.0),
                      bottomRight: Radius.circular(0.0),
                    ), // 设置圆角半径为16.0
                  ),
                  minimumSize: const Size.fromHeight(50.0),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                ),
                onPressed: () {},
                child: const Text('OK'),
              ),
            ),
            Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0.0),
                      bottomLeft: Radius.circular(0.0),
                      topRight: Radius.circular(25.0),
                      bottomRight: Radius.circular(25.0),
                    ), // 设置圆角半径为16.0
                  ),
                  minimumSize: const Size.fromHeight(50.0),
                  textStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.normal),
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () {},
                child: const Text('NG'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20), // 添加间距
        const SizedBox(
          height: 50,
          child: TextField(
            decoration: InputDecoration(
              labelText: '测量值',
              border: InputBorder.none,
            ),
          ),
        ),
        const Divider(height: 1, color: Colors.grey), // 添加间距
        const TextField(
          maxLines: null,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 0, right: 0),
            hintText: '请输入备注',
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white70,
          ),
        ),
        const Divider(height: 1, color: Colors.grey), // 添加间距
        const SizedBox(height: 40),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0.0),
                bottomLeft: Radius.circular(0.0),
                topRight: Radius.circular(0.0),
                bottomRight: Radius.circular(0.0),
              ), // 设置圆角半径为16.0
            ),
            minimumSize: const Size.fromHeight(50.0),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white,
          ),
          onPressed: () {},
          child: const Text('提交'),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
