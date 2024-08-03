// 推送数据到哦服务器 模型

import 'dart:ffi';

class PushDataServiceBean {
  String deviceType =
      "CustomCategory"; //": "CustomCategory", //类型默认是自定义（CustomCategory）
  String? productKey; //": "k0ugjmf1ois", //产品key
  String? gmtCreate; //": 1717314066384, //消息常创建时间
  String? deviceName; //": "sviwo-23kj4h2k3b4kk2",//设备名称

  PushDataServiceItemBean items = PushDataServiceItemBean();

  Map<String, dynamic> toJson() {
    return {"deviceType":deviceType,"productKey":productKey,"gmtCreate":gmtCreate,"deviceName":deviceName,"items":items.toJson()};
  }
}

class PushDataServiceItemBean {
  // 实际转速
  PushDataServiceItemKeyValueBean RotateSpeed =
      PushDataServiceItemKeyValueBean();

  // 剩余里程
  PushDataServiceItemKeyValueBean RemainMile =
      PushDataServiceItemKeyValueBean();

  // 电池电量
  PushDataServiceItemKeyValueBean Electricity =
      PushDataServiceItemKeyValueBean();

  // 速度
  PushDataServiceItemKeyValueBean VehSpeed = PushDataServiceItemKeyValueBean();

  // 行驶里程
  PushDataServiceItemKeyValueBean Mileage = PushDataServiceItemKeyValueBean();

  // 地理位置
  PushDataServiceItemKeyValueBean GeoLocation =
      PushDataServiceItemKeyValueBean();

  // 产品型号
  PushDataServiceItemKeyValueBean ProductModel =
      PushDataServiceItemKeyValueBean();

  Map<String, dynamic> toJson() {
    return {
      "RotateSpeed": RotateSpeed.toJson(),
      "RemainMile": RemainMile.toJson(),
      "Electricity": Electricity.toJson(),
      "VehSpeed": VehSpeed.toJson(),
      "Mileage": Mileage.toJson(),
      "GeoLocation": GeoLocation.toJson(),
      "ProductModel": ProductModel.toJson()
    };
  }
}

class PushDataServiceItemKeyValueBean {
  // 属性值
  String? value = "0"; //": 0,
  // 时间戳 毫秒
  String? time = "0"; //": 1722651691055

  Map<String, dynamic> toJson() {
    return {"value": value, "time": time};
  }
}
