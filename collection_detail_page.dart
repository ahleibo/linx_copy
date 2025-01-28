import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'theme_provider.dart';
import 'image_detail_page.dart';

class CollectionDetailPage extends StatefulWidget {
  final String collectionName;
  final String collectionPath;

  CollectionDetailPage({
    required this.collectionName,
    required this.collectionPath,
  });

  @override
  _CollectionDetailPageState createState() => _CollectionDetailPageState();
}

class _CollectionDetailPageState extends State<CollectionDetailPage> {
  final supabase = Supabase.instance.client;
  List<String> imageUrls = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadCollectionImages();
  }

  Future<void> loadCollectionImages() async {
    try {
      print('Fetching images for collection: ${widget.collectionPath}');
      final List<FileObject> files = await supabase.storage
          .from('image_objects')
          .list(path: widget.collectionPath);

      // Filter for image files and get their public URLs
      imageUrls = files
          .where((file) => 
              !file.name.contains('/') && 
              (file.name.toLowerCase().endsWith('.jpg') || 
              file.name.toLowerCase().endsWith('.jpeg') ||
              file.name.toLowerCase().endsWith('.png') ||
              file.name.toLowerCase().endsWith('.gif'))
          )
          .map((file) => supabase.storage
              .from('image_objects')
              .getPublicUrl('${widget.collectionPath}/${file.name}'))
          .toList();

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error loading collection images: ${e.toString()}');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          widget.collectionName,
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            fontSize: 20,
            letterSpacing: -0.8,
            fontFamily: 'Geist',
          ),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : imageUrls.isEmpty
              ? Center(
                  child: Text(
                    'No images in this collection',
                    style: TextStyle(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 16,
                      letterSpacing: -0.8,
                      fontFamily: 'Geist',
                    ),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MasonryGridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: 20,
                    crossAxisSpacing: 20,
                    itemCount: imageUrls.length,
                    itemBuilder: (context, index) {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          double width = constraints.maxWidth;
                          double aspectRatio = index % 3 == 0
                              ? 4 / 5
                              : index % 3 == 1
                                  ? 16 / 9
                                  : 1 / 1;
                          double height = width / aspectRatio;

                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ImageDetailPage(
                                    imageUrl: imageUrls[index],
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: themeProvider.isDarkMode
                                    ? Colors.grey[800]
                                    : Colors.grey[300],
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  imageUrls[index],
                                  width: width,
                                  height: height,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
    );
  }
}