class LWItem {
  String name; // 名称
  String code; // 编码
  String? displayName; // 显示名称，使用时建议进行双重判空处理
  Map<String, dynamic>? otherInfo;

  // --- 用于级联列表
  String? parentCode;
  List<LWItem>? children;

  // ---

  bool select = false; // 是否选中
  bool enable = true; // 是否允许选择
  bool isAll = false; // 是否是全选

  LWItem(
    this.name,
    this.code, {
    this.displayName,
    this.otherInfo,
    this.parentCode,
    this.children,
    this.select = false,
    this.enable = true,
    this.isAll = false,
  });

  LWItem copy() {
    return LWItem(
      name,
      code,
      displayName: displayName,
      otherInfo: otherInfo == null ? null : Map.from(otherInfo!),
      parentCode: parentCode,
      children: children == null ? null : children!.map((e) => e.copy()).toList(),
      select: select,
      enable: enable,
      isAll: isAll,
    );
  }

  LWItem allItem(String text) {
    return LWItem(name, code, displayName: text, parentCode: code, isAll: true);
  }
}
