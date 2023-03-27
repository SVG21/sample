import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sample_project/ui/holidays_list.dart';

class SplashScreen extends HookWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2)).then((_) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (BuildContext context) => const HolidaysList(),
        ),
      );
    });

    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          'Explore with us!!',
          style: GoogleFonts.openSans(
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
