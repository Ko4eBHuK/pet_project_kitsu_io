class User {
  int _id = 0;
  String _name = '';
  String? _bDay;
  String? _gender;
  String? _avatarImageLink;
  String? _coverImageLink;
  String? _waifuName;
  String? _libraryEntriesLink;

  User();

  User.fromJson(Map<String, dynamic> json) {
    this._id = int.parse(json['data'][0]['id']);
    this._name = json['data'][0]['attributes']['name'];
    this._bDay = json['data'][0]['attributes']['birthday'];
    this._gender = json['data'][0]['attributes']['gender'];

    this._avatarImageLink =
        json['data'][0]['attributes']['avatar'] != null ? json['data'][0]['attributes']['avatar']['original'] : null;

    this._coverImageLink =
        json['data'][0]['attributes']['coverImage'] != null ? json['data'][0]['attributes']['coverImage']['original'] : null;

    this._libraryEntriesLink = json['data'][0]['relationships']['libraryEntries']['links']['related'];
  }

  String? get libraryEntriesLink => _libraryEntriesLink;

  String? get waifuName => _waifuName;

  String? get coverImageLink => _coverImageLink;

  String? get avatarImageLink => _avatarImageLink;

  String? get gender => _gender;

  String? get bDay => _bDay;

  String get name => _name;

  int get id => _id;

  set waifuName(String? value) {
    _waifuName = value;
  }

  set id(int value) {
    _id = value;
  }
}
