//
// datetime.dart
// appflix
// 
// Author: wess (me@wess.io)
// Created: 01/11/2022
// 
// Copywrite (c) 2022 Wess.io
//

extension DateTimeExt on DateTime {
  static DateTime fromUnixTimestampInt(int timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(timestamp);
  }
  
  static DateTime fromUnixTimestampString(String timestamp) {
    return DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
  }
}