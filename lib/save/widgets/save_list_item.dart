import 'package:flutter/material.dart';

class SaveListItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onMenuTapListener;
  final VoidCallback onTap;
  final VoidCallback? onDelete; // Make this nullable
  final VoidCallback? onEdit; // Add this for editing
  final Color iconColor;

  const SaveListItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onMenuTapListener,
    required this.onTap,
    this.onDelete,
    this.onEdit,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: Icon(icon, size: 30, color: iconColor),
            title: Text(title, overflow: TextOverflow.ellipsis,),
            subtitle: Text(subtitle, overflow: TextOverflow.ellipsis,),
            trailing: GestureDetector(
              onTap: onMenuTapListener,
              child: PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit') {
                    onEdit?.call();
                  } else if (value == 'delete') {
                    onDelete?.call();
                  }
                },
                itemBuilder: (BuildContext context) {
                  return [
                    PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ),
                  ];
                },
                child: const Icon(Icons.more_vert, size: 28),
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
          ),
          const SizedBox(height: 5),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Divider(color: Colors.grey),
          )
        ],
      ),
    );
  }
}



// import 'package:flutter/material.dart';
//
// class SaveListItem extends StatelessWidget {
//   final IconData icon;
//   final String title;
//   final String subtitle;
//   final VoidCallback? onEdit; // Change this line
//   final VoidCallback onTap;
//   final VoidCallback onDelete; // Add this line
//   final Color iconColor;
//
//   const SaveListItem({
//     super.key,
//     required this.icon,
//     required this.title,
//     required this.subtitle,
//     this.onEdit, // Change this line
//     required this.onTap,
//     required this.onDelete, // Add this line
//     required this.iconColor,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Column(
//         children: [
//           ListTile(
//             leading: Icon(icon, size: 30, color: iconColor),
//             title: Text(title),
//             subtitle: Text(subtitle),
//             trailing: PopupMenuButton<String>(
//               onSelected: (value) {
//                 if (value == 'edit') {
//                   onEdit?.call(); // Change this line
//                 } else if (value == 'delete') {
//                   onDelete();
//                 }
//               },
//               itemBuilder: (BuildContext context) {
//                 return [
//                   PopupMenuItem(
//                     value: 'edit',
//                     child: Text('Edit'),
//                   ),
//                   PopupMenuItem(
//                     value: 'delete',
//                     child: Text('Delete'),
//                   ),
//                 ];
//               },
//               child: const Icon(Icons.more_vert, size: 28),
//             ),
//             contentPadding: const EdgeInsets.symmetric(horizontal: 20.0),
//           ),
//           const SizedBox(height: 5),
//           const Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0),
//             child: Divider(color: Colors.grey),
//           )
//         ],
//       ),
//     );
//   }
// }