extension ListExtension<E> on List<E> {
  E? firstWhereOrNull(bool Function(E element) test) {
    for (var element in this) {
      if (test(element)) return element;
    }
    return null;
  }

  E? get firstOrNull {
    var iterator = this.iterator;
    if (iterator.moveNext()) return iterator.current;
    return null;
  }

  E? get lastOrNull {
    if (isEmpty) return null;
    return last;
  }
}

extension List2Extension<E> on List<E>? {
  ///判断为null为空
  bool get isNullOrEmpty => this == null || this!.isEmpty;
}
