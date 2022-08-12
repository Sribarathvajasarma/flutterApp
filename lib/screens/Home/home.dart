import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import 'package:flutter/material.dart';
import 'package:untitled/screens/Home/settings_form.dart';
import 'package:untitled/services/auth.dart';
import 'package:untitled/services/database.dart';
import 'package:provider/provider.dart';
import 'package:untitled/screens/home/brew_list.dart';
import 'package:untitled/models/brew.dart';
class Home extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel() {
      showModalBottomSheet(
        context: context,
        builder: (context){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm(),
        );
        });
    }
    return StreamProvider<List<Brew>?>.value(
      value: DatabaseService(uid: '').brews,
      initialData: [],
      child: Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Brew crew'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          TextButton.icon(
            onPressed: () async {
              await _auth.sigOut();
            },
            icon: Icon(Icons.person),
            label: Text('logout'),
            
            ),
            TextButton.icon(
              onPressed: () => _showSettingsPanel(),
              icon: Icon(Icons.settings),
              label: Text('settings'),
            ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/coffee_bg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: BrewList()
      ),
    ),
    );
  }
}