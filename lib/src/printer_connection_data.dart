import 'dart:convert';

enum PrinterConnectionType { bluetooth, network }

class PrinterConnectionData {
  String address;
  String? friendlyName;
  String? productName;
  PrinterConnectionType type;

  PrinterConnectionData(
    this.address,
    this.friendlyName,
    this.productName,
    this.type,
  );

  static PrinterConnectionData fromJson(String jsonString) {
    Map<String, dynamic> decoded =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return PrinterConnectionData(
      decoded['address'],
      decoded['friendlyName'],
      decoded['productName'],
      PrinterConnectionType.values.byName(decoded['type'] as String),
    );
  }

  String toJson() {
    return jsonEncode({
      'address': address,
      'friendlyName': friendlyName,
      'productName': productName,
      'type': type.name,
    });
  }
}
