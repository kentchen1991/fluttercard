// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User()
    ..payPwdStatus = json['payPwdStatus'] as num
    ..idCardName = json['idCardName'] as String
    ..cardName = json['cardName'] as String
    ..idCard = json['idCard'] as String
    ..openId = json['openId'] as String
    ..annualfee = json['annualfee'] as num
    ..referee = json['referee'] as String
    ..type = json['type'] as num
    ..openType = json['openType'] as num
    ..balance = json['balance'] as num
    ..payPwd = json['payPwd'] as String
    ..id = json['id'] as String
    ..isEnt = json['isEnt'] as num
    ..vipStartTime = json['vipStartTime'] as String
    ..updateTime = json['updateTime'] as String
    ..portrait = json['portrait'] as String
    ..token = json['token'] as String
    ..vipEndTime = json['vipEndTime'] as String
    ..phone = json['phone'] as String
    ..createTime = json['createTime'] as String
    ..name = json['name'] as String
    ..expiryTime = json['expiryTime'] as num
    ..position = json['position'] as String
    ..pwd = json['pwd'] as String
    ..status = json['status'] as num;
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'payPwdStatus': instance.payPwdStatus,
      'idCardName': instance.idCardName,
      'cardName': instance.cardName,
      'idCard': instance.idCard,
      'openId': instance.openId,
      'annualfee': instance.annualfee,
      'referee': instance.referee,
      'type': instance.type,
      'openType': instance.openType,
      'balance': instance.balance,
      'payPwd': instance.payPwd,
      'id': instance.id,
      'isEnt': instance.isEnt,
      'vipStartTime': instance.vipStartTime,
      'updateTime': instance.updateTime,
      'portrait': instance.portrait,
      'token': instance.token,
      'vipEndTime': instance.vipEndTime,
      'phone': instance.phone,
      'createTime': instance.createTime,
      'name': instance.name,
      'expiryTime': instance.expiryTime,
      'position': instance.position,
      'pwd': instance.pwd,
      'status': instance.status
    };
