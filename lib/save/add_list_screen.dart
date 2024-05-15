import 'package:flutter/material.dart';
import 'package:mealmatch/models/bookmark_list.dart';
import 'package:mealmatch/services/data_manager.dart';
import 'package:provider/provider.dart';

class AddListPage extends StatefulWidget {
  final BookmarkList? initialData; // 추가
  final Function(BookmarkList)? onSave; // 추가

  const AddListPage({Key? key, this.initialData, this.onSave}) : super(key: key); // 수정

  @override
  _AddListPageState createState() => _AddListPageState();
}

class _AddListPageState extends State<AddListPage> {
  late TextEditingController _listNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _urlController;
  late String _selectedColor;
  bool _isPublic = false;

  @override
  void initState() {
    super.initState();

    // 초기값 설정
    _listNameController = TextEditingController(text: widget.initialData?.name ?? '');
    _descriptionController = TextEditingController(text: widget.initialData?.description ?? '');
    _urlController = TextEditingController();
    _selectedColor = widget.initialData?.color ?? 'red';
    _isPublic = false;
  }

  @override
  void dispose() {
    _listNameController.dispose();
    _descriptionController.dispose();
    _urlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.initialData == null ? 'Add List' : 'Edit List'), // 제목 변경
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _listNameController,
                decoration: InputDecoration(
                  labelText: 'Enter a list name.',
                  counterText: '0/20',
                ),
                maxLength: 20,
              ),
              SizedBox(height: 20),
              Text('Select color'),
              Container(
                height: 60,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: List.generate(11, (index) {
                    List<String> colors = ['red', 'orange', 'yellow', 'green', 'lime', 'blue', 'cyan', 'pink', 'pink2', 'purple', 'indigo'];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedColor = colors[index];
                        });
                      },
                      child: Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        child: CircleAvatar(
                          backgroundColor: _selectedColor == colors[index] ? Colors.grey : _getColor(colors[index]),
                          radius: 17, // 크기 조정
                          child: CircleAvatar(
                            backgroundColor: _getColor(colors[index]),
                            radius: 15, // 크기 조정
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
              SizedBox(height: 20),
              Text('Sharing options'),
              ListTile(
                title: Text('Public'),
                leading: Radio<bool>(
                  value: true,
                  groupValue: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Private'),
                leading: Radio<bool>(
                  value: false,
                  groupValue: _isPublic,
                  onChanged: (value) {
                    setState(() {
                      _isPublic = value!;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: 'Enter a note.',
                  counterText: '0/30',
                ),
                maxLength: 30,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _urlController,
                decoration: InputDecoration(
                  labelText: 'Add a URL.',
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[800],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            minimumSize: Size(double.infinity, 50), // 버튼의 크기 조정
          ),
          onPressed: () {
            if (_listNameController.text.isNotEmpty) {
              final newList = BookmarkList(
                name: _listNameController.text,
                color: _selectedColor,
                description: _descriptionController.text,
                isPublic: _isPublic,
              );
              if (widget.onSave != null) {
                widget.onSave!(newList); // onSave 콜백 호출
              } else {
                Provider.of<DataManager>(context, listen: false).addBookmarkList(newList);
              }
              Navigator.of(context).pop();
            }
          },
          child: Text('Done', style: TextStyle(fontSize: 18)),
        ),
      ),
    );
  }

  Color _getColor(String colorName) {
    switch (colorName) {
      case 'red':
        return Colors.red;
      case 'orange':
        return Colors.orange;
      case 'yellow':
        return Colors.yellow;
      case 'green':
        return Colors.green;
      case 'lime':
        return Colors.limeAccent[700]!;
      case 'blue':
        return Colors.blue;
      case 'cyan':
        return Colors.cyan;
      case 'pink2':
        return Colors.pink[200]!;
      case 'pink':
        return Colors.pink;
      case 'purple':
        return Colors.purple;
      case 'indigo':
        return Colors.indigo;
      default:
        return Colors.grey;
    }
  }
}