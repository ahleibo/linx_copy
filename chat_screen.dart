import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ChatScreen extends StatelessWidget {
  final String username;

  ChatScreen({required this.username});

  @override
  Widget build(BuildContext context) {
    // Use Consumer instead of Provider.of
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            username,
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Geist',
              letterSpacing: -0.8,
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  ChatBubble(
                    isSender: true,
                    message: "Hey! How's it going?",
                    isDarkMode: themeProvider.isDarkMode,
                  ),
                  ChatBubble(
                    isSender: false,
                    message: "I'm good, how about you?",
                    isDarkMode: themeProvider.isDarkMode,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Geist',
                      ),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black54,
                        ),
                        hintText: 'Write Message Here...',
                        hintStyle: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black54,
                          fontFamily: 'Geist',
                        ),
                        filled: true,
                        fillColor: themeProvider.isDarkMode ? Colors.black : Colors.grey[200],
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    ),
                    onPressed: () {
                      // Handle sending the message
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatBubble extends StatelessWidget {
  final bool isSender;
  final String message;
  final bool isDarkMode;

  ChatBubble({
    required this.isSender,
    required this.message,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16.0),
          padding: const EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            color: isSender
                ? (themeProvider.isDarkMode ? Colors.blueGrey[700] : Colors.blue[200])
                : (themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[300]),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Geist',
              letterSpacing: -0.8,
            ),
          ),
        ),
      ),
    );
  }
}