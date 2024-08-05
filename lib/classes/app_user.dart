class Appuser{

   String? name;
   String? firstName;
   String? weight;
   String? biography;
   String? birthDate;
   bool? firstConnection;
   String? imageURL;

   Appuser({
     this.name,
     this.firstName,
     this.weight,
     this.biography,
     this.birthDate,
     this.firstConnection,
     this.imageURL
  });

  factory Appuser.fromJson(Map<String, dynamic> json) {
    return Appuser(
      name: json['name'],
      firstName: json['firstName'],
      weight: json['weight'],
      biography: json['objective'],
      birthDate: json['birth_date'],
      firstConnection: json['firstConnection'],
      imageURL: json['imageURL']
    );
  }

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'firstName': firstName,
      'weight': weight,
      'objective': biography,
      'birth_date': birthDate,
      'firstConnection': firstConnection,
      'imageURL': imageURL
    };
  }
  @override
  String toString() {
    return 'Appuser(imageURL: $imageURL, name: $name, firstName: $firstName, weight: $weight, biography, $biography, birth_date : $birthDate)'; // Ajoute d'autres champs si nécessaire
  }
}