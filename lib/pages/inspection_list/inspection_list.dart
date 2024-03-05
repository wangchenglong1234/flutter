import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';
import '../../utils/toolUtils.dart';
import 'package:app_inspection_system/routers/routers.dart';

int leftCount = 48;
int rightCount = 192;

List<String> tagList = ['类型1', '类型2', '类型3', '类型4', '类型5'];

class InspectionList extends StatefulWidget {
  const InspectionList({super.key});

  @override
  State<InspectionList> createState() => _InspectionListState();
}

class _InspectionListState extends State<InspectionList> {
  int _currentIndex = 0;
  bool _isScrolling = false;
  List<GlobalKey> keys = List.generate(leftCount + 1, (_) => GlobalKey());
  late final ScrollController _scrollControllerLeft;
  late final ScrollController _scrollControllerRight;

  @override
  void initState() {
    // Uri uri = Uri.base;
    // print(uri);
    ToolUtils.hideStatusBar();
    _scrollControllerLeft = ScrollController();
    _scrollControllerRight = ScrollController();
    _scrollControllerRight.addListener(_handleScroll);
    super.initState();
  }

  void _handleScroll() {
    if (_isScrolling) return;
    // 获取当前滚动位置
    double currentScrollPosition = _scrollControllerRight.offset;
    int index = (currentScrollPosition / (4 * 61)).floor();
    _resetLeftScroll(index);
    setState(() {
      _currentIndex = index;
    });
  }

  void _onPressList(int val) {
    setState(() {
      _currentIndex = val;
      _isScrolling = true;
    });
    _resetLeftScroll(val);
    if (_scrollControllerRight.hasClients) {
      int pos = val * (4 * 61);
      _scrollControllerRight
          .animateTo(
            pos.toDouble(), // 滚动到Y轴坐标为0的位置，也就是顶部
            duration: const Duration(milliseconds: 200), // 可选，设置动画持续时间
            curve: Curves.easeInOut, // 可选，设置动画曲线
          )
          .then((value) => {
                setState(() {
                  _isScrolling = false;
                })
              });
    }
  }

  void _resetLeftScroll(int index) {
    if (_scrollControllerLeft.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final RenderBox fRenderBox =
            keys[48].currentContext?.findRenderObject() as RenderBox;
        double height = fRenderBox.size.height / 2;
        if (keys[index].currentContext != null) {
          final RenderBox renderBox =
              keys[index].currentContext!.findRenderObject() as RenderBox;
          final globalPosition = renderBox.localToGlobal(Offset.zero);
          final offset = _scrollControllerLeft.offset;
          // 计算按钮顶部距离视口顶部的距离
          final distanceFromViewportTop = globalPosition.dy;
          double scrollPos = offset - (height - distanceFromViewportTop);
          _scrollControllerLeft.animateTo(
            scrollPos, // 滚动到Y轴坐标为0的位置，也就是顶部
            duration: const Duration(milliseconds: 200), // 可选，设置动画持续时间
            curve: Curves.easeInOut, // 可选，设置动画曲线
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildHeader(),
          Expanded(
              key: keys[48],
              flex: 1,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: buildMainListContent(
                        leftCount, _currentIndex, _onPressList),
                  ),
                  Expanded(
                    flex: 3,
                    child: buildListContent(rightCount),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget buildHeader() {
    return Container(
      padding: const EdgeInsets.all(10),
      height: 60,
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
                      initTagState: [true],
                      onSelect: (selectedIndexes) {
                        BrnToast.show(selectedIndexes.toString(), context);
                      })
                ]),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10), // 四周都有16像素的外边距
            child: ElevatedButton(
              onPressed: () {
                String id = '23';
                Routes.navigateTo(context, '/inspection_detail_page/:$id');
              },
              child: const Text('新增'),
            ),
          )
        ],
      ),
    );
  }

  Widget buildMainListContent(
      int size, int currentIndex, Function(int value) handlePress) {
    return ListView(
      controller: _scrollControllerLeft,
      padding: EdgeInsets.zero,
      children: buildMainListItem(size, currentIndex, handlePress),
    );
  }

  List<Widget> buildMainListItem(
      int size, int currentIndex, Function(int value) handlePress) {
    List<Widget> tempList = [];
    for (var i = 0; i < size; i++) {
      tempList.add(Column(
        key: keys[i],
        children: [
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor:
                      currentIndex == i ? Colors.grey : Colors.white,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero, side: BorderSide.none)),
              onPressed: () {
                handlePress(i);
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '功站$i',
                    style: TextStyle(
                      color: currentIndex == i ? Colors.white : Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ));
    }
    return tempList;
  }

  Widget buildListContent(int size) {
    return ListView(
      controller: _scrollControllerRight, // 将ScrollController赋给ListView
      padding: EdgeInsets.zero,
      children: buildListItem(size),
    );
  }

  List<Widget> buildListItem(int size) {
    List<Widget> tempList = [];
    for (var i = 0; i < size; i++) {
      tempList.add(Column(
        children: [
          SizedBox(
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: BrnTagCustom(
                    tagText: 'D',
                    backgroundColor: Colors.green,
                    tagBorderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(right: 10),
                  child: BrnTagCustom(
                    tagText: '人',
                    backgroundColor: Colors.yellow,
                    tagBorderRadius: const BorderRadius.all(Radius.circular(5)),
                  ),
                ),
                Text(
                  '检查设备上水水水水设备$i',
                ),
              ],
            ),
          ),
          const Divider(
            height: 1,
          ),
        ],
      ));
    }
    return tempList;
  }

  @override
  void dispose() {
    // 销毁时注销ScrollController
    _scrollControllerRight.removeListener(_handleScroll);
    _scrollControllerRight.dispose();
    _scrollControllerLeft.dispose();
    super.dispose();
  }
}
