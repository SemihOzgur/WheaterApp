import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyText extends StatelessWidget {
  MyText({super.key, required this.txt, required this.size});
  String txt;
  double size;
  @override
  Widget build(BuildContext context) {
    return Text(
      txt,
      style: GoogleFonts.oswald(
        textStyle: TextStyle(
          fontSize: size,
        ),
      ),
    );
  }
}
