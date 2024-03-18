// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inspection_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InspectionListResponse _$InspectionListResponseFromJson(
        Map<String, dynamic> json) =>
    InspectionListResponse(
      code: json['code'] as int,
      msg: json['msg'] as String,
      payload: Payload.fromJson(json['payload'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InspectionListResponseToJson(
        InspectionListResponse instance) =>
    <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'payload': instance.payload,
    };

Payload _$PayloadFromJson(Map<String, dynamic> json) => Payload(
      total: json['total'] as int,
      content: (json['content'] as List<dynamic>?)
          ?.map((e) => InspectionListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PayloadToJson(Payload instance) => <String, dynamic>{
      'total': instance.total,
      'content': instance.content,
    };

InspectionListData _$InspectionListDataFromJson(Map<String, dynamic> json) =>
    InspectionListData(
      workstationID: json['workstationID'] as String?,
      lineID: json['lineID'] as String?,
      modelID: json['modelID'] as String?,
      workstationName: json['workstationName'] as String?,
      maxUser: json['maxUser'] as String?,
      sort: json['sort'] as String?,
      type: json['type'] as String?,
      devicePkID: json['devicePkID'] as String?,
      deviceName: json['deviceName'] as String?,
      specification: json['specification'] as String?,
      deviceCount: json['deviceCount'] as String?,
      description: json['description'] as String?,
      createBy: json['createBy'] as String?,
      updateBy: json['updateBy'] as String?,
      createTime: json['createTime'] as String?,
      updateTime: json['updateTime'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) =>
              InspectionDetailListData.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$InspectionListDataToJson(InspectionListData instance) =>
    <String, dynamic>{
      'workstationID': instance.workstationID,
      'lineID': instance.lineID,
      'modelID': instance.modelID,
      'workstationName': instance.workstationName,
      'maxUser': instance.maxUser,
      'sort': instance.sort,
      'type': instance.type,
      'devicePkID': instance.devicePkID,
      'deviceName': instance.deviceName,
      'specification': instance.specification,
      'deviceCount': instance.deviceCount,
      'description': instance.description,
      'createBy': instance.createBy,
      'updateBy': instance.updateBy,
      'createTime': instance.createTime,
      'updateTime': instance.updateTime,
      'children': instance.children,
    };

InspectionDetailListData _$InspectionDetailListDataFromJson(
        Map<String, dynamic> json) =>
    InspectionDetailListData(
      lineID: json['lineID'] as String?,
      lineName: json['lineName'] as String?,
      workstationID: json['workstationID'] as String?,
      workstationName: json['workstationName'] as String?,
      deviceName: json['deviceName'] as String?,
      productionEquipment: json['productionEquipment'] as String?,
      no: json['no'] as String?,
      features: json['features'] as String?,
      productFeatures: json['productFeatures'] as String?,
      processFeatures: json['processFeatures'] as String?,
      specialProcess: json['specialProcess'] as String?,
      controlContent: json['controlContent'] as String?,
      controlMethods: json['controlMethods'] as String?,
      detection: json['detection'] as String?,
      sampleSize: json['sampleSize'] as String?,
      sampleFreq: json['sampleFreq'] as String?,
      responsibleRole: json['responsibleRole'] as String?,
      NGRecordFile: json['NGRecordFile'] as String?,
      containmentAction: json['containmentAction'] as String?,
      correctiveAction: json['correctiveAction'] as String?,
      escalationRole: json['escalationRole'] as String?,
    );

Map<String, dynamic> _$InspectionDetailListDataToJson(
        InspectionDetailListData instance) =>
    <String, dynamic>{
      'lineID': instance.lineID,
      'lineName': instance.lineName,
      'workstationID': instance.workstationID,
      'workstationName': instance.workstationName,
      'deviceName': instance.deviceName,
      'productionEquipment': instance.productionEquipment,
      'no': instance.no,
      'features': instance.features,
      'productFeatures': instance.productFeatures,
      'processFeatures': instance.processFeatures,
      'specialProcess': instance.specialProcess,
      'controlContent': instance.controlContent,
      'controlMethods': instance.controlMethods,
      'detection': instance.detection,
      'sampleSize': instance.sampleSize,
      'sampleFreq': instance.sampleFreq,
      'responsibleRole': instance.responsibleRole,
      'NGRecordFile': instance.NGRecordFile,
      'containmentAction': instance.containmentAction,
      'correctiveAction': instance.correctiveAction,
      'escalationRole': instance.escalationRole,
    };
