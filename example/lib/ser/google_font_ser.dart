import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

class GoogleFontSer {
  static final GoogleFontSer _ser = GoogleFontSer._internal();
  factory GoogleFontSer() => _ser;
  GoogleFontSer._internal();

  TextStyle arimo() => GoogleFonts.arimo(shadows: );
}
