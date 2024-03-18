import 'package:app_inspection_system/model/inspection_list_model.dart';

class InspectionDataUtil {
  static List<InspectionListData> dataList = [];

  static setData(List<InspectionListData> data) {
    InspectionDataUtil.dataList = data;
  }

  static removeData() {
    InspectionDataUtil.dataList = [];
  }
}
