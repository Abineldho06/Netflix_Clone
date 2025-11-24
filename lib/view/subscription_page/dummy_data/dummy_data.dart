import 'package:netflix_clone/models/subscription_model/subscription_model.dart';

List<SubscriptionModel> subscriptions = [
  SubscriptionModel(
    title: "Mobile",
    price: 149,
    quality: "Fair",
    resolution: "480P",
    supportDevices: "Mobile phone, tablet",
    watchsametime: 1,
    downloaddevices: 1,
  ),
  SubscriptionModel(
    title: "Basic",
    price: 199,
    quality: "good",
    resolution: "720 (HD)",
    supportDevices: "TV, Computer,\nMobile phone, tablet",
    watchsametime: 1,
    downloaddevices: 1,
  ),
  SubscriptionModel(
    title: "Standard",
    price: 499,
    quality: "gret",
    resolution: "1080 (Full HD)",
    supportDevices: "TV, Computer,\nMobile phone, tablet",
    watchsametime: 2,
    downloaddevices: 2,
  ),
  SubscriptionModel(
    title: "Premium",
    price: 649,
    quality: "Best",
    resolution: "4k (Ultra HD) + HDR",
    supportDevices: "TV, Computer,\nMobile phone, tablet",
    watchsametime: 4,
    downloaddevices: 6,
  ),
];
