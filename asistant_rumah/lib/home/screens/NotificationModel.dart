// notification_model.dart
class NotificationModel {
  final int orderId;
  final String isi;

  NotificationModel({required this.orderId, required this.isi});

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      orderId: json['order_id'],
      isi: json['isi'],
    );
  }
}
