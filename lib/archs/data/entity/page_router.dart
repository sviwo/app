import 'package:json_annotation/json_annotation.dart';

part 'page_router.g.dart';

@JsonSerializable()
class PageRouter {
  String route;
  Map<String, dynamic>? params;

  PageRouter(this.route, {this.params});

  factory PageRouter.fromJson(Map<String, dynamic> json) {
    return _$PageRouterFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$PageRouterToJson(this);
  }
}
