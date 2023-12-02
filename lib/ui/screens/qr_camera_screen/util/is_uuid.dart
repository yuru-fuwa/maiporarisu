bool isUuid(String data) {
  RegExp uuidRegExp = RegExp(
    // r'^.*$',
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    caseSensitive: false,
    multiLine: false,
  );
  return uuidRegExp.hasMatch(data);
}
