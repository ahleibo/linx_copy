import 'package:flutter/material.dart';

class EditTopicPage extends StatefulWidget {
  final List<String> topics;

  EditTopicPage({required this.topics});

  @override
  _EditTopicPageState createState() => _EditTopicPageState();
}

class _EditTopicPageState extends State<EditTopicPage> {
  late List<String> _topics;

  @override
  void initState() {
    super.initState();
    _topics = List.from(widget.topics); // Clone the original list
  }

  void _onReorder(int oldIndex, int newIndex) {
    setState(() {
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final String topic = _topics.removeAt(oldIndex);
      _topics.insert(newIndex, topic);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit Topics',
          style: TextStyle(
            color: Colors.white,
            fontFamily: 'Geist',
            letterSpacing: -0.8,
          ),
        ),
      ),
      body: ReorderableListView(
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        onReorder: _onReorder,
        children: [
          for (int index = 0; index < _topics.length; index++)
            ListTile(
              key: ValueKey(_topics[index]),
              leading: CircleAvatar(
                backgroundColor: Colors.grey[800],
                child: Text(
                  _topics[index][0],
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Geist',
                    letterSpacing: -0.8,
                  ),
                ),
              ),
              title: Text(
                _topics[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              trailing: Icon(Icons.drag_handle, color: Colors.white),
              tileColor: Colors.black,
            ),
        ],
      ),
    );
  }
}
