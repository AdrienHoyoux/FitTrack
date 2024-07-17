import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../classes/AppUser.dart';

const String USERS_COLLECTION_REF = 'users';


class DatabaseService {

  // **************************** INSTANCES **************************** //

  static final DatabaseService _instance = DatabaseService._internal();
  static final _auth = FA.FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _firebase_storage = FirebaseStorage.instance.ref();

  // **************************** VARIABLES **************************** //
  UploadTask? _uploadTask;
  static final _usersRef = _firestore.collection(USERS_COLLECTION_REF).withConverter<Appuser>(fromFirestore: (snapshots, _) => Appuser.fromJson(snapshots.data()!), toFirestore: (user, _) => user.toJson());

  // **************************** CONSTRUCTEUR **************************** //
  DatabaseService._internal();

  // **************************** METHODES **************************** //

  factory DatabaseService() {
    return _instance;
  }

  Future<void> addUser(Appuser user)  async {
     try{
        FA.User? fireBaseUser = _auth.currentUser;
        if(fireBaseUser != null){
          String uid = fireBaseUser.uid;
          _usersRef.doc(uid).set(user);
        }
     }catch (e) {
       print("Erreur lors de la création de l'utilisateur : $e");
     }
  }

  Future<void> uploadFile(PlatformFile pickedFile) async {
    try {

      FA.User? firebaseUser = _auth.currentUser;

      if (firebaseUser != null) {
        String uid = firebaseUser.uid;
        String path = 'files/$uid/${pickedFile.name}';
        File file = File(pickedFile.path!);

        Reference ref = _firebase_storage.child(path);
        UploadTask uploadTask = ref.putFile(file);

        await uploadTask.whenComplete(() async {
          // Obtenir l'URL de téléchargement de l'image
          String downloadUrl = await ref.getDownloadURL();

          // Mettre à jour l'utilisateur avec l'URL de l'image
          await _usersRef.doc(uid).update({'imageURL': downloadUrl});
        });
      } else {
        print("Erreur: Aucun utilisateur connecté");
      }
    } catch (e) {
      print("Erreur lors du téléchargement de l'image : $e");
    }
  }

  Future<Appuser?> getCurrentUser() async {
    FA.User? firebaseUser = _auth.currentUser;
    if (firebaseUser != null) {
      DocumentSnapshot<Appuser> docSnapshot = await _usersRef.doc(firebaseUser.uid).get();
      return docSnapshot.data();
    }
    return null;
  }


  Future<void> updateUser(Appuser user) async {
    try {
      FA.User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        String uid = firebaseUser.uid;
        _usersRef.doc(uid).update(user.toJson());
      }
      else {
        print("Erreur: Aucun utilisateur connecté");
      }
    }
    catch (e) {
      print("Erreur lors de la mise à jour de l'utilisateur : $e");
    }
  }

  Future<String?> loadImage(String path) async{
    try{
      final url = await _firebase_storage.child(path).getDownloadURL();
      if(url != null){
        return url;
      }
      else{
        return null;
      }
    }
catch(e){
      print("Erreur lors du chargement de l'image : $e");
    }
  }


}