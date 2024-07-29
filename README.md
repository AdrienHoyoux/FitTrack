# FitTrack

![FireBase](https://img.shields.io/badge/firebase-ffca28?style=for-the-badge&logo=firebase&logoColor=black)
![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![IOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)
![OSM](https://img.shields.io/badge/OpenStreetMap-7EBC6F?style=for-the-badge&logo=OpenStreetMap&logoColor=white)


## 🏃 Qu'est ce que FitTrack ? 

>FitTrack est une application mobile conçue pour accompagner les utilisateurs dans l'amélioration de leur condition physique. Grâce à cette application, les utilisateurs peuvent suivre leurs activités physiques telles que la course ou la marche en utilisant une carte interactive qui trace leur parcours.


>FitTrack fournit des informations détaillées telles que la distance parcourue, la vitesse moyenne en km/h, le temps écoulé, et les calories dépensées.

>FitTrack combine une interface utilisateur intuitive regroupant diverses fonctionnalités telles que la modification du profil des utilisateurs, l'affichage des différentes courses effectuées par l'utilisateur mais également le lancement d'une course.

## 📁 Présentation des principaux dossiers

### **`classes`**
Ce répertoire contient les classes représentant les données de l'application. Vous y trouverez les modèles de données utilisés dans toute l'application.

### **`screens`**
Ce répertoire regroupe les différentes pages de l'application. Chaque page de l'interface utilisateur est définie ici.

### **`widgets`**
Ce répertoire contient les widgets personnalisés qui sont utilisés pour la page permettant le lancement d'une course. Ces widgets correspondent à la carte et au statistique affichée lors de sa course.

### **`services`**
Ce répertoire regroupe les interactions avec les services externes, tels que Firebase. Vous y trouverez une classe `DatabaseService` qui gère les interactions avec la base de données.

### ***`notifiers`***
Ce répertoire contient une classe qui étend la classe `ChangeNotifier` de Flutter. Il est utilisé pour gérer l'état de l'application et notifier les widgets lorsqu'un changement d'état se produit.

### **`routes`**
Ce répertoire contient les différentes routes de l'application. Ces grâce à ces routes que l'on peut naviguer entre les différentes pages de l'application.

## 📱 Aperçu de la maquette
![Page de connexion](imageReadme/ConnexionScreen.png)
**Page de connexion** : C'est la première page que les utilisateurs voient lorsqu'ils ouvrent l'application. Elle permet aux utilisateurs de se connecter à leur compte en saisissant leur adresse e-mail et leur mot de passe. Elle propose également un lien pour réinitialiser le mot de passe en cas d'oubli et un lien pour se créér un compte en cas de besoin.

![Page de création de compte](imageReadme/userInfoScreen.png)
**Page de première connexion** : Lors de la première connexion cette page est affichée à l'utilisateur pour complété son profil. Via cette page l'utilisateur sere obligé de remplir certains champs comme son nom, son prénom, sa date de naissance et son poids. Il pourra également ajouter une biographie et une photo s'il le souhaite.

![Page de profil utilisateur](imageReadme/UserProfileScreen.png)
**Page de profil utilisateur** : Cette page permet à l'utilisateur de voir et de modifier son profil. Il pourra voir son nom, son age, sa biographie et son poids. Il pourra également modifier son poids.

![Page de création de compte](imageReadme/CreateAccountScreen.png)
**Page de création de compte** : Sur cette page, les utilisateurs peuvent créer un nouveau compte en saisissant leurs informations personnelles. La conception se concentre sur la simplicité et la facilité d'utilisation.

![Page de réinitialisation du mot de passe](imageReadme/ResetPasswordScreen.png)
**Page de réinitialisation du mot de passe** : Cette page permet aux utilisateurs de réinitialiser leur mot de passe en cas d'oubli. Elle guide les utilisateurs à travers un processus sécurisé de récupération de compte.

![Écran d'accueil](imageReadme/homeScreen.png)
**Page d'accueil**: Cette page est celle que l'utilisateur voit lorsqu'il est connecté à son compte. Elle affiche la partie introduction de ce readme afin de présenter l'application à l'utilisateur.

![Page des paramètres](imageReadme/SettingsScreen.png)
**Page des paramètres** : Cette page permet à l'utilisateur de se déconnecter de son compte ou de supprimer son compte.

![Page de lancement d'une course](imageReadme/mapScreen.jpg)
**Page de lancement d'une course** : comme son nom l'indique cette page va permettre à l'utilisateur de lancer une course. Cette dernière est composée de 2 widgets, la carte (basé sur OSM) qui va afficher le parcours de l'utilisateur et la statistique de la course effectuée qui seront mis à jour en temps réel. Quand l'utilisateur le décidera il pourra enregistrer sa course ou la mettre en pause ou même l'annuler.

![Page d'eneregistrement d'une course](imageReadme/SaveraceScreen.png)
**Page d'enregistrement de la course** : Cette page permet à l'utilisateur de sauvegarder sa course. Il pourra également voir les statistiques de sa course, lui ajouter un nom et les enregistrer dans la base de données.

![Page des courses effectuées](imageReadme/HistoryScreen.png)
**Page des courses effectuées** : Cette page permet à l'utilisateur de voir les différentes courses qu'il a effectuées. Il pourra voir les statistiques de chaque course lors du clic sur l'une d'elle.

![Page des statistiques d'une course](imageReadme/DetailRaceScreen.png)
**Page des statistique d'une course** : Cette page permet à l'utilisateur de voir les statistiques d'une course en particulier. Il pourra voir la distance parcourue, le temps écoulé, la vitesse moyenne et les calories dépensées.


## 🎯 Objectifs
> ### 1. Suivi interactif du parcours :
  Permettre aux utilisateurs de suivre leur trajet en temps réel via une carte interactive, affichant leur position et leur itinéraire.
  
> ### 2. Fournir des détails sur la course :
  Offrir des statistiques détaillées telles que la distance parcourue, la vitesse moyenne et le temps écoulé.
  
> ### 3. Comparaison des performances :
 Permettre aux utilisateurs de comparer leurs performances actuelles avec leurs précédentes courses, facilitant ainsi le suivi de leur progression.

> ### 4. Personnalisation des objectifs :
 Permettre aux utilisateurs de définir des objectifs personnels, tels que des distances à parcourir ou des temps à battre, et de suivre leur progression vers ces objectifs.

> ### 5. Interface utilisateur intuitive :
  Concevoir une interface conviviale et intuitive, facilitant la navigation et l'utilisation des fonctionnalités de suivi et d'analyse.

> ### 6. Compatibilité multi-plateforme :
 Assurer une compatibilité optimale avec les appareils iOS et Android, permettant aux utilisateurs de profiter de l'application sur différents appareils.


## 📝 Fonctionnalités

## 🔍 Etude de l'existant

## 🛠️ Outils

## ⚙️ Compilation du projet