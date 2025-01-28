import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'theme_provider.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,
              color: themeProvider.isDarkMode ? Colors.white : Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Settings',
          style: TextStyle(
            color: themeProvider.isDarkMode ? Colors.white : Colors.black,
            fontFamily: 'Geist',
            letterSpacing: -0.8, // Adjusted letter spacing
          ),
        ),
      ),
      backgroundColor: themeProvider.isDarkMode ? Colors.black : Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              title: Text(
                'Edit Profile',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              subtitle: Text(
                'Username, bio, password...',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Privacy',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              subtitle: Text(
                'Overlaps, data, share',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Notifications',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              subtitle: Text(
                'Push, Time, Events...',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Help',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              subtitle: Text(
                'Faq, Feature Request, Bugs...',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios,
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black),
              onTap: () {},
            ),
            ListTile(
              title: Text(
                'Appearance',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              subtitle: Text(
                'Light or Dark',
                style: TextStyle(
                  color: themeProvider.isDarkMode ? Colors.grey : Colors.black54,
                  fontFamily: 'Geist',
                  letterSpacing: -0.8,
                ),
              ),
              trailing: Switch(
                value: themeProvider.isDarkMode,
                onChanged: (bool value) {
                  themeProvider.toggleTheme();
                },
                activeColor: Colors.white,
                activeTrackColor: Colors.grey,
                inactiveThumbColor: Colors.grey,
                inactiveTrackColor: Colors.black12,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                onPressed: () {},
                child: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Geist',
                    letterSpacing: -0.8,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: themeProvider.isDarkMode
                      ? Colors.grey[900]
                      : Colors.grey[300],
                  foregroundColor:
                      themeProvider.isDarkMode ? Colors.white : Colors.black,
                  side: BorderSide(
                      color: themeProvider.isDarkMode ? Colors.white : Colors.black,
                      width: 1),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
