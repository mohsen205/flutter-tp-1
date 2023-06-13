class Contact {
  int id;
  String nom;
  String tel;

  Contact({required this.id, required this.nom, required this.tel});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'],
      nom: json['nom'],
      tel: json['tel'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'tel': tel,
    };
  }

  Contact copyWith({int? id, String? nom, String? tel}) {
    return Contact(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      tel: tel ?? this.tel,
    );
  }
}
