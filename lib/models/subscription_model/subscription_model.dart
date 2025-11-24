class SubscriptionModel {
  final String title;
  final int price;
  final String quality;
  final String resolution;
  final String supportDevices;
  final int watchsametime;
  final int downloaddevices;

  SubscriptionModel({
    required this.title,
    required this.price,
    required this.quality,
    required this.resolution,
    required this.supportDevices,
    required this.watchsametime,
    required this.downloaddevices,
  });
}
