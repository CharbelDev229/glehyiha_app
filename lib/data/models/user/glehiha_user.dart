

class GlehihaUser {
  final int id;
  final String pseudo;
  final String? avatar;
  final String? firstname;
  final String? lastname;
  final List<dynamic> media;
  final String role;
  final String? createdAt;


  const GlehihaUser(
      {required this.id,
      required this.pseudo,
      this.avatar,
      this.firstname,
      this.lastname,
      required this.media,
      required this.role,
      this.createdAt});

  factory GlehihaUser.fromMap(Map<String, dynamic> data) => GlehihaUser(
        id: data['id'] as int,
        pseudo: data['pseudo'] as String,
        avatar: data['avatar'] as String?,
        firstname: data['firstname'] as String?,
        lastname: data['lastname'] as String?,
        media: data['media'] as List<dynamic>,
        role: data['role'] as String,
        createdAt: data['created_at'] as String? ?? '',
      );

  /// Parses a list of [Map<String, dynamic>] into a list of [CosekaUser].
  static List<GlehihaUser> fromMapList(List data) {
    return data.map((map) => GlehihaUser.fromMap(map)).toList();
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'pseudo': pseudo,
        'avatar': avatar,
        'firstname': firstname,
        'lastname': lastname,
        'media': media,
        'role': role,
        'created_at': createdAt
      };

  /// Converts a list of [CosekaUser] into a list of [Map<String, dynamic>].
  static List<Map<String, dynamic>> toMapList(List<GlehihaUser> reactions) {
    return reactions.map((reaction) => reaction.toMap()).toList();
  }

  static List<int>? getUniqueUserIds(List<GlehihaUser> mentionedUsers) {
    // Utiliser un Set pour éviter les doublons
    final Set<int> uniqueIds = {};

    for (var user in mentionedUsers) {
      uniqueIds.add(user
          .id); // Ajoute l'id dans le Set, les doublons sont ignorés automatiquement
    }

    // Si la liste est vide, retourne null, sinon, retourne la liste des ids uniques
    return uniqueIds.isEmpty ? null : uniqueIds.toList();
  }

  GlehihaUser copyWith({
    int? id,
    String? pseudo,
    String? avatar,
    String? firstname,
    String? lastname,
    List<dynamic>? media,
    String? role,
    String? createdAt,
    bool? imSubscribed,
  }) {
    return GlehihaUser(
      id: id ?? this.id,
      pseudo: pseudo ?? this.pseudo,
      avatar: avatar ?? this.avatar,
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      media: media ?? this.media,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
      
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      pseudo,
      avatar,
      firstname,
      lastname,
      createdAt,
    
    ];
  }
}
