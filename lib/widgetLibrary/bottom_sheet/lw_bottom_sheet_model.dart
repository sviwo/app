class LWSheetModel {
  LWSheetModel({required this.label, required this.value, this.isSelected = false});

  /// 显示文字
  String label;

  /// 一般为传如后台的值
  var value;

  bool isSelected;

  @override
  String toString() {
    return "label:$label, value:$value";
  }

  factory LWSheetModel.fromJson(Map<String, dynamic> json) {
    return LWSheetModel(label: json['label'] as String, value: json['value'], isSelected: json["isSelected"]);
  }
  Map<String, dynamic> toJson() {
    return {'label': label, 'value': value, 'isSelected': isSelected};
  }
}
