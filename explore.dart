import 'package:flutter/material.dart';
import 'editTopic.dart'; // Import the new editTopic.dart
import 'topic_detail.dart'; // Ensure this matches the file name of TopicDetailPage
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:flutter/cupertino.dart';

class ExplorePage extends StatefulWidget {
  @override
  _ExplorePageState createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<String> recommendedTopics = [
    'Economics',
    'Design',
    'Productivity',
    'Fashion Inspiration',
    'JavaScript Snippets'
  ];

  List<String> followingTopics = [
    'Puerto Rico',
    'Ali Abdaal',
    'Type Design',
    'Plants',
    'Thrifting'
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        automaticallyImplyLeading: false, // Hide the default back button
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
                    border: Border.all(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      fontFamily: 'Geist',
                      letterSpacing: -0.8,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: themeProvider.isDarkMode ? Colors.white : Colors.black),
                      hintText: 'Search and Explore',
                      hintStyle: TextStyle(
                        color: themeProvider.isDarkMode ? Colors.white : Colors.black54,
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
                  color: themeProvider.isDarkMode ? Color(0xFF78DE00) : Colors.blueAccent,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: themeProvider.isDarkMode ? Colors.black : Colors.white),
                  onPressed: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (BuildContext context) => CupertinoActionSheet(
                        title: Text(
                          'Import Media',
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 16,
                            letterSpacing: -0.8,
                          ),
                        ),
                        message: Text(
                          'Choose where to import your media from',
                          style: TextStyle(
                            fontFamily: 'Geist',
                            fontSize: 13,
                            letterSpacing: -0.8,
                          ),
                        ),
                        actions: <CupertinoActionSheetAction>[
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Implement camera roll import
                              print('Import from camera roll pressed');
                            },
                            child: Text(
                              'Import from Camera Roll',
                              style: TextStyle(
                                fontFamily: 'Geist',
                                letterSpacing: -0.8,
                              ),
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              Navigator.pop(context);
                              // TODO: Implement social media import
                              print('Import from social media pressed');
                            },
                            child: Text(
                              'Import from Social Media',
                              style: TextStyle(
                                fontFamily: 'Geist',
                                letterSpacing: -0.8,
                              ),
                            ),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          isDestructiveAction: true,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontFamily: 'Geist',
                              letterSpacing: -0.8,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
          unselectedLabelColor: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
          indicatorColor: themeProvider.isDarkMode ? Colors.white : Colors.black,
          labelStyle: TextStyle(
            fontFamily: 'Geist',
            letterSpacing: -0.8,
          ),
          tabs: [
            Tab(text: 'Suggested'),
            Tab(text: 'Topics'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          SuggestedTab(),
          TopicsTab(
            recommendedTopics: recommendedTopics,
            followingTopics: followingTopics,
          ),
        ],
      ),
    );
  }
}

// Add SuggestedTab widget
class SuggestedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      color: themeProvider.isDarkMode ? Colors.black : Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SuggestedItem(
            imageUrl: 'https://via.placeholder.com/300x200',
            title: 'Layout',
            username: '@arturomntl',
            profilePicUrl: 'https://via.placeholder.com/50',
          ),
          SuggestedItem(
            imageUrl: 'https://via.placeholder.com/300x200',
            title: 'Portrait Photography',
            username: '@daniellaguerrero',
            profilePicUrl: 'https://via.placeholder.com/50',
          ),
        ],
      ),
    );
  }
}

// Add SuggestedItem widget
class SuggestedItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String username;
  final String profilePicUrl;

  SuggestedItem({
    required this.imageUrl,
    required this.title,
    required this.username,
    required this.profilePicUrl,
  });

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

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

class TopicsTab extends StatelessWidget {
  final List<String> recommendedTopics;
  final List<String> followingTopics;

  TopicsTab({required this.recommendedTopics, required this.followingTopics});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      color: themeProvider.isDarkMode ? Colors.black : Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SectionHeader(
            title: 'Recommended',
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTopicPage(topics: recommendedTopics),
                ),
              );
            },
          ),
          for (var topic in recommendedTopics) TopicItem(topic: topic),
          SizedBox(height: 26),
          SectionHeader(
            title: 'Following',
            onEdit: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditTopicPage(topics: followingTopics),
                ),
              );
            },
          ),
          for (var topic in followingTopics) TopicItem(topic: topic),
        ],
      ),
    );
  }
}

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onEdit;

  SectionHeader({required this.title, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Geist',
            letterSpacing: -0.8,
          ),
        ),
        TextButton(
          onPressed: onEdit,
          child: Text(
            'Edit',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Geist',
              letterSpacing: -0.8,
            ),
          ),
        ),
      ],
    );
  }
}

class TopicItem extends StatelessWidget {
  final String topic;

  TopicItem({required this.topic});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TopicDetailPage(topic: topic),
            ),
          );
        },
        leading: CircleAvatar(
          radius: 20,
          backgroundColor: themeProvider.isDarkMode ? Colors.grey[800] : Colors.grey[300],
          child: Text(
            topic[0],
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Geist',
            ),
          ),
        ),
        title: Text(
          topic,
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            fontSize: 16,
            fontFamily: 'Geist',
          ),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          size: 16,
        ),
        tileColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      ),
    );
  }
}
