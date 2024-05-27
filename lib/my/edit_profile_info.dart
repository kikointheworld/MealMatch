import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileInfoPage extends StatefulWidget {
  final String initialUserName;
  final String initialEmail;

  const EditProfileInfoPage({
    Key? key,
    required this.initialUserName,
    required this.initialEmail,
  }) : super(key: key);

  @override
  _EditProfileInfoPageState createState() => _EditProfileInfoPageState();
}

class _EditProfileInfoPageState extends State<EditProfileInfoPage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  XFile? _image; // Holds the selected image file
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialUserName);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? selectedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (selectedImage != null) {
      setState(() {
        _image = selectedImage;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile Information'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              // Save changes logic here
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: _image == null
                    ? AssetImage('image/human.jpeg')
                    : FileImage(File(_image!.path)) as ImageProvider,
                child: Icon(Icons.camera_alt, color: Colors.white70),
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
          ],
        ),
      ),
    );
  }
}
