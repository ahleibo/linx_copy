import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';
import 'package:flutter/cupertino.dart';

class WebPage extends StatefulWidget {
  @override
  _WebPageState createState() => _WebPageState();
}

class _WebPageState extends State<WebPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool showFilters = false;

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
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48.0,
                  decoration: BoxDecoration(
                    color:
                        themeProvider.isDarkMode ? Colors.black : Colors.white,
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      width: 2.0,
                    ),
                  ),
                  child: TextField(
                    style: TextStyle(
                      color: themeProvider.isDarkMode
                          ? Colors.white
                          : Colors.black,
                      fontFamily: 'Geist',
                      letterSpacing: -0.8,
                    ),
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search,
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black),
                      hintText: 'Search or Chat with AI',
                      hintStyle: TextStyle(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black54,
                        fontFamily: 'Geist',
                        letterSpacing: -0.8,
                      ),
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
                  color: Color(0xFF78DE00),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  icon: Icon(Icons.add, color: Color(0xFF000000)),
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
          unselectedLabelColor:
              themeProvider.isDarkMode ? Colors.grey : Colors.black54,
          indicatorColor:
              themeProvider.isDarkMode ? Colors.white : Colors.black,
          tabs: [
            Tab(
              child: Text(
                'Graphs',
                style: TextStyle(
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
            ),
            Tab(
              child: Text(
                'Insights',
                style: TextStyle(
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GraphTab(
            showFilters: showFilters,
            onFilterToggle: () {
              setState(() {
                showFilters = !showFilters;
              });
            },
          ),
          InsightsTab(),
        ],
      ),
    );
  }
}

class GraphTab extends StatelessWidget {
  final bool showFilters;
  final VoidCallback onFilterToggle;

  GraphTab({required this.showFilters, required this.onFilterToggle});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: onFilterToggle,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        themeProvider.isDarkMode ? Colors.black : Colors.white,
                    side: BorderSide(
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                        width: 2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Filter',
                        style: TextStyle(
                          color: themeProvider.isDarkMode
                              ? Colors.white
                              : Colors.black,
                          fontFamily: 'Geist',
                          letterSpacing: -0.8,
                        ),
                      ),
                      Icon(
                        showFilters
                            ? Icons.arrow_drop_down
                            : Icons.arrow_forward_ios,
                        color: themeProvider.isDarkMode
                            ? Colors.white
                            : Colors.black,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (showFilters)
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    FilterChipWidget(label: 'Photos'),
                    FilterChipWidget(label: 'Videos'),
                    FilterChipWidget(label: 'Instagram'),
                    FilterChipWidget(label: 'TikTok'),
                    FilterChipWidget(label: 'Posts'),
                  ],
                ),
              ),
            ),
          Container(
            margin: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              color: themeProvider.isDarkMode ? Colors.black : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 20,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.network(
              'https://via.placeholder.com/400x400',
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}

class FilterChipWidget extends StatelessWidget {
  final String label;

  FilterChipWidget({required this.label});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
      margin: const EdgeInsets.only(right: 8.0),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor:
              themeProvider.isDarkMode ? Colors.black : Colors.white,
          side: BorderSide(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Geist',
            letterSpacing: -0.8,
          ),
        ),
      ),
    );
  }
}

class InsightsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        InsightCard(),
        InsightCard(),
        InsightCard(),
      ],
    );
  }
}

class InsightCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Container(
        margin: const EdgeInsets.only(bottom: 16.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: themeProvider.isDarkMode ? Colors.black : Colors.white,
          border: Border.all(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              width: 2),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Data Type',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              fontFamily: 'Geist',
              letterSpacing: -0.8,
              fontSize: 16,
            ),
          ),
          Text(
            'Sub Data Type',
            style: TextStyle(
              color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
              fontFamily: 'Geist',
              letterSpacing: -0.8,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8),
          Container(
              height: 150.0,
              color: themeProvider.isDarkMode
                  ? Colors.grey[900]
                  : Colors.grey[300],
              child: Center(
                child: Text(
                  'Chart or Data Visualization here',
                  style: TextStyle(
                    color: Colors.grey,
                    fontFamily: 'Geist',
                    letterSpacing: -0.8,
                  ),
                ),
              ))
        ]));
  }
}
