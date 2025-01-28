import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        iconTheme: IconThemeData(
          color: themeProvider.isDarkMode ? Colors.white : Colors.black, // Back arrow color
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: themeProvider.isDarkMode ? Colors.white : Colors.black, // Selected text color
          unselectedLabelColor: themeProvider.isDarkMode ? Colors.white70 : Colors.black54, // Unselected text color
          indicatorColor: themeProvider.isDarkMode ? Colors.white : Colors.black, // Tab indicator color
          labelStyle: TextStyle(
            fontFamily: 'Geist',
            fontSize: 16,
            letterSpacing: -0.8,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Geist',
            fontSize: 16,
            letterSpacing: -0.8,
          ),
          tabs: [
            Tab(text: "Collections"),
            Tab(text: "Posts"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          CollectionsPage(),
          PostsPage(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class CollectionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      color: themeProvider.isDarkMode ? Colors.black : Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(top: 16.0),
        children: [
          CollectionItem(
            imageUrl: 'https://via.placeholder.com/150x200',
            title: 'Favorite Recipes',
            username: '@Kimdavis',
            profilePicUrl: 'https://via.placeholder.com/50',
          ),
          CollectionItem(
            imageUrl: 'https://via.placeholder.com/150x200',
            title: 'Summer Dresses',
            username: '@AshleyWilson',
            profilePicUrl: 'https://via.placeholder.com/50',
          ),
        ],
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
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200.0,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
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
                      letterSpacing: -0.8,
                    ),
                  ),
                  Text(
                    username,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                      fontSize: 13,
                      fontFamily: 'Geist',
                      letterSpacing: -0.8,
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

class PostsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      color: themeProvider.isDarkMode ? Colors.black : Colors.white,
      child: ListView(
        padding: const EdgeInsets.only(top: 16.0),
        children: [
          PostItem(
            imageUrl: 'https://via.placeholder.com/400x300',
            title: 'From the cam today',
            username: '@mashedPotatoes',
            profilePicUrl: 'https://via.placeholder.com/50',
            aspectRatio: 16 / 9,
          ),
          PostItem(
            imageUrl: 'https://via.placeholder.com/400x200',
            title: 'Data Science Methods',
            username: '@dataEnthusiast',
            profilePicUrl: 'https://via.placeholder.com/50',
            aspectRatio: 4 / 5,
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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              CircleAvatar(
                radius: 20,
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
                      letterSpacing: -0.8,
                    ),
                  ),
                  Text(
                    username,
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                      fontSize: 13,
                      fontFamily: 'Geist',
                      letterSpacing: -0.8,
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
