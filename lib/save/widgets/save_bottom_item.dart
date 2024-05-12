import 'package:flutter/material.dart';
import 'package:mealmatch/config/palette.dart';

class SaveBottomItem extends StatelessWidget {
  final IconData icon;
  final String title;
  const SaveBottomItem({super.key, required this.icon, required this.title});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: Colors.grey),
              ),
              child: Center(
                child: Icon(icon, color: Colors.blue[800],),
              ),
            ),
            const SizedBox(height: 5,),
            Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: Colors.blue[800]),
            )
          ],
        )
    );
  }
}
