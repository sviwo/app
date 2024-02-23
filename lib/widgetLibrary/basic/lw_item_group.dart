import 'lw_item.dart';

class LWItemGroup {
  late String title;
  late List<LWItem> items;
  bool? isMultiple; //下面的 item 是否多选

  LWItemGroup(
    this.title,
    this.items, {
    this.isMultiple = true,
  });
}
