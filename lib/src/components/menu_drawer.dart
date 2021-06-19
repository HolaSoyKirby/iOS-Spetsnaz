import 'package:flutter/material.dart';
import '../pages/platillos_page.dart';
import '../pages/almacen_page.dart';
import '../pages/profile_page.dart';

class MenuDrawer extends StatefulWidget {
  String _user;

  MenuDrawer(user) {
    _user = user;
  }

  @override
  createState() {
    return MenuDrawerState(_user);
  }
}

class MenuDrawerState extends State<MenuDrawer> {
  String _user;
  MenuDrawerState(user) {
    _user = user;
  }

  int _selectDrawerItem = 0;

  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return AlmacenPage();
      case 1:
        return PlatillosPage();
      case 2:
        return ProfilePage(_user);
    }
  }

  _onSelectItem(int pos) {
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Drawer Header'),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Text('Almacén'),
                onTap: () {
                  _onSelectItem(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Platillos'),
                onTap: () {
                  _onSelectItem(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Usuario'),
                onTap: () {
                  _onSelectItem(2);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
        body: _getDrawerItemWidget(_selectDrawerItem));
  }
}
