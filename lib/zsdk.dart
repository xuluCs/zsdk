import 'dart:async';
import 'package:flutter/services.dart';
import 'package:zsdk/src/printer_connection_data.dart';
import 'package:zsdk/src/enumerators/cause.dart';
import 'package:zsdk/src/enumerators/error_code.dart';
import 'package:zsdk/src/enumerators/orientation.dart';
import 'package:zsdk/src/enumerators/status.dart';
import 'package:zsdk/src/printer_conf.dart';
import 'package:zsdk/src/printer_response.dart';
import 'package:zsdk/src/printer_settings.dart';
import 'package:zsdk/src/status_info.dart';

export 'package:zsdk/src/enumerators/cause.dart';
export 'package:zsdk/src/enumerators/error_code.dart';
export 'package:zsdk/src/enumerators/head_close_action.dart';
export 'package:zsdk/src/enumerators/media_type.dart';
export 'package:zsdk/src/enumerators/orientation.dart';
export 'package:zsdk/src/enumerators/power_up_action.dart';
export 'package:zsdk/src/enumerators/print_method.dart';
export 'package:zsdk/src/enumerators/print_mode.dart';
export 'package:zsdk/src/printer_conf.dart';
export 'package:zsdk/src/printer_response.dart';
export 'package:zsdk/src/printer_settings.dart';
export 'package:zsdk/src/enumerators/reprint_mode.dart';
export 'package:zsdk/src/enumerators/virtual_device.dart';
export 'package:zsdk/src/enumerators/status.dart';
export 'package:zsdk/src/status_info.dart';
export 'package:zsdk/src/enumerators/zpl_mode.dart';
export 'package:zsdk/src/printer_connection_data.dart';

class ZSDK {
  static const int DEFAULT_ZPL_TCP_PORT = 9100;

  ///In seconds
  static const int DEFAULT_CONNECTION_TIMEOUT = 10;

  /// Channel
  static const String _METHOD_CHANNEL = "zsdk";

  /// Methods
  static const String _PRINT_PDF_FILE_OVER_TCP_IP = "printPdfFileOverTCPIP";
  static const String _PRINT_PDF_DATA_OVER_TCP_IP = "printPdfDataOverTCPIP";
  static const String _PRINT_ZPL_FILE_OVER_TCP_IP = "printZplFileOverTCPIP";
  static const String _PRINT_ZPL_DATA_OVER_TCP_IP = "printZplDataOverTCPIP";
  static const String _CHECK_PRINTER_STATUS_OVER_TCP_IP =
      "checkPrinterStatusOverTCPIP";
  static const String _GET_PRINTER_SETTINGS_OVER_TCP_IP =
      "getPrinterSettingsOverTCPIP";
  static const String _SET_PRINTER_SETTINGS_OVER_TCP_IP =
      "setPrinterSettingsOverTCPIP";
  static const String _DO_MANUAL_CALIBRATION_OVER_TCP_IP =
      "doManualCalibrationOverTCPIP";
  static const String _PRINT_CONFIGURATION_LABEL_OVER_TCP_IP =
      "printConfigurationLabelOverTCPIP";
  static const String _FIND_PRINTERS_OVER_TCP_IP = "findPrintersOverTCPIP";
  static const String _FIND_PRINTERS_OVER_BLUETOOTH = "findPrintersOverBluetooth";
  static const String _REBOOT_PRINTER_OVER_TCP_IP = "rebootPrinterOverBluetooth";
  static const String _PRINT_PDF_FILE_OVER_BLUETOOTH = "printPdfFileOverBluetooth";
  static const String _PRINT_PDF_DATA_OVER_BLUETOOTH = "printPdfDataOverBluetooth";
  static const String _PRINT_ZPL_FILE_OVER_BLUETOOTH = "printZplFileOverBluetooth";
  static const String _PRINT_ZPL_DATA_OVER_BLUETOOTH = "printZplDataOverBluetooth";
  static const String _CHECK_PRINTER_STATUS_OVER_BLUETOOTH =
      "checkPrinterStatusOverBluetooth";
  static const String _GET_PRINTER_SETTINGS_OVER_BLUETOOTH =
      "getPrinterSettingsOverBluetooth";
  static const String _SET_PRINTER_SETTINGS_OVER_BLUETOOTH =
      "setPrinterSettingsOverBluetooth";
  static const String _DO_MANUAL_CALIBRATION_OVER_BLUETOOTH =
      "doManualCalibrationOverBluetooth";
  static const String _PRINT_CONFIGURATION_LABEL_OVER_BLUETOOTH =
      "printConfigurationLabelOverBluetooth";
  static const String _REBOOT_PRINTER_OVER_BLUETOOTH = "rebootPrinterOverBluetooth";

  /// Properties
  static const String _filePath = "filePath";
  static const String _data = "data";
  static const String _address = "address";
  static const String _port = "port";
  static const String _cmWidth = "cmWidth";
  static const String _cmHeight = "cmHeight";
  static const String _orientation = "orientation";
  static const String _dpi = "dpi";

  late MethodChannel _channel;
  void Function(PrinterConnectionData)? printerFound;

  ZSDK({this.printerFound}) {
    _channel = const MethodChannel(_METHOD_CHANNEL);
    _channel.setMethodCallHandler(_onMethodCall);
  }

  Future<void> _onMethodCall(MethodCall call) async {
    switch (call.method) {
      case "printerFound":
        handlePrinterFound(call);
        break;
      default:
        print(call.arguments);
    }
  }

  FutureOr<T> _onTimeout<T>({Duration? timeout}) => throw PlatformException(
      code: ErrorCode.EXCEPTION.name,
      message:
          "Connection timeout${timeout != null ? " after ${timeout.inSeconds} seconds of waiting" : "."}",
      details: PrinterResponse(
        errorCode: ErrorCode.EXCEPTION,
        message:
            "Connection timeout${timeout != null ? " after ${timeout.inSeconds} seconds of waiting" : "."}",
        statusInfo: StatusInfo(
          Status.UNKNOWN,
          Cause.NO_CONNECTION,
        ),
      ).toMap());

  Future doManualCalibrationOverTCPIP(
          {required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_DO_MANUAL_CALIBRATION_OVER_TCP_IP, {
        _address: address,
        _port: port,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future printConfigurationLabelOverTCPIP(
          {required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_PRINT_CONFIGURATION_LABEL_OVER_TCP_IP, {
        _address: address,
        _port: port,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future rebootPrinterOverTCPIP(
          {required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_REBOOT_PRINTER_OVER_TCP_IP, {
        _address: address,
        _port: port,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future checkPrinterStatusOverTCPIP(
          {required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_CHECK_PRINTER_STATUS_OVER_TCP_IP, {
        _address: address,
        _port: port,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future getPrinterSettingsOverTCPIP(
          {required String address, int? port, Duration? timeout}) =>
      _channel.invokeMethod(_GET_PRINTER_SETTINGS_OVER_TCP_IP, {
        _address: address,
        _port: port,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future setPrinterSettingsOverTCPIP(
          {required PrinterSettings settings,
          required String address,
          int? port,
          Duration? timeout}) =>
      _channel
          .invokeMethod(
              _SET_PRINTER_SETTINGS_OVER_TCP_IP,
              {
                _address: address,
                _port: port,
              }..addAll(settings.toMap()))
          .timeout(
              timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
              onTimeout: () => _onTimeout(timeout: timeout));

  Future resetPrinterSettingsOverTCPIP(
          {required String address, int? port, Duration? timeout}) =>
      setPrinterSettingsOverTCPIP(
          settings: PrinterSettings.defaultSettings(),
          address: address,
          port: port,
          timeout: timeout);

  Future printPdfFileOverTCPIP(
          {required String filePath,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printFileOverTCPIP(
          method: _PRINT_PDF_FILE_OVER_TCP_IP,
          filePath: filePath,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future printZplFileOverTCPIP(
          {required String filePath,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printFileOverTCPIP(
          method: _PRINT_ZPL_FILE_OVER_TCP_IP,
          filePath: filePath,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future _printFileOverTCPIP(
          {required method,
          required String filePath,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _channel.invokeMethod(method, {
        _filePath: filePath,
        _address: address,
        _port: port,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future printPdfDataOverTCPIP(
          {required Uint8List data,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printPdfDataOverTCPIP(
          method: _PRINT_PDF_DATA_OVER_TCP_IP,
          data: data,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future printZplDataOverTCPIP(
          {required String data,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printPdfDataOverTCPIP(
          method: _PRINT_ZPL_DATA_OVER_TCP_IP,
          data: data,
          address: address,
          port: port,
          printerConf: printerConf,
          timeout: timeout);

  Future _printPdfDataOverTCPIP(
          {required method,
          required dynamic data,
          required String address,
          int? port,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _channel.invokeMethod(method, {
        _data: data,
        _address: address,
        _port: port,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future findPrintersOverBluetooth() => _channel.invokeMethod(_FIND_PRINTERS_OVER_BLUETOOTH);

  Future findPrintersOverTCPIP() => _channel.invokeMethod(_FIND_PRINTERS_OVER_TCP_IP);

  Future doManualCalibrationOverBluetooth(
          {required String address, Duration? timeout}) =>
      _channel.invokeMethod(_DO_MANUAL_CALIBRATION_OVER_BLUETOOTH, {
        _address: address,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future printConfigurationLabelOverBluetooth(
          {required String address, Duration? timeout}) =>
      _channel.invokeMethod(_PRINT_CONFIGURATION_LABEL_OVER_BLUETOOTH, {
        _address: address,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future rebootPrinterOverBluetooth(
          {required String address, Duration? timeout}) =>
      _channel.invokeMethod(_REBOOT_PRINTER_OVER_BLUETOOTH, {
        _address: address,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future checkPrinterStatusOverBluetooth(
          {required String address, Duration? timeout}) =>
      _channel.invokeMethod(_CHECK_PRINTER_STATUS_OVER_BLUETOOTH, {
        _address: address,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future getPrinterSettingsOverBluetooth(
          {required String address, Duration? timeout}) =>
      _channel.invokeMethod(_GET_PRINTER_SETTINGS_OVER_BLUETOOTH, {
        _address: address,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future setPrinterSettingsOverBluetooth(
          {required PrinterSettings settings,
          required String address,
          Duration? timeout}) =>
      _channel
          .invokeMethod(
              _SET_PRINTER_SETTINGS_OVER_BLUETOOTH,
              settings.toMap()..addAll({
                _address: address,
              }))
          .timeout(
              timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
              onTimeout: () => _onTimeout(timeout: timeout));

  Future resetPrinterSettingsOverBluetooth(
          {required String address, Duration? timeout}) =>
      setPrinterSettingsOverBluetooth(
          settings: PrinterSettings.defaultSettings(),
          address: address,
          timeout: timeout);

  Future printPdfFileOverBluetooth(
          {required String filePath,
          required String address,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printFileOverBluetooth(
          method: _PRINT_PDF_FILE_OVER_BLUETOOTH,
          filePath: filePath,
          address: address,
          printerConf: printerConf,
          timeout: timeout);

  Future printZplFileOverBluetooth(
          {required String filePath,
          required String address,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printFileOverBluetooth(
          method: _PRINT_ZPL_FILE_OVER_BLUETOOTH,
          filePath: filePath,
          address: address,
          printerConf: printerConf,
          timeout: timeout);

  Future _printFileOverBluetooth(
          {required method,
          required String filePath,
          required String address,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _channel.invokeMethod(method, {
        _filePath: filePath,
        _address: address,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  Future printPdfDataOverBluetooth(
          {required Uint8List data,
          required String address,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printPdfDataOverBluetooth(
          method: _PRINT_PDF_DATA_OVER_BLUETOOTH,
          data: data,
          address: address,
          printerConf: printerConf,
          timeout: timeout);

  Future printZplDataOverBluetooth(
          {required String data,
          required String address,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _printPdfDataOverBluetooth(
          method: _PRINT_ZPL_DATA_OVER_BLUETOOTH,
          data: data,
          address: address,
          printerConf: printerConf,
          timeout: timeout);

  Future _printPdfDataOverBluetooth(
          {required method,
          required dynamic data,
          required String address,
          PrinterConf? printerConf,
          Duration? timeout}) =>
      _channel.invokeMethod(method, {
        _data: data,
        _address: address,
        _cmWidth: printerConf?.cmWidth,
        _cmHeight: printerConf?.cmHeight,
        _dpi: printerConf?.dpi,
        _orientation: printerConf?.orientation?.name,
      }).timeout(
          timeout ??= const Duration(seconds: DEFAULT_CONNECTION_TIMEOUT),
          onTimeout: () => _onTimeout(timeout: timeout));

  void handlePrinterFound(MethodCall call) {
    printerFound!(PrinterConnectionData.fromJson(call.arguments as String));
  }
}
