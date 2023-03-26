import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../model/holiday_model.dart';
import '../repositories/holiday_repository.dart';

class HolidaysList extends HookConsumerWidget {
  const HolidaysList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    useEffect(() {
      firebaseMessaging.getToken().then((token) {
        print('Firebase Messaging Token: $token');
      });
    }, []);
    final currentIndex = useState(0);

    final holidaysFuture = ref.watch(holidaysProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 30.0),
            child: GestureDetector(
                onTap: () {
                  print("tapped");
                  FirebaseMessaging.onMessage
                      .listen((RemoteMessage message) async {
                    print('Got a message whilst in the foreground!');
                    print('Message data: ${message.data}');
                    if (message.notification != null) {
                      print(
                          'Message also contained a notification: ${message.notification}');
                      print('Received a notification:');
                      print('Title: ${message.notification?.title}');
                      print('Body: ${message.notification?.body}');
                    }
                    var androidPlatformChannelSpecifics =
                        const AndroidNotificationDetails(
                            'message-notifications', 'Message Notifications',
                            importance: Importance.max, priority: Priority.high);

                    var platformChannelSpecifics = NotificationDetails(
                      android: androidPlatformChannelSpecifics,
                    );
                    flutterLocalNotificationsPlugin.show(
                        0,
                        message.notification?.title,
                        message.notification?.body,
                        platformChannelSpecifics,
                        payload: message.data['your-data']);
                  });
                },
                child: Icon(Icons.notification_add)),
          )
        ],
        title: Text(
          "Holidays in the UK in a year",
          style: GoogleFonts.openSans(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        centerTitle: true,
      ),
      body: holidaysFuture.when(
        data: (holidays) {
          return _HolidaysListView(
            holidays: holidays,
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => Center(
          child: Text(
            'Failed to load holidays: $error',
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex.value,
        selectedItemColor: Colors.green,
        onTap: (index) => currentIndex.value = index,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Holidays',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timer),
            label: 'Countdown',
          ),
          // Add more items here as needed
        ],
      ),
    );
  }
}

class _HolidaysListView extends HookConsumerWidget {
  final List<Holidays> holidays;

  const _HolidaysListView({Key? key, required this.holidays}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scrollController = useScrollController();
    final itemsToShow = useState(7);

    return SafeArea(
      child: ListView.builder(
        controller: scrollController,
        itemCount: itemsToShow.value + 1,
        itemBuilder: (context, index) {
          if (index == itemsToShow.value) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    itemsToShow.value += 5;
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                      vertical: 12.0,
                      horizontal: 24.0,
                    ),
                  ),
                  child: const Text(
                    'Load more',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            );
          }

          final event = holidays[0].englandAndWales.events[index];

          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: ListTile(
              leading: const Icon(
                Icons.calendar_today,
                color: Colors.green,
                size: 32.0,
              ),
              title: Text(
                event.title!,
                style: GoogleFonts.openSans(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                event.date.toString(),
                style: GoogleFonts.openSans(
                  fontSize: 16.0,
                  color: Colors.grey[600],
                ),
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                color: Colors.grey[400],
              ),
              onTap: () {
                // Add onTap functionality here
              },
            ),
          );
        },
      ),
    );
  }
}
