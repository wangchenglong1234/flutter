import 'package:app_inspection_system/model/inspection_list_model.dart';
import 'package:app_inspection_system/pages/inspection_list/helper.dart';
import 'package:bruno/bruno.dart';
import 'package:flutter/material.dart';

const Color _colorBottom = Colors.black12;

Widget buildMainListContent(
  List<InspectionListData> sliceListData,
  List<GlobalKey> leftListKeys,
  int currentIndex,
  ScrollController scrollControllerLeft,
  Function(int value) handlePress,
) {
  return SizedBox(
    height: double.infinity,
    child: SingleChildScrollView(
      controller: scrollControllerLeft,
      padding: EdgeInsets.zero,
      child: Column(
        children: buildMainListItem(
            sliceListData, leftListKeys, currentIndex, handlePress),
      ),
    ),
  );
}

List<Widget> buildMainListItem(
    List<InspectionListData> sliceListData,
    List<GlobalKey> leftListKeys,
    int currentIndex,
    Function(int value) handlePress) {
  List<Widget> tempList = [];
  final size = sliceListData.length;
  for (var i = 0; i < size; i++) {
    tempList.add(InkWell(
        onTap: () {
          handlePress(i);
        },
        child: Container(
            key: leftListKeys[i],
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: const Border(bottom: BorderSide(color: _colorBottom)),
              color: currentIndex == i
                  ? Colors.grey
                  : const Color.fromARGB(255, 233, 233, 233),
            ),
            child: Center(
              child: Text(
                sliceListData[i].workstationName ?? '',
                style: TextStyle(
                  fontSize: 12,
                  color: currentIndex == i ? Colors.white : Colors.black,
                ),
              ),
            ))));
  }
  return tempList;
}

Widget buildListContent(List<InspectionListData> sliceListData,
    List<GlobalKey> rightListKeys, ScrollController scrollControllerRight) {
  return SizedBox(
    height: double.infinity,
    child: SingleChildScrollView(
      controller: scrollControllerRight, // 将ScrollController赋给ListView
      padding: EdgeInsets.zero,
      child: Column(
        children: buildListItem(sliceListData, rightListKeys),
      ),
    ),
  );
}

List<Widget> buildListItem(
    List<InspectionListData> sliceListData, List<GlobalKey> rightListKeys) {
  List<Widget> tempList = [];
  final size = sliceListData.length;
  for (var i = 0; i < size; i++) {
    List<InspectionDetailListData>? childData = sliceListData[i].children;
    tempList.add(Container(
      key: rightListKeys[i],
      padding: const EdgeInsets.all(10),
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: _colorBottom)),
        color: Color.fromARGB(255, 233, 233, 233),
      ),
      child: Text(
        sliceListData[i].workstationName ?? '',
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
    ));
    if (childData != null && childData.isNotEmpty) {
      final subSize = childData.length;
      for (var j = 0; j < subSize; j++) {
        tempList.add(
          Container(
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
        );
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
