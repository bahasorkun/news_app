import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: const [
            // Buraya mevcut menü öğelerini aynen taşı
            ListTile(leading: Icon(Icons.home), title: Text('Ana Sayfa')),
            ListTile(leading: Icon(Icons.settings), title: Text('Ayarlar')),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('Hakkında'),
            ),
          ],
        ),
      ),
    );
  }
}
