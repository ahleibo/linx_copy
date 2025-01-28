import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class TopicDetailPage extends StatelessWidget {
  final String topic;

  TopicDetailPage({required this.topic});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    TextEditingController searchController = TextEditingController();
    searchController.text = topic; // Prepopulate search bar with topic

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48.0,
                  decoration: BoxDecoration(
                    color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(color: themeProvider.isDarkMode ? Colors.white : Colors.black, width: 2.0),
                  ),
                  child: TextField(
                    controller: searchController,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      fontFamily: 'Geist',
                      letterSpacing: -0.8,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                      suffixIcon: IconButton(
                        icon: Icon(Icons.close, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                        onPressed: () {
                          // Clear search and go back to topics
                          Navigator.pop(context);
                        },
                      ),
                      hintText: 'Search and Explore',
                      hintStyle: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white54 : Colors.black54,
                        fontFamily: 'Geist',
                        letterSpacing: -0.8,
                      ),
                      filled: true,
                      fillColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF78DE00),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Color(0xFF000000)),
                  onPressed: () {
                    // Add new collection/post functionality can be added here
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Collections Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Collections",
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Geist',
                ),
              ),
            ),
            SizedBox(
              height: 200.0, // Height for horizontal list
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                children: [
                  CollectionItem(
                    imageUrl: 'https://via.placeholder.com/150x200',
                    title: 'Isla',
                    username: '@kikimonitilla',
                    profilePicUrl: 'https://via.placeholder.com/50',
                  ),
                  CollectionItem(
                    imageUrl: 'https://via.placeholder.com/150x200',
                    title: 'Donde Comer',
                    username: '@clarkgronek',
                    profilePicUrl: 'https://via.placeholder.com/50',
                  ),
                  // Add more CollectionItem widgets if needed
                ],
              ),
            ),
            // Posts Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Text(
                "Posts",
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Geist',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: MasonryGridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 34,
                itemBuilder: (context, index) {
                  return PostItem(
                    imageUrl: 'https://via.placeholder.com/400x300',
                    title: 'Post Title ${index + 1}',
                    username: '@username${index + 1}',
                    profilePicUrl: 'https://via.placeholder.com/50',
                    aspectRatio: index % 3 == 0 ? 4 / 5 : index % 3 == 1 ? 16 / 9 : 1 / 1,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CollectionItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String username;
  final String profilePicUrl;

  CollectionItem({
    required this.imageUrl,
    required this.title,
    required this.username,
    required this.profilePicUrl,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 150,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: NetworkImage(profilePicUrl),
              ),
              SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      fontFamily: 'Geist',
                    ),
                  ),
                  Text(
                    username,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                      fontSize: 13,
                      fontFamily: 'Geist',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class PostItem extends StatelessWidget {
  final String imageUrl;
  final double aspectRatio;
  final String title;
  final String username;
  final String profilePicUrl;

  PostItem({
    required this.imageUrl,
    required this.aspectRatio,
    required this.title,
    required this.username,
    required this.profilePicUrl,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = width / aspectRatio;

        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  width: width,
                  height: height,
                ),
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 16,
                    backgroundImage: NetworkImage(profilePicUrl),
                  ),
                  SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 16,
                          fontFamily: 'Geist',
                        ),
                      ),
                      Text(
                        username,
                        style: TextStyle(
                          color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                          fontSize: 13,
                          fontFamily: 'Geist'
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

