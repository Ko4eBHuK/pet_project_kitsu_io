class User {
  final int? _id;
  final String? _name;
  final String? _location;
  final String? _bDay;
  final String? _gender;
  final String? _waifuOrHusbando;
  final String? _avatarImageLink;
  final String? _coverImageLink;
  final String? _waifuLink;
  final String? _HusbandoLink;
  final String? _libraryEntriesLink;

  const User(
      this._id,
      this._name,
      this._location,
      this._bDay,
      this._gender,
      this._waifuOrHusbando,
      this._avatarImageLink,
      this._coverImageLink,
      this._waifuLink,
      this._HusbandoLink,
      this._libraryEntriesLink);

  String? get libraryEntriesLink => _libraryEntriesLink;

  String? get HusbandoLink => _HusbandoLink;

  String? get waifuLink => _waifuLink;

  String? get coverImageLink => _coverImageLink;

  String? get avatarImageLink => _avatarImageLink;

  String? get waifuOrHusbando => _waifuOrHusbando;

  String? get gender => _gender;

  String? get bDay => _bDay;

  String? get location => _location;

  String? get name => _name;

  int? get id => _id;
}
