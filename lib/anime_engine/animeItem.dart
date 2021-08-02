class AnimeItem {
  int? _id;
  String? _startDate;
  String? _description;
  String? _subtype;
  String? _ageRating;
  String? _posterImageLink;
  String? _coverImageLing;
  int? _episodeCount;
  int? _episodeLength;
  String? _showType;
  bool? _nsfw;

  AnimeItem();

  AnimeItem.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['data']['id']);
    _startDate = json['data']['attributes']['startDate'];
    _description = json['data']['attributes']['description'];
    _subtype = json['data']['attributes']['subtype'];
    _ageRating = json['data']['attributes']['ageRating'];
    _posterImageLink = json['data']['attributes']['posterImage']['original'];
    _coverImageLing = json['data']['attributes']['coverImage']['original'];
    _episodeCount = json['data']['attributes']['episodeCount'];
    _episodeLength = json['data']['attributes']['episodeLength'];
    _showType = json['data']['attributes']['showType'];
    _nsfw = json['data']['attributes']['nsfw'];
  }

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
