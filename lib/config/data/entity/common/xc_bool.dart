enum XCBool {
  TRUE(label: "是", value: 1),
  FALSE(label: "否", value: 0);

  final String label;
  final int value;

  const XCBool({required this.value, required this.label});
}
