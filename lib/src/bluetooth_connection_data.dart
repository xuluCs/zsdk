import 'dart:convert';

class BluetoothConnectionData {
  String macAddress;
  String friendlyName;
  bool isLowEnergy;

  BluetoothConnectionData(
      this.macAddress,
      this.friendlyName,
      this.isLowEnergy
    );

  static BluetoothConnectionData fromJson(String jsonString){
    Map<String, dynamic> decoded = jsonDecode(jsonString) as Map<String, dynamic>;
    return BluetoothConnectionData(
        decoded['address'],
        decoded['friendlyName'],
        decoded['isLowEnergy'] == 'true' ? true : false,
    );
  }
}
