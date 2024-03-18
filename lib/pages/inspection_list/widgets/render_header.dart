import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

List<String> tagList = ['抽检', '巡检', '全检', '首检', '停线', '产品隔离', '终检'];

typedef CalFn = void Function(List<int> list);

// 新建一个StatefulWidget子类
class RenderHeader extends StatefulWidget {
  const RenderHeader(
      {Key? key,
      required this.tabHeight,
      required this.onCheckOption,
      required this.onPageSwitch})
      : super(key: key);

  final CalFn onCheckOption;
  final VoidCallback onPageSwitch;
  final int tabHeight;
  @override
  State<RenderHeader> createState() => _RenderHeaderState();
}

class _RenderHeaderState extends State<RenderHeader> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: widget.tabHeight.toDouble(),
      color: const Color.fromARGB(255, 212, 211, 211),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: ListView(
                padding: const EdgeInsets.only(right: 20),
                scrollDirection: Axis.horizontal,
                children: [
                  BrnSelectTag(
                      tags: tagList,
                      spacing: 12,
                      isSingleSelect: false,
                      tagWidth: 10,
                      onSelect: (selectedIndexes) {
                        widget.onCheckOption(selectedIndexes);
                      })
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10), // 四周都有16像素的外边距
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                widget.onPageSwitch();
              },
              child: const Text('新增'),
            ),
          )
        ],
      ),
    );
  }
}
