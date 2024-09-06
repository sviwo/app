class Filter {
  late String title;
  late bool isMultiple;
  late List<FilterItem> data;

  Filter(this.title, this.isMultiple, this.data);
}

class FilterItem {
  late String displayName;
  late String name;
  late String code;
  late Map<String, dynamic> otherInfo;
  bool isAll = false;
  bool select = false;

  FilterItem(this.name, this.code, {this.displayName = '', this.otherInfo = const {}, this.select = false, this.isAll = false});
}
