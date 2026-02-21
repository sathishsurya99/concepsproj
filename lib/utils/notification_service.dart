import 'dart:convert';
import '../all_packages.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initSettings = InitializationSettings(
      android: AndroidInitializationSettings('@mipmap/ic_launcher'),
      iOS: DarwinInitializationSettings(),
    );

    _notificationsPlugin.initialize(
      settings: initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );
  }

  static Future<void> showGameNotification(GameModel game) async {
    const AndroidNotificationDetails androidDetails =
        AndroidNotificationDetails(
          'gamezone_channel',
          'GameZone Alerts',
          channelDescription: 'Notifications for top rated games',
          importance: Importance.max,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        );

    const NotificationDetails platformDetails = NotificationDetails(
      android: androidDetails,
    );

    final payloadJson = jsonEncode({
      'id': game.id,
      'title': game.title,
      'thumbnail': game.thumbnail,
      'genre': game.genre,
      'platform': game.platform,
      'short_description': game.shortDescription,
    });

    await _notificationsPlugin.show(
      id: 0,
      title: 'Top Rated Game Pick!',
      body:
          'Check out ${game.title} - A massive ${game.genre} hit on ${game.platform}!',
      notificationDetails: platformDetails,
      payload: payloadJson,
    );
  }

  static void _onNotificationTapped(NotificationResponse response) {
    if (response.payload != null) {
      final Map<String, dynamic> gameData = jsonDecode(response.payload!);
      final selectedGame = GameModel.fromJson(gameData);
      Get.toNamed('/game', arguments: selectedGame);
    }
  }
}
