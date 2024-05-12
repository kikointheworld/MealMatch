
import 'package:flutter/material.dart';

class TrackLocationButton extends StatelessWidget {
  final VoidCallback onTap;
  const TrackLocationButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: 55,
          height: 55,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(.4),
                  blurRadius: 5.0,
                  spreadRadius: 0.5,
                  offset: const Offset(
                    0.0,
                    0.0,
                  ),
                ),
              ]
          ),
          child: const Center(
            child: Icon(Icons.my_location, color: Colors.black87),
          ),
        ),
      ),
    );
  }
}
