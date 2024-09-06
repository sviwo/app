class EventBus {
  EventBus._();

  static final EventBus _singleton = EventBus._();

  factory EventBus.instance() => _singleton;

  final Map _cacheOwner = {};

  Map get cache {
    return _cacheOwner;
  }

  //添加订阅者
  void register(owner, eventName, _Callback f) {
    Map ownerMap = _cacheOwner[owner] ?? {};
    ownerMap[eventName] = f;
    _cacheOwner[owner] = ownerMap;
  }

  //移除订阅者
  void unregister(owner, eventName) {
    Map ownerMap = _cacheOwner[owner] ?? {};
    ownerMap.remove(eventName);
    if (ownerMap.isEmpty) {
      _cacheOwner.remove(owner);
    } else {
      _cacheOwner[owner] = ownerMap;
    }
  } 

  //触发事件，事件触发后该事件所有订阅者会被调用
  void post(eventName, [arg]) {
    var eventMaps = _cacheOwner.values;
    for (var index = 0; index < eventMaps.length; index++) {
      // for (final eventMap in eventMaps) {
      var eventMap = eventMaps.elementAt(index);
      var f = eventMap[eventName];
      if (f != null) {
        f!(arg);
      }
    }
  }
}

// 回调签名
typedef _Callback = void Function(dynamic arg);
