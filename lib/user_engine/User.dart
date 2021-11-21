class User {
  int id;
  final String? name;
  final String? bDay;
  final String? gender;
  final String? avatarImageLink;
  final String? coverImageLink;
  final String? libraryEntriesLink;
  String? waifuName;

  User(
      {required this.id,
      this.name,
      this.bDay,
      this.gender,
      this.avatarImageLink,
      this.coverImageLink,
      this.libraryEntriesLink,
      this.waifuName});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: int.parse(json['data'][0]['id']),
      name: json['data'][0]['attributes']['name'],
      bDay: json['data'][0]['attributes']['birthday'],
      gender: json['data'][0]['attributes']['gender'],
      avatarImageLink: json['data'][0]['attributes']['avatar']?['original'],
      coverImageLink: json['data'][0]['attributes']['coverImage']?['original'],
      libraryEntriesLink: json['data'][0]['relationships']['libraryEntries']['links']['related'],
    );
  }
}
