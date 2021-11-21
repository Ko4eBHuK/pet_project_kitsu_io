class AnimeItem {
  final int id;
  final String? title;
  final String? description;
  final String? rating;
  final String? ageRating;
  final String? startDate;
  final int? episodeCount;
  final int? episodeLength;
  final String? showType;
  final String? posterImageLink;
  final String? coverImageLing;
  final String? slug;

  AnimeItem(
      {required this.id,
      this.title,
      this.description,
      this.rating,
      this.ageRating,
      this.startDate,
      this.episodeCount,
      this.episodeLength,
      this.showType,
      this.posterImageLink,
      this.coverImageLing,
      this.slug});

  factory AnimeItem.fromJson(Map<String, dynamic> json) {
    return AnimeItem(
      id: int.parse(json['id']),
      title: json['attributes']['canonicalTitle'],
      description: json['attributes']['description'],
      rating: json['attributes']['averageRating'],
      ageRating: json['attributes']['ageRating'],
      startDate: json['attributes']['startDate'],
      episodeCount: json['attributes']['episodeCount'],
      episodeLength: json['attributes']['episodeLength'],
      showType: json['attributes']['showType'],
      posterImageLink: json['attributes']['posterImage']?['original'],
      coverImageLing: json['attributes']['coverImage']?['original'],
      slug: json['attributes']['slug'],
    );
  }
}
