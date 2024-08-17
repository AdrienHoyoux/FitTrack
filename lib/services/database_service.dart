import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart' as FA;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:FitTrack/classes/firebase_exception.dart';
import 'package:FitTrack/classes/race.dart';
import '../classes/app_user.dart';

const String USERS_COLLECTION_REF = 'users';
const String RACES_COLLECTION_REF = 'races';

class DatabaseService {

  // **************************** INSTANCES **************************** //

  static final DatabaseService _instance = DatabaseService._internal();
  static final _auth = FA.FirebaseAuth.instance;
  static final _firestore = FirebaseFirestore.instance;
  static final _firebase_storage = FirebaseStorage.instance.ref();

  // **************************** VARIABLES **************************** //
  static final _usersRef = _firestore.collection(USERS_COLLECTION_REF).withConverter<Appuser>(fromFirestore: (snapshots, _) => Appuser.fromJson(snapshots.data()!), toFirestore: (user, _) => user.toJson());

  // **************************** CONSTRUCTEUR **************************** //

  DatabaseService._internal();

  // **************************** METHODES **************************** //

  factory DatabaseService() {
    return _instance;
  }

  Future<AuthStatus> signInUser(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthStatus.successful;
    } on FA.FirebaseAuthException catch (e) {
      print("Erreur lors de la connexion de l'utilisateur :" + e.code);
      return AuthExceptionHandler.handleAuthException(e);
    }
  }

  Future<AuthStatus> registerUser(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthStatus.successful;
    } on FA.FirebaseAuthException catch (e) {
      return AuthExceptionHandler.handleAuthException(e);
    }
  }

  Future<AuthStatus> resetPassword(String email) async{
    try {
      await _auth
          .sendPasswordResetEmail(email: email);

      return AuthStatus.successful;

    } on FA.FirebaseAuthException catch (err) {
      return AuthExceptionHandler.handleAuthException(err);
    }
    catch(e){
      return AuthStatus.unknown;
    }
  }

  Future<void> addUser(Appuser user) async {
    try {
      FA.User? fireBaseUser = _auth.currentUser;
      if (fireBaseUser != null) {
        String uid = fireBaseUser.uid;
        _usersRef.doc(uid).set(user);
      }
    } catch (e) {
      print("Erreur lors de la création de l'utilisateur : $e");
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
      } else {
        print("Erreur: Aucun utilisateur connecté");
      }
    } catch (e) {
      print("Erreur lors de la mise à jour de l'utilisateur : $e");
    }
  }

  Future<void> deleteUser() async {
    try {
      FA.User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        String uid = firebaseUser.uid;
        await _usersRef.doc(uid).delete();
        await firebaseUser.delete();
      }
    } catch (e) {
      print("Erreur lors de la suppression de l'utilisateur : $e");
    }
  }

  Future<double> getUserWeight() async{
    try {
      FA.User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        String uid = firebaseUser.uid;
        DocumentSnapshot<Appuser> docSnapshot = await _usersRef.doc(uid).get();
        double weight = double.tryParse(docSnapshot.data()!.weight!) ?? 0.0;
        return weight;
      }
      return 0.0;
    } catch (e) {
      print("Erreur lors de la récupération du poids de l'utilisateur : $e");
      return 0;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Erreur lors de la déconnexion : $e");
    }
  }

  Future<String?> loadImage(String path) async {
    try {
      final url = await _firebase_storage.child(path).getDownloadURL();
      return url;
    } catch (e) {
      print('Error loading image: $e');
      return null;
    }
  }

  Future<void> uploadFile(PlatformFile pickedFile) async {
    try {
      FA.User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        String uid = firebaseUser.uid;
        String path = 'files/$uid/userprofile/profile_image.jpg';
        File file = File(pickedFile.path!);

        Reference ref = _firebase_storage.child(path);
        UploadTask uploadTask = ref.putFile(file);

        await uploadTask.whenComplete(() async {
          String downloadUrl = await ref.getDownloadURL();
          await _usersRef.doc(uid).update({'imageURL': downloadUrl});
        });
      } else {
        print("Erreur: Aucun utilisateur connecté");
      }
    } catch (e) {
      print("Erreur lors du téléchargement de l'image : $e");
    }
  }

  //******************************* RACE *******************************//

  Future<List<Race>> getRaces() async {
    try {
      FA.User? firebaseUser = FA.FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        String uid = firebaseUser.uid;

        CollectionReference racesRef = _firestore
            .collection(USERS_COLLECTION_REF)
            .doc(uid)
            .collection(RACES_COLLECTION_REF);

        QuerySnapshot snapshot = await racesRef.get();

        List<Race> races = snapshot.docs
            .map((doc) => Race.fromJson(doc.data() as Map<String, dynamic>, id: doc.id))
            .toList();

        return races;
      } else {
        print("Erreur: Aucun utilisateur connecté");
        return [];
      }
    } catch (e) {
      print("Erreur lors de la récupération des courses : $e");
      return [];
    }
  }

  Future<void> addRace(Race race) async {
    try {
      FA.User? fireBaseUser = _auth.currentUser;
      if (fireBaseUser != null) {
        String uid = fireBaseUser.uid;

        await _usersRef.doc(uid).collection(RACES_COLLECTION_REF).add(race.toJson());
      }
    } catch (e) {
      print("Erreur lors de l'ajout de la course : $e");
    }
  }

  Future<void> deleteRace(String raceId) async {
    try {
      FA.User? firebaseUser = _auth.currentUser;
      if (firebaseUser != null) {
        String uid = firebaseUser.uid;

        DocumentReference raceRef = _usersRef.doc(uid).collection(RACES_COLLECTION_REF).doc(raceId);
        await raceRef.delete();
        print("Course supprimée !");

      } else {
        print("Erreur: Aucun utilisateur connecté");
      }
    } catch (e) {
      print("Erreur lors de la suppression de la course : $e");
    }
  }

}
