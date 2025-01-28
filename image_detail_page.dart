import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class ImageDetailPage extends StatelessWidget {
  final String imageUrl;

  ImageDetailPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, 
            color: themeProvider.isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundColor: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
                    child: Icon(Icons.person, size: 20,
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '@UserName',
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Geist',
                    ),
                  ),
                ],
              ),
            ),
            
            // Full image
            Container(
              width: double.infinity,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),

            
            // Action buttons
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.bookmark_border),
                    onPressed: () {},
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.track_changes),
                    onPressed: () {},
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.chat_bubble_outline),
                    onPressed: () {},
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  ),
                  IconButton(
                    icon: Icon(Icons.share),
                    onPressed: () {},
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
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