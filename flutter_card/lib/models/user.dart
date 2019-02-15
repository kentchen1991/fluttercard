import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';
@JsonSerializable()
class User {
    User();

    num payPwdStatus;
    String idCardName;
    String cardName;
    String idCard;
    String openId;
    num annualfee;
    String referee;
    num type;
    num openType;
    num balance;
    String payPwd;
    String id;
    num isEnt;
    String vipStartTime;
    String updateTime;
    String portrait;
    String token;
    String vipEndTime;
    String phone;
    String createTime;
    String name;
    num expiryTime;
    String position;
    String pwd;
    num status;
    
    factory User.fromJson(Map<String,dynamic> json) => _$UserFromJson(json);
    Map<String, dynamic> toJson() => _$UserToJson(this);
}