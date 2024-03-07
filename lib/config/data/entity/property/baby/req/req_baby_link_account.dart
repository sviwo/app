import 'package:json_annotation/json_annotation.dart';

part 'req_baby_link_account.g.dart';

@JsonSerializable()
class ReqBabyLinkAccount {
  String? accountCode; // 账户code
  List<String>? accountCodeList; // 待关联的子账户code

  ReqBabyLinkAccount({
    this.accountCode,
    this.accountCodeList,
  });

  Map<String, dynamic> toJson() {
    return _$ReqBabyLinkAccountToJson(this);
  }
}
