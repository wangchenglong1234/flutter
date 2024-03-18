import 'package:app_inspection_system/model/inspection_list_model.dart';
import 'package:app_inspection_system/pages/inspection_list/helper.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

const Color _colorBottom = Colors.black12;

Widget buildListContent(List<InspectionListData> listData,
    void Function(InspectionDetailListData data) onShowBottomSheet) {
  return SizedBox(
    height: double.infinity,
    child: ListView(
      padding: EdgeInsets.zero,
      children: buildListItem(listData, onShowBottomSheet),
    ),
  );
}

List<Widget> buildListItem(
    List<InspectionListData> listData, onShowBottomSheet) {
  List<Widget> tempList = [];
  final size = listData.length;
  for (var i = 0; i < size; i++) {
    List<InspectionDetailListData>? childData = listData[i].children;
    tempList.add(Container(
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _colorBottom)),
        color: Color.fromARGB(255, 233, 233, 233),
      ),
      child: Text(
        listData[i].workstationName ?? '',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ));
    if (childData != null && childData.isNotEmpty) {
      final subSize = childData.length;
      for (var j = 0; j < subSize; j++) {
        tempList.add(InkWell(
          onTap: () {
            onShowBottomSheet(childData[j]);
          },
          child: Container(
            padding: const EdgeInsets.all(10),
            width: double.infinity,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: _colorBottom))),
            child: Wrap(
              children: [
                Text(
                  childData[j].controlContent ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
                ..._buildTags(childData[j].detection ?? '')
              ],
            ),
          ),
        ));
      }
    } else {
      tempList.add(const Center(
        child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              '该工站没有数据~',
              style: TextStyle(fontSize: 12),
            )),
      ));
    }
  }
  return tempList;
}

List<Widget> _buildTags(String detection) {
  List<String> charList = detection.split(',');
  return List.generate(
      charList.length,
      (index) => Padding(
            padding: const EdgeInsets.only(right: 5),
            child: BrnTagCustom(
              tagText: Helper.deMap[charList[index]] ?? '',
              backgroundColor: Colors.green,
              tagBorderRadius: const BorderRadius.all(Radius.circular(5)),
            ),
          )).toList();
}
