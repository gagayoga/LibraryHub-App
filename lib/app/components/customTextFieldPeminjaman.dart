import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFieldPeminjaman extends StatelessWidget {
  final bool obsureText;
  final String? initialValue;
  final String labelText;
  final Widget? preficIcon;
  final Widget? surficeIcon;

  const CustomTextFieldPeminjaman({
    super.key,
    required this.obsureText,
    required this.initialValue,
    required this.labelText,
    this.preficIcon,
    this.surficeIcon,
  });

  @override
  Widget build(BuildContext context) {
    const Color background =  Color(0xFF260534);
    const Color colorText =  Color(0xFF858896);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        enabled: false,
        initialValue: initialValue,
        obscureText: obsureText,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black.withOpacity(0.80),
        ),
        decoration: InputDecoration(
          prefixIcon: preficIcon,
          suffixIcon: surficeIcon,
          prefixIconColor: background,
          labelText: labelText,
          labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              color: background
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(color: background, width: 1.8),
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: background, width: 1.8),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder:  OutlineInputBorder(
            borderSide: const BorderSide(color: background, width: 1.8),
            borderRadius: BorderRadius.circular(10),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        ),
      ),
    );
  }
}
