import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'explore.dart';
import 'web.dart';
import 'chat.dart';
import 'main.dart';

class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedIndex = 2; // Index for Notifications tab

  final List<Widget> _pages = [
    HomeScreen(),
    ExplorePage(),
    NotificationPage(), // Current page
    ChatPage(),
    MainPage(),
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;
    setState(() {
      _selectedIndex = index;
    });

    // Navigate to the corresponding page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => _pages[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = true; // Replace with your actual theme provider.

    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        title: Text(
          "Activity (6)", // Example count; replace with dynamic count if needed
          style: TextStyle(
            color: isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView(
        children: [
          buildNotificationItem(
            isDarkMode: isDarkMode,
            profileImagePath: 'assets/images/LNXLOGO.png',
            content: "Look back at this link from a year ago",
          ),
          buildNotificationItem(
            isDarkMode: isDarkMode,
            profileImagePath: 'assets/images/LNXLOGO.png',
            content: "Recommended Collection/Post",
          ),
          buildNotificationItem(
            isDarkMode: isDarkMode,
            profileImagePath: 'assets/images/profile3.jpg',
            content: "@daniellaguerrero Posted a collection 15m",
          ),
          buildNotificationItem(
            isDarkMode: isDarkMode,
            profileImagePath: 'assets/images/LNXLOGO.png',
            content: "Economics posted a link",
          ),
          buildNotificationItem(
            isDarkMode: isDarkMode,
            profileImagePath: 'assets/images/profile3.jpg',
            content: "@daniellaguerrero Followed you",
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        unselectedItemColor:
            isDarkMode ? Colors.white : Colors.black54, // Unselected items
        selectedItemColor:
            isDarkMode ? Colors.white : Colors.black, // Selected item
        currentIndex: _selectedIndex, // Set the current active tab
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: "Explore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications), label: "Notifications"),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: "Chat"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }

  Widget buildNotificationItem({
    required bool isDarkMode,
    required String profileImagePath,
    required String content,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profileImagePath),
      ),
      title: Text(
        content,
        style: TextStyle(
          color: isDarkMode ? Colors.white : Colors.black,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: isDarkMode ? Colors.white : Colors.black,
        size: 16,
      ),
      onTap: () {
        // Handle notification item click.
      },
    );
  }
}
//helloworld