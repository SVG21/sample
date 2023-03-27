import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:sample_project/providers.dart';
import 'package:sample_project/ui/calendar_screen.dart';
import '../model/holiday_model.dart';

class HolidaysList extends HookConsumerWidget {
  const HolidaysList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

    useEffect(() {
      firebaseMessaging.getToken().then((token) {
        return token;
      });
    }, []);

    final holidaysFuture = ref.watch(holidaysProvider);
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        title: Text(
          "Holidays in the UK in a year",
          style: GoogleFonts.openSans(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
        centerTitle: false,
      ),
      body: holidaysFuture.when(
        data: (holidays) {
          return HolidaysListView(
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
    );
  }
}

class HolidaysListView extends HookConsumerWidget {
  final List<Holidays> holidays;

  const HolidaysListView({Key? key, required this.holidays}) : super(key: key);

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
                    backgroundColor: Colors.green,
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
                Icons.calendar_month,
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
                DateFormat.yMMMEd().format(event.date),
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalendarScreen(
                      title: event.title!,
                      currentSelectedDate: event.date,
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
