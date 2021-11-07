class AnimeItem {
  int _id = -1;
  String? _title;
  String? _rating;
  String? _startDate;
  String? _description;
  String? _ageRating;
  String? _posterImageLink;
  String? _coverImageLing;
  int? _episodeCount;
  int? _episodeLength;
  String? _showType;

  AnimeItem();

  AnimeItem.fromJson(Map<String, dynamic> json) {
    _id = int.parse(json['id']);
    _title = json['attributes']['canonicalTitle'];
    _rating = json['attributes']['averageRating'];
    _startDate = json['attributes']['startDate'];
    _description = json['attributes']['description'];
    _ageRating = json['attributes']['ageRating'];
    _posterImageLink = json['attributes']['posterImage']?['original'];
    _coverImageLing = json['attributes']['coverImage']?['original'];
    _episodeCount = json['attributes']['episodeCount'];
    _episodeLength = json['attributes']['episodeLength'];
    _showType = json['attributes']['showType'];
  }

  String? get showType => _showType;

  int? get episodeLength => _episodeLength;

  int? get episodeCount => _episodeCount;

  String? get coverImageLing => _coverImageLing;

  String? get posterImageLink => _posterImageLink;

  String? get ageRating => _ageRating;

  String? get description => _description;

  String? get startDate => _startDate;

  int get id => _id;

  String? get rating => _rating;

  String? get title => _title;
}
