// inspection_model.dart
import 'package:json_annotation/json_annotation.dart';

part 'inspection_list_model.g.dart';

@JsonSerializable()
class InspectionListResponse {
  int code;
  String msg;
  Payload payload;

  InspectionListResponse(
      {required this.code, required this.msg, required this.payload});

  factory InspectionListResponse.fromJson(Map<String, dynamic> json) =>
      _$InspectionListResponseFromJson(json);
  Map<String, dynamic> toJson() => _$InspectionListResponseToJson(this);
}

@JsonSerializable()
class Payload {
  int total;
  List<InspectionListData>? content;

  Payload({required this.total, this.content});

  factory Payload.fromJson(Map<String, dynamic> json) =>
      _$PayloadFromJson(json);
  Map<String, dynamic> toJson() => _$PayloadToJson(this);
}

@JsonSerializable()
class InspectionListData {
  String? workstationID;
  String? lineID;
  String? modelID;
  String? workstationName;
  String? maxUser;
  String? sort;
  String? type;
  String? devicePkID;
  String? deviceName;
  String? specification;
  String? deviceCount;
  String? description;
  String? createBy;
  String? updateBy;
  String? createTime;
  String? updateTime;
  List<InspectionDetailListData>? children;

  InspectionListData({
    this.workstationID,
    this.lineID,
    this.modelID,
    this.workstationName,
    this.maxUser,
    this.sort,
    this.type,
    this.devicePkID,
    this.deviceName,
    this.specification,
    this.deviceCount,
    this.description,
    this.createBy,
    this.updateBy,
    this.createTime,
    this.updateTime,
    this.children,
  });

  factory InspectionListData.fromJson(Map<String, dynamic> json) =>
      _$InspectionListDataFromJson(json);
  Map<String, dynamic> toJson() => _$InspectionListDataToJson(this);
}

@JsonSerializable()
class InspectionDetailListData {
  String? lineID;
  String? lineName;
  String? workstationID;
  String? workstationName;
  String? deviceName;
  String? productionEquipment;
  String? no;
  String? features;
  String? productFeatures;
  String? processFeatures;
  String? specialProcess;
  String? controlContent;
  String? controlMethods;
  String? detection;
  String? sampleSize;
  String? sampleFreq;
  String? responsibleRole;
  String? NGRecordFile;
  String? containmentAction;
  String? correctiveAction;
  String? escalationRole;

  InspectionDetailListData({
    this.lineID,
    this.lineName,
    this.workstationID,
    this.workstationName,
    this.deviceName,
    this.productionEquipment,
    this.no,
    this.features,
    this.productFeatures,
    this.processFeatures,
    this.specialProcess,
    this.controlContent,
    this.controlMethods,
    this.detection,
    this.sampleSize,
    this.sampleFreq,
    this.responsibleRole,
    this.NGRecordFile,
    this.containmentAction,
    this.correctiveAction,
    this.escalationRole,
  });

  factory InspectionDetailListData.fromJson(Map<String, dynamic> json) =>
      _$InspectionDetailListDataFromJson(json);
  Map<String, dynamic> toJson() => _$InspectionDetailListDataToJson(this);
}
