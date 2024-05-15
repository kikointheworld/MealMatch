import 'package:flutter/material.dart';

class SaveListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onMenuTapListener;
  final VoidCallback onTap;
  final Color iconColor;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const SaveListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onMenuTapListener,
    required this.onTap,
    required this.iconColor,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              icon,
              size: 30,
              color: iconColor,
            ),
            title: Text(title),
            subtitle: Text(subtitle),
            trailing: PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'Edit') {
                  onEdit();
                } else if (value == 'Delete') {
                  onDelete();
                }
              },
              itemBuilder: (BuildContext context) {
                return {'Edit', 'Delete'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
