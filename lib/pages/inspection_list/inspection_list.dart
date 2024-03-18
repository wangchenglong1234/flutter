import 'dart:convert';
import 'package:app_inspection_system/routers/routers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../utils/toolUtils.dart';
import '../../utils/inspectionDataUtil.dart';
import 'package:app_inspection_system/model/inspection_list_model.dart';
import 'package:app_inspection_system/widgets/empty.dart';
import 'package:app_inspection_system/widgets/loading.dart';
import 'package:bot_toast/bot_toast.dart';
import './widgets/render_header.dart';
import './widgets/list_build.dart';

const _tabHeight = 60;
const _debounceTime = 50;

Future<Map<String, dynamic>> loadJsonFromAsset(String assetPath) async {
  return await rootBundle.loadString(assetPath).then((jsonStr) {
    return jsonDecode(jsonStr);
  });
}

class InspectionList extends StatefulWidget {
  const InspectionList({super.key});

  @override
  State<InspectionList> createState() => _InspectionListState();
}

class _InspectionListState extends State<InspectionList> {
  int _currentIndex = 0;
  bool _isScrolling = false;
  bool _loading = true;
  bool loadErr = false;
  List<String> detectionTypeList = [];
  List<InspectionListData> _listData = [];
  List<InspectionListData> _sliceListData = [];
  List<GlobalKey> _leftListKeys = [];
  List<GlobalKey> _rightListKeys = [];
  final GlobalKey _leftListKey = GlobalKey();
  double _leftListHeight = 0;
  Map<int, double> _leftIndexToRightPosMap = {};
  late final ScrollController _scrollControllerLeft;
  late final ScrollController _scrollControllerRight;

  @override
  void initState() {
    ToolUtils.hideStatusBar();
    _scrollControllerLeft = ScrollController();
    _scrollControllerRight = ScrollController();
    _scrollControllerRight
        .addListener(ToolUtils.throttle(_handleScroll, _debounceTime));
    _initListData();
    super.initState();
  }

  void _initListData() async {
    await Future.delayed(const Duration(seconds: 2));
    final jsonObj = await loadJsonFromAsset('assets/data.json');
    if (mounted) {
      InspectionListResponse res = InspectionListResponse.fromJson(jsonObj);
      if (res.code == 200 && res.payload.content != null) {
        final data = res.payload.content;
        final dataSize = data?.length ?? 0;
        setState(() {
          _sliceListData = _listData = data ?? [];
          _loading = false;
        });
        _initBoxPos(dataSize);
      }
    }
  }

  void _onPageSwitch() {
    if (detectionTypeList.isEmpty) {
      BotToast.showText(
          text: "请添加侦测条件",
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      return;
    }
    if (_sliceListData.isEmpty) {
      BotToast.showText(
          text: "数据为空",
          textStyle: const TextStyle(fontSize: 14, color: Colors.white));
      return;
    }
    InspectionDataUtil.setData(_sliceListData);
    Routes.navigateTo(context, '/inspection_detail_page/:3');
  }

  //  按类型筛选
  void _onCheckOption(List<int> selectedIndexes) {
    _resetListPosInfo();
    final List<String> optionList =
        selectedIndexes.map((e) => (e + 1).toString()).toList();
    detectionTypeList = optionList;
    List<InspectionListData> filterData = [];
    if (optionList.isNotEmpty) {
      for (var item in _listData) {
        final childData = item.children ?? [];
        final workStationData =
            InspectionListData.fromJson(jsonDecode(jsonEncode(item))); //深拷贝
        workStationData.children = [];
        if (childData.isNotEmpty) {
          for (var subItem in childData) {
            List<String> detectionList = subItem.detection?.split(',') ?? [];
            for (var detection in detectionList) {
              if (optionList.contains(detection)) {
                workStationData.children?.add(subItem);
                break;
              }
            }
          }
        }
        if (workStationData.children!.isNotEmpty) {
          filterData.add(workStationData);
        }
      }
    } else {
      filterData = _listData;
    }
    setState(() {
      _sliceListData = filterData;
    });

    _initBoxPos(filterData.length);
  }

  // 初始化元素位置信息
  void _initBoxPos(int dataSize) {
    _leftListKeys = List.generate(dataSize, (_) => GlobalKey());
    _rightListKeys = List.generate(dataSize, (_) => GlobalKey());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      int count = _rightListKeys.length;
      for (var i = 0; i < count; i++) {
        if (_rightListKeys[i].currentContext != null) {
          final RenderBox renderBox =
              _rightListKeys[i].currentContext!.findRenderObject() as RenderBox;
          final offset = renderBox.localToGlobal(Offset.zero);
          final scrollPos = _scrollControllerRight.offset;
          _leftIndexToRightPosMap[i] = (offset.dy - _tabHeight) - scrollPos;
        } else {
          _leftIndexToRightPosMap[i] = 0.0;
        }
      }
      for (var element in _leftListKeys) {
        final RenderBox renderBox =
            element.currentContext!.findRenderObject() as RenderBox;
        _leftListHeight += renderBox.size.height;
      }
    });
  }

  void _resetListPosInfo() {
    _currentIndex = 0;
    _leftListHeight = 0;
    _leftIndexToRightPosMap = {};
    if (_scrollControllerLeft.hasClients) _scrollControllerLeft.jumpTo(0);
    if (_scrollControllerRight.hasClients) _scrollControllerRight.jumpTo(0);
  }

  void _handleScroll() {
    if (_isScrolling) return;
    // 获取当前滚动位置
    double currentScrollPosition = _scrollControllerRight.offset;
    int index = 0;
    for (var key in _leftIndexToRightPosMap.keys) {
      if (currentScrollPosition < _leftIndexToRightPosMap[key]!) {
        index = key - 1;
        break;
      }
    }
    if (index == _currentIndex) return;
    _resetLeftScroll(index);
    setState(() {
      _currentIndex = index;
    });
  }

  void _onPressList(int val) {
    if (val == _currentIndex) return;
    setState(() {
      _currentIndex = val;
      _isScrolling = true;
    });
    _resetLeftScroll(val);
    if (_scrollControllerRight.hasClients) {
      double pos = _leftIndexToRightPosMap[val] ?? 0;
      _scrollControllerRight
          .animateTo(
            pos, // 滚动到Y轴坐标为0的位置，也就是顶部
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
            _leftListKey.currentContext?.findRenderObject() as RenderBox;
        double height = fRenderBox.size.height / 2;
        if (_leftListKeys[index].currentContext != null) {
          final RenderBox renderBox = _leftListKeys[index]
              .currentContext!
              .findRenderObject() as RenderBox;
          final globalPosition = renderBox.localToGlobal(Offset.zero);
          final offset = _scrollControllerLeft.offset;
          // 计算按钮顶部距离视口顶部的距离
          final distanceFromViewportTop = (globalPosition.dy - _tabHeight);
          final cH = renderBox.size.height / 2;
          double scrollPos = offset - (height - distanceFromViewportTop) + cH;
          if (scrollPos <= cH) {
            scrollPos = 0; //=============解决滚动高度小于0时，导致的布局拉伸bug
          } else if (scrollPos >= (_leftListHeight - height * 2)) {
            scrollPos = _leftListHeight - height * 2;
          }
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
          RenderHeader(
            tabHeight: _tabHeight,
            onCheckOption: _onCheckOption,
            onPageSwitch: _onPageSwitch,
          ),
          LoadingContent(
              loading: _loading,
              widget: EmptyContent(
                  isEmpty: _sliceListData.isEmpty,
                  widget: Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                          key: _leftListKey,
                          flex: 1,
                          child: buildMainListContent(
                              _sliceListData,
                              _leftListKeys,
                              _currentIndex,
                              _scrollControllerLeft,
                              _onPressList),
                        ),
                        Expanded(
                          flex: 3,
                          child: buildListContent(_sliceListData,
                              _rightListKeys, _scrollControllerRight),
                        )
                      ],
                    ),
                  )))
        ],
      ),
    );
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
