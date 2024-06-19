import 'package:intl/intl.dart';

class NotificationModel {
  final int id;
  final String title;
  final String body;
  final DateTime date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.date,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['notification_id'],
      title: json['notification_title'],
      body: json['notification_body'],
      date: DateFormat('yyyy-MM-dd HH:mm:ss').parse(json['notification_date']),
    );
  }

  String get formattedTime {
    return DateFormat('hh:mm a').format(date);
  }
}
