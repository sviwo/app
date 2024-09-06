import 'dart:io';

class XCObject {
  XCObject._internal();

  static bool? dynamicToBool(var value) {
    if (value == null) return null;
    if (value is bool) {
      return value;
    }
    return int.tryParse(value.toString()) == 1;
  }

  static List<bool>? dynamicToBoolList(var value) {
    if (value == null) return null;
    if (value is! List) return null;

    var newList = value.map((e) => int.tryParse(e.toString()) == 1).toList();
    return newList;
  }

  static dynamic boolToDynamic(bool value) {
    if (Platform.isIOS) {
      return value ? 1 : 0;
    } else {
      return value;
    }
  }

  static int? dynamicToInt(dynamic value) {
    if (value == null) return null;
    if (value is int) {
      return value;
    }
    if (value is bool) {
      return value ? 1 : 0;
    }
    return int.tryParse(value.toString());
  }

  static List<int>? dynamicToIntList(dynamic value) {
    if (value == null) return null;
    if (value is! List) return null;

    List<int> newList = [];
    for (var e in value) {
      var newValue = int.tryParse(e.toString());
      if (newValue != null) {
        newList.add(newValue);
      }
    }
    return newList;
  }

  static double? dynamicToDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) {
      return value;
    }
    return double.tryParse(value.toString());
  }

  static List<double>? dynamicToDoubleList(dynamic value) {
    if (value == null) return null;
    if (value is! List) return null;

    List<double> newList = [];
    for (var e in value) {
      var newValue = double.tryParse(e.toString());
      if (newValue != null) {
        newList.add(newValue);
      }
    }
    return newList;
  }

  static String? dynamicToString(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      return value;
    }
    return value.toString();
  }

  static List<String>? dynamicToStringList(dynamic value) {
    if (value == null) return null;
    if (value is! List) return null;

    List<String> newList = [];
    for (var e in value) {
      var newValue = e?.toString();
      if (newValue != null) {
        newList.add(newValue);
      }
    }
    return newList;
  }
}
