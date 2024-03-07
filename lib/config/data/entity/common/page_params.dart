import 'package:json_annotation/json_annotation.dart';

part 'page_params.g.dart';

@JsonSerializable()
class BuildingUuidParams {
  String? buildingUuid;

  BuildingUuidParams(this.buildingUuid);

  factory BuildingUuidParams.fromJson(Map<String, dynamic> json) {
    return _$BuildingUuidParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BuildingUuidParamsToJson(this);
  }
}

@JsonSerializable()
class ProjectUuidParams {
  String? projectUuid;

  ProjectUuidParams(this.projectUuid);

  factory ProjectUuidParams.fromJson(Map<String, dynamic> json) {
    return _$ProjectUuidParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$ProjectUuidParamsToJson(this);
  }
}

@JsonSerializable()
class NeighborhoodUuidParams {
  String? neighborhoodUuid;

  NeighborhoodUuidParams({this.neighborhoodUuid});

  factory NeighborhoodUuidParams.fromJson(Map<String, dynamic> json) {
    return _$NeighborhoodUuidParamsFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$NeighborhoodUuidParamsToJson(this);
  }
}
