import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled/models/myuser.dart';
import 'package:untitled/screens/Home/home.dart';
import 'package:untitled/screens/authenticate/authenticate.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Myuser?>(context);
    if(user == null){
      return Authenticate();
    }else{
          return Home();
    }
  }
}