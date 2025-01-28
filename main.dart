import 'dart:async';
import 'image_detail_page.dart';
import 'home_screen.dart';
import 'chat.dart';
import 'settings_page.dart';
import 'notification_page.dart'; // Update with the correct file path
import 'explore.dart';
import 'web.dart';
import 'collection_detail_page.dart';
import 'theme_provider.dart';
import 'image_upload_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:linxflutterapp/supabase_image.dart';
import 'package:supabase_flutter/supabase_flutter.dart' show FileObject;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
// push to the one we got in github

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Supabase
  await Supabase.initialize(
    url:
        "https://ysfvvbsqdwrbkqrqrwrp.supabase.co", // Replace with your Supabase URL
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InlzZnZ2YnNxZHdyYmtxcnFyd3JwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MjM3NDE4NzUsImV4cCI6MjAzOTMxNzg3NX0.loGrvjKZh-EERC56hOH9831vwbYlg8WyZxhWr7U54JM', // Replace with your Supabase Anon Key
  );

  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Add this line
      themeMode: themeProvider.themeMode,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.black),
          titleTextStyle: TextStyle(color: Colors.black, fontFamily: 'Geist'),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black,
          iconTheme: IconThemeData(color: Colors.white),
          titleTextStyle: TextStyle(color: Colors.white, fontFamily: 'Geist'),
        ),
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
      ),
      home: MainPage(), // Use MainPage as the home screen
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with SingleTickerProviderStateMixin {
  int _selectedIndex = 0;
  late TabController _tabController;

  final List<Widget> _pages = [
    HomeScreen(),
    ExplorePage(),
    WebPage(),
    ChatPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        unselectedItemColor:
            themeProvider.isDarkMode ? Colors.white : Colors.black54,
        selectedItemColor:
            themeProvider.isDarkMode ? Colors.white : Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.web), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _postCountController = StreamController<int>();

  // These lists represent the items in the tabs
  final List<String> _collections =
      List.generate(6, (index) => 'Collection $index');
  int _postCount = 0;
  // final List<String> _posts = List.generate(153, (index) => 'Post $index');

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    getPostCount();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _postCountController.close();
    super.dispose();
  }

  Future<void> getPostCount() async {
    try {
      print('Starting to fetch files...');
      final List<FileObject> files = await Supabase.instance.client.storage
          .from('image_objects')
          .list(path: 'profile_posts');

      print('Files fetched successfully. Count: ${files.length}');
      _postCountController.add(files.length);
    } catch (e) {
      print('Error getting post count: ${e.toString()}');
      _postCountController.add(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => NotificationPage()),
              );
            },
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () {},
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
        ],
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) => [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Ali Abdaal',
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                              letterSpacing: -0.8,
                              fontFamily: 'Geist'),
                        ),
                        Text(
                          '@aliabdaal',
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.grey
                                  : Colors.black54,
                              fontSize: 13,
                              letterSpacing: -0.8,
                              fontFamily: 'Geist'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'UI/UX, Brand Designer',
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 13,
                              letterSpacing: -0.8,
                              fontFamily: 'Geist'),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'aliabdaal.com',
                          style: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.blue
                                  : Colors.blueAccent,
                              letterSpacing: -0.8,
                              fontFamily: 'GeistMono',
                              fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  SupabaseImage(
                    imageName: 'image 135.png',
                    radius: 45,
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 26.0, 16.0, 56.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 48.0,
                      margin: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: themeProvider.isDarkMode
                            ? Colors.black
                            : Colors.white,
                        borderRadius: BorderRadius.circular(8.0),
                        border: Border.all(
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            width: 2.0),
                      ),
                      child: TextField(
                        style: TextStyle(
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                            letterSpacing: -0.8,
                            fontFamily: 'Geist'),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: themeProvider.isDarkMode
                                ? Colors.white
                                : Colors.black,
                          ),
                          hintText: 'Search and Explore',
                          hintStyle: TextStyle(
                              color: themeProvider.isDarkMode
                                  ? Colors.white
                                  : Colors.black54,
                              letterSpacing: -0.8,
                              fontFamily: 'Geist'),
                          filled: true,
                          fillColor: themeProvider.isDarkMode
                              ? Colors.black
                              : Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.0),
                            borderSide: BorderSide.none,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 12.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: themeProvider.isDarkMode
                          ? Color(0xFF78DE00)
                          : Colors.blueAccent,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add,
                        color: themeProvider.isDarkMode
                            ? Color(0xFF000000)
                            : Colors.white,
                      ),
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
                                onPressed: () async {
                                  Navigator.pop(context);
                                  final uploadState = _ImageUploadWidgetState();
                                  final uploadWidget = ImageUploadWidget(
                                    onUploadComplete: (urls) {
                                      setState(() {
                                        getPostCount();
                                      });
                                    },
                                    bucket: 'image_objects',
                                    folder: 'profile_posts',
                                  );
                                  
                                  await uploadState.handleImageUpload(ImageSource.gallery);
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
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            Container(
              color: themeProvider.isDarkMode ? Colors.black : Colors.white,
              child: TabBar(
                controller: _tabController,
                labelColor:
                    themeProvider.isDarkMode ? Colors.white : Colors.black,
                unselectedLabelColor: themeProvider.isDarkMode
                    ? Color(0xFF767676)
                    : Colors.black54,
                indicatorColor:
                    themeProvider.isDarkMode ? Colors.white : Colors.black,
                tabs: [
                  Tab(
                      text:
                          'Collections (${_collections.length.toString().padLeft(2, '0')})'),
                  StreamBuilder<int>(
                    stream: _postCountController.stream,
                    initialData: 0,
                    builder: (context, snapshot) {
                      return Tab(
                          text:
                              'Posts (${snapshot.data.toString().padLeft(2, '0')})');
                    },
                  ),
                  Tab(text: 'Insights'),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  CollectionsTab(),
                  PostsTab(
                    posts: [],
                    onCountUpdated: (count) {
                      _postCountController.add(count);
                    },
                  ),
                  Center(
                    child: Text(
                      'Insights',
                      style: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        letterSpacing: -0.8,
                        fontFamily: 'Geist',
                      ),
                    ),
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

class CollectionsTab extends StatefulWidget {
  @override
  _CollectionsTabState createState() => _CollectionsTabState();
}

// Updated CollectionsTab to accept the list of collections
class _CollectionsTabState extends State<CollectionsTab> {
  final supabase = Supabase.instance.client;
  List<String> collections = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCollections();
  }

Future<void> loadCollections() async {
  try {
    print('Starting to fetch collections...');
    final List<FileObject> files = await supabase.storage
        .from('image_objects')
        .list(path: 'aliAbdaal_Collections');

    print('Raw files list:');
    for (var file in files) {
      print('File name: ${file.name}');
    }

    // Get folders directly (they won't have file extensions)
    Set<String> uniqueFolders = files
        .where((file) => 
            file.name.startsWith('aliAbdaal_Collection_') && 
            !file.name.contains('.'))
        .map((file) => file.name)
        .toSet();

    print('Found folders: ${uniqueFolders.join(', ')}');

    var sortedFolders = uniqueFolders.toList()..sort((a, b) {
      int aNum = int.parse(a.split('_').last);
      int bNum = int.parse(b.split('_').last);
      return aNum.compareTo(bNum);
    });

    print('Final sorted folders: ${sortedFolders.join(', ')}');

    setState(() {
      collections = sortedFolders;
      isLoading = false;
    });
  } catch (e) {
    print('Error loading collections: ${e.toString()}');
    print('Error stack trace: ${e is Error ? e.stackTrace : ''}');
    setState(() {
      isLoading = false;
    });
  }
}

Future<List<String>> getCollectionImages(String collectionName) async {
  try {
    print('Fetching images for collection: $collectionName');
    final List<FileObject> files = await supabase.storage
        .from('image_objects')
        .list(path: 'aliAbdaal_Collections/$collectionName');

    print('Files found in collection: ${files.length}');
    print('Raw files in collection: ${files.map((f) => f.name).join(', ')}');

    List<String> urls = files
        .where((file) => 
            !file.name.contains('/') && 
            (file.name.toLowerCase().endsWith('.jpg') || 
            file.name.toLowerCase().endsWith('.jpeg') ||
            file.name.toLowerCase().endsWith('.png') ||
            file.name.toLowerCase().endsWith('.gif'))
        )
        .map((file) {
          String url = supabase.storage
              .from('image_objects')
              .getPublicUrl('aliAbdaal_Collections/$collectionName/${file.name}');
          print('Generated URL for ${file.name}: $url');
          return url;
        })
        .toList();

    print('Generated URLs for collection: ${urls.length}');
    return urls.take(3).toList();
  } catch (e) {
    print('Error fetching collection images: ${e.toString()}');
    return [];
  }
}
  String formatCollectionTitle(String folderName) {
    // Convert 'aliAbdaal_Collection_0' to 'Collection 0'
    return 'Collection ${folderName.split('_').last}';
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    if (isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (collections.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'No collections found',
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                fontSize: 16,
                letterSpacing: -0.8,
                fontFamily: 'Geist',
              ),
            ),
            SizedBox(height: 8),
            Text(
              'Please check your Supabase storage structure',
              style: TextStyle(
                color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                fontSize: 14,
                letterSpacing: -0.8,
                fontFamily: 'Geist',
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(top: 26.0),
      itemCount: collections.length,
      itemBuilder: (context, index) {
        return FutureBuilder<List<String>>(
          future: getCollectionImages(collections[index]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CollectionGridItem(
                images: [],
                title: formatCollectionTitle(collections[index]),
                isDarkMode: themeProvider.isDarkMode,
                isLoading: true,
                collectionPath: 'aliAbdaal_Collections/${collections[index]}',
              );
            }

            return CollectionGridItem(
              images: snapshot.data ?? [],
              title: formatCollectionTitle(collections[index]),
              isDarkMode: themeProvider.isDarkMode,
              isLoading: false,
              collectionPath: 'aliAbdaal_Collections/${collections[index]}',
            );
          },
        );
      },
    );
  }
}

class PostsTab extends StatelessWidget {
  final List<String> posts;
  final supabase = Supabase.instance.client;
  final Function(int) onCountUpdated;

  PostsTab({
    required this.posts,
    required this.onCountUpdated,
  });

  // Modified function to get image URLs from Supabase
  Future<List<String>> getImageUrls() async {
    try {
      print('Fetching files from Supabase storage...');
      final List<FileObject> files = await supabase.storage
          .from('image_objects')
          .list(path: 'profile_posts');

      List<String> urls = files
          .map((file) => supabase.storage
              .from('image_objects')
              .getPublicUrl('profile_posts/${file.name}'))
          .toList();

      onCountUpdated(urls.length); // Add this line
      return urls;
    } catch (e) {
      print('Error fetching images: ${e.toString()}');
      onCountUpdated(0); // Add this line
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return FutureBuilder<List<String>>(
      future: getImageUrls(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          print('Error: ${snapshot.error}');
          return Center(child: Text('Error loading images: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No images found in the bucket'));
        }

        final imageUrls = snapshot.data!;
        print('Total URLs generated: ${imageUrls.length}');

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 26.0),
          child: MasonryGridView.count(
            crossAxisCount: 2,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) {
              return PostItem(
                imageUrl: imageUrls[index],
                aspectRatio: index % 3 == 0
                    ? 4 / 5
                    : index % 3 == 1
                        ? 16 / 9
                        : 1 / 1,
                isDarkMode: themeProvider.isDarkMode,
              );
            },
          ),
        );
      },
    );
  }
}

class CollectionGridItem extends StatelessWidget {
  final List<String> images;
  final String title;
  final bool isDarkMode;
  final bool isLoading;
  final String collectionPath;  // Add this line

  CollectionGridItem({
    required this.images,
    required this.title,
    required this.isDarkMode,
    required this.isLoading,
    required this.collectionPath,  // Add this line
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CollectionDetailPage(
              collectionName: title,
              collectionPath: collectionPath,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 200,
              child: isLoading
                  ? Center(child: CircularProgressIndicator())
                  : Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: _buildImage(
                            images.isNotEmpty ? images[0] : null,
                            BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                        ),
                        const SizedBox(width: 2),
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: _buildImage(
                                  images.length > 1 ? images[1] : null,
                                  BorderRadius.only(topRight: Radius.circular(8)),
                                ),
                              ),
                              const SizedBox(height: 2),
                              Expanded(
                                child: _buildImage(
                                  images.length > 2 ? images[2] : null,
                                  BorderRadius.only(bottomRight: Radius.circular(8)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: TextStyle(
                  color: isDarkMode ? Colors.white : Colors.black,
                  fontSize: 16,
                  letterSpacing: -0.8,
                  fontFamily: 'Geist',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? imageUrl, BorderRadius borderRadius) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: Colors.grey[300],
      ),
      child: ClipRRect(
        borderRadius: borderRadius,
        child: imageUrl != null
            ? Image.network(
                imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              )
            : Container(
                color: Colors.grey[300],
                child: Icon(Icons.image, color: Colors.grey[400]),
              ),
      ),
    );
  }
}


class PostItem extends StatelessWidget {
  final String imageUrl;
  final double aspectRatio;
  final bool isDarkMode;

  PostItem({
    required this.imageUrl,
    required this.aspectRatio,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth;
        double height = width / aspectRatio;

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetailPage(imageUrl: imageUrl),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: isDarkMode ? Colors.grey[800] : Colors.grey[300],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}