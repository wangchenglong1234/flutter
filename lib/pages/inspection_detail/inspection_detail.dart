import 'package:flutter/material.dart';
import '../../utils/inspectionDataUtil.dart';
import 'package:app_inspection_system/model/inspection_list_model.dart';
import 'package:app_inspection_system/routers/routers.dart';
import './widgets/list_build.dart';
import './widgets/bottom_sheet_content.dart';

const _tabHeight = 60;

class InspectionDetail extends StatefulWidget {
  const InspectionDetail({super.key, required this.id});

  final String id;

  @override
  State<InspectionDetail> createState() => _InspectionDetailState();
}

class _InspectionDetailState extends State<InspectionDetail> {
  List<InspectionListData> _listData = [];

  @override
  void initState() {
    setState(() {
      _listData = InspectionDataUtil.dataList;
    });
    super.initState();
  }

  @override
  void dispose() {
    InspectionDataUtil.removeData();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true, // 添加此行，使Scaffold在键盘弹出时自动调整高度
      body: Column(
        children: [
          SizedBox(
            height: _tabHeight.toDouble(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  iconSize: 30,
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Routes.router.pop(context);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {},
                    child: const Text('提交'),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: buildListContent(
                _listData, (data) => onShowBottomSheet(context, data)),
          )
        ],
      ),
    );
  }
}
