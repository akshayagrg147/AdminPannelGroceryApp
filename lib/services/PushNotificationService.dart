
import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {
  FirebaseMessaging _fcm = FirebaseMessaging.instance;

  Future initialize() async {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);
    FirebaseMessaging.onBackgroundMessage((message) async {
     await showFlutterNotification(message);

    });
  }

  Future<String?> getToken() async {
    String? token = await _fcm.getToken();
    print('Token: $token');
    return token;
  }

  Future<void>  showFlutterNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    AndroidNotification? android = message.notification?.android;
    playSampleSound();
  }

  void playSampleSound() async {
    final player = AudioPlayer();
    await player.play(UrlSource('https://ik.imagekit.io/00itvcwwk/shopeefood_sound.mp3?updatedAt=1696573541986'));
    // AudioService().playSound(AssetSource('sound/beep.mp3'));

  }
}