import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CalendarScreen extends StatelessWidget {
  final DateTime currentSelectedDate;
  final String title;

  const CalendarScreen({
    super.key,
    required this.currentSelectedDate,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'message-notifications',
      'Message Notifications',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    return Scaffold(
      floatingActionButton: ElevatedButton(
        onPressed: () async {
          await flutterLocalNotificationsPlugin
              .initialize(initializationSettings);
          await flutterLocalNotificationsPlugin.show(
            1,
            'Have you planned your vacation yet for $title',
            'explore more with us',
            platformChannelSpecifics,
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: const Text(
          'Get Notification',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListView(
          children: [
            CalendarCarousel<Event>(
              onDayPressed: (DateTime date, List<Event> events) {},
              weekendTextStyle: const TextStyle(
                color: Colors.red,
              ),
              thisMonthDayBorderColor: Colors.grey,
              weekFormat: false,
              height: 500,
              selectedDateTime: currentSelectedDate,
              daysHaveCircularBorder: false,
            ),
            Text(
              'The Holiday You have selected is $title which is on ${DateFormat.yMMMEd().format(currentSelectedDate)}',
              style: GoogleFonts.openSans(
                fontSize: 20.0,
                fontWeight: FontWeight.w300,
                color: Colors.green.withOpacity(0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
