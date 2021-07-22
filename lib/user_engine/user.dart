class User {
  int _id = 0;
  String _name = '';
  String? _bDay = '';
  String? _gender = '';
  String? _waifuOrHusbando = '';
  String _avatarImageLink = '';
  String _coverImageLink = '';
  String? _waifuLink = '';
  String? _libraryEntriesLink = '';

  User();

  User.fromNet(this._id, this._name, this._bDay, this._gender, this._waifuOrHusbando, this._avatarImageLink, this._coverImageLink,
      this._waifuLink, this._libraryEntriesLink);

  String? get libraryEntriesLink => _libraryEntriesLink;

  String? get waifuLink => _waifuLink;

  String get coverImageLink => _coverImageLink;

  String get avatarImageLink => _avatarImageLink;

  String? get waifuOrHusbando => _waifuOrHusbando;

  String? get gender => _gender;

  String? get bDay => _bDay;

  String get name => _name;

  int get id => _id;

  set waifuLink(String? value) {
    _waifuLink = value;
  }

  set id(int value) {
    _id = value;
  }
}
