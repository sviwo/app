/// 行程列表的请求
class TripRecorderListRequest {
  TripRecorderListRequest({
    this.deviceId,
    this.keyWord,
    this.dateRange = const [],
    this.orderBy,
    this.pageNum = 1,
    this.pageSize = 20,
  });

  /// 车id
  int? deviceId;

  /// 搜索关键字
  String? keyWord;

  List<String>? dateRange;

  /// 排序
  String? orderBy;

  /// 分页号码，默认1
  int pageNum;

  /// 分页数量，最大50,默认10
  int pageSize;

  Map<String, dynamic> toJson() => <String, dynamic>{
        'deviceId': deviceId,
        'keyWord': keyWord,
        'dateRange': dateRange,
        'orderBy': orderBy,
        'pageNum': pageNum,
        'pageSize': pageSize,
      };
}
