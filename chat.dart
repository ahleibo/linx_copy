import 'package:flutter/material.dart';
import 'profile_detail_page.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    final List<Map<String, String>> chats = [
      {"username": "@daniellaguerrero", "lastMessage": "Sent yesterday", "imageUrl": "https://via.placeholder.com/150"},
      {"username": "@adinleibovich", "lastMessage": "Check out this pizza spot!", "imageUrl": "https://via.placeholder.com/150"},
      {"username": "@clarkgronek", "lastMessage": "Hey man really loved your post!", "imageUrl": "https://via.placeholder.com/150"},
    ];

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        title: Text(
          'Messages (${chats.length.toString().padLeft(2, '0')})',
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Geist',
            letterSpacing: -0.8,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: chats.length,
        itemBuilder: (context, index) {
          final chat = chats[index];
          return ChatItem(
            username: chat['username']!,
            lastMessage: chat['lastMessage']!,
            imageUrl: chat['imageUrl']!,
            onTap: () {
              // Navigate to ProfileDetailPage when tapping a chat item
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProfileDetailPage(
                    username: chat['username']!,
                    imageUrl: chat['imageUrl']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final String username;
  final String lastMessage;
  final String imageUrl;
  final VoidCallback onTap;

  ChatItem({
    required this.username,
    required this.lastMessage,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(imageUrl),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontFamily: 'Geist',
                      fontWeight: FontWeight.bold,
                      letterSpacing: -0.8,
                    ),
                  ),
                  Text(
                    lastMessage,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                      fontSize: 14,
                      fontFamily: 'Geist',
                      letterSpacing: -0.8,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
