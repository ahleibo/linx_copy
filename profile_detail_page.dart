import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'chat_screen.dart';

class ProfileDetailPage extends StatelessWidget {
  final String username;
  final String imageUrl;

  ProfileDetailPage({required this.username, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Scaffold(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        appBar: AppBar(
          backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, 
              color: themeProvider.isDarkMode ? Colors.white : Colors.black),
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
          actions: [
            IconButton(
              icon: Icon(Icons.more_vert, 
                color: themeProvider.isDarkMode ? Colors.white : Colors.black),
              onPressed: () {},
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundImage: NetworkImage(imageUrl),
                    ),
                    SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          username,
                          style: TextStyle(
                            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                            fontSize: 18,
                            fontFamily: 'Geist',
                            letterSpacing: -0.8,
                          ),
                        ),
                        Text(
                          '@' + username.toLowerCase(),
                          style: TextStyle(
                            color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                            fontSize: 14,
                            fontFamily: 'Geist',
                            letterSpacing: -0.8,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(username: username),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        foregroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
                      ),
                      child: Text(
                        'Message',
                        style: TextStyle(
                          fontFamily: 'Geist',
                          letterSpacing: -0.8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Geist'
                  ),
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search, 
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                    hintText: 'Search and Explore',
                    hintStyle: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black54,
                      fontFamily: 'Geist'
                    ),
                    filled: true,
                    fillColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        width: 2.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: OverlapDataWidget(),
              ),

              SizedBox(height: 16),

              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                  childAspectRatio: 2 / 3,
                ),
                itemCount: 6,
                itemBuilder: (context, index) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                      'https://via.placeholder.com/150',
                      fit: BoxFit.cover,
                    ),
                  );
                },
              ),

              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

class OverlapDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: themeProvider.isDarkMode ? Colors.black : Colors.white,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: themeProvider.isDarkMode 
              ? Colors.white.withOpacity(0.3) 
              : Colors.black.withOpacity(0.3)
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '21',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Geist',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Overlaps',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Geist',
                        letterSpacing: -0.8,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Sunglasses',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Geist',
                        letterSpacing: -0.8,
                      ),
                    ),
                    Text(
                      'Common Topic',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Geist',
                        letterSpacing: -0.8,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '8%',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Geist',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      'Post Overlap',
                      style: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                        fontFamily: 'Geist',
                        letterSpacing: -0.8,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 16),

            Container(
              height: 8.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[200],
              ),
              child: Row(
                children: [
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.pinkAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),

            Column(
              children: [
                OverlapSocialItem(label: 'INSTAGRAM', posts: 156, color: Colors.purple),
                OverlapSocialItem(label: 'TIKTOK', posts: 65, color: Colors.pink),
                OverlapSocialItem(label: 'TWITTER/X', posts: 13, color: Colors.blue),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class OverlapSocialItem extends StatelessWidget {
  final String label;
  final int posts;
  final Color color;

  OverlapSocialItem({
    required this.label,
    required this.posts,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 5,
                  backgroundColor: color,
                ),
                SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                    fontFamily: 'Geist',
                    letterSpacing: -0.8,
                  ),
                ),
              ],
            ),
            Text(
              'Posts (${posts.toString().padLeft(3, '0')})',
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                fontFamily: 'Geist',
                letterSpacing: -0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}