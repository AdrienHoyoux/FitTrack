import 'package:firebase_auth/firebase_auth.dart';

enum AuthStatus {
  NetworkRequestFailed,
  successful,
  userNotFound,
  wrongPassword,
  emailAlreadyExists,
  invalidEmail,
  invalidCredential,
  weakPassword,
  unknown,
}

class AuthExceptionHandler {
  static handleAuthException(FirebaseAuthException e) {
    AuthStatus status;
    switch (e.code) {
      case "network-request-failed":
        status = AuthStatus.NetworkRequestFailed;
        break;
      case "invalid-email":
        status = AuthStatus.invalidEmail;
        break;
      case "invalid-credential":
        status = AuthStatus.invalidCredential;
        break;
      case "wrong-password":
        status = AuthStatus.wrongPassword;
        break;
      case "user-not-found":
        status = AuthStatus.userNotFound;
        break;
      case "weak-password":
        status = AuthStatus.weakPassword;
        break;
      case "email-already-in-use":
        status = AuthStatus.emailAlreadyExists;
        break;
      default:
        status = AuthStatus.unknown;
    }
    return status;
  }

  static String generateErrorMessage(error) {
    String errorMessage;
    switch (error) {
      case AuthStatus.NetworkRequestFailed:
        errorMessage = "Une erreur lié au réseau s'est produite, veuillez vérifier votre connexion internet !";
        break;
      case AuthStatus.invalidEmail:
        errorMessage = "Votre adresse email est invalide !";
        break;
      case AuthStatus.invalidCredential:
        errorMessage = "Vos identifiants sont invalides !";
        break;
      case AuthStatus.weakPassword:
        errorMessage = "Votre de mot de passe doit contenir au moins 6 caractères";
        break;
      case AuthStatus.wrongPassword:
        errorMessage = "Votre adresse email ou votre mot de passe est invalide !";
        break;
      case AuthStatus.emailAlreadyExists:
        errorMessage =
        "L'adresse email que vous tentez d'utiliser est déjà utilisée pour un autre compte !";
        break;
      case AuthStatus.userNotFound:
        errorMessage =
        "Aucun utilisateur n'est associé à cette adresse mail !";
        break;
      default:
        errorMessage = "Une erreur s'est produite, s'il vous plaît veuillez, réessayer plus tard !";
    }
    return errorMessage;
  }
}