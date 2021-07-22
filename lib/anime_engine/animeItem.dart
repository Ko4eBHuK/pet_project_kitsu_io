class AnimeItem {
  final int? _id;
  final String? _startDate;
  final String? _description;
  final String? _subtype;
  final String? _ageRating;
  final String? _posterImageLink;
  final String? _coverImageLing;
  final int? _episodeCount;
  final int? _episodeLength;
  final String? _showType;
  final bool? _nsfw;

  const AnimeItem(this._id, this._startDate, this._description, this._subtype, this._ageRating, this._posterImageLink,
      this._coverImageLing, this._episodeCount, this._episodeLength, this._showType, this._nsfw);

  bool? get nsfw => _nsfw;

  String? get showType => _showType;

  int? get episodeLength => _episodeLength;

  int? get episodeCount => _episodeCount;

  String? get coverImageLing => _coverImageLing;

  String? get posterImageLink => _posterImageLink;

  String? get ageRating => _ageRating;

  String? get subtype => _subtype;

  String? get description => _description;

  String? get startDate => _startDate;

  int? get id => _id;
}
