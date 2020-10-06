import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Appbar {
  Icon visibleIcon;
  Widget searchBar;

  Appbar() {
    this.visibleIcon = Icon(
      Icons.search,
      size: 28,
      color: Colors.white,
    );

    this.searchBar = Text(
      'Movies and Tv',
      style: GoogleFonts.ubuntu(
        textStyle: TextStyle(
          color: Colors.white,
          letterSpacing: .5,
          fontWeight: FontWeight.bold,
          fontSize: 23,
        ),
      ),
    );
  }
}
