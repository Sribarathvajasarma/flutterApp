import 'package:firebase_auth/firebase_auth.dart';
import 'package:untitled/models/myuser.dart';
import 'package:untitled/services/database.dart';

class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
 
  // create user obj based on firebaseUser
  Myuser? _userFromFirebaseUser(User user){
    return user != null ? Myuser(uid: user.uid) : null; 
  }

  // auth change user stream
  Stream<Myuser> get user {
    return _auth.authStateChanges()
    .map((User? user) => _userFromFirebaseUser(user!)!);
  
  }  
  //sign in anon
  Future signInAnon() async {
    try{
      UserCredential result = await _auth.signInAnonymously();
      User user = result.user!;
      return _userFromFirebaseUser(user);
    } catch(e){ 
        print(e.toString());
      return null;
    }
  }

  //sign in email & password
  Future signInWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //signup
  Future registerWithEmailAndPassword(String email, String password) async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;

      await DatabaseService(uid: user.uid).updateUserData('0','new crew member', 100);
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future sigOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  } 
}