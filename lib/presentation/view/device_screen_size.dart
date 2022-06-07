import 'package:flutter/material.dart';

class DeviceScreenSize {
  static getDeviceHeight(context) => MediaQuery.of(context).size.height;
  static getDeviceWidth(context) => MediaQuery.of(context).size.width;
}
