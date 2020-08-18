class Genre {
  final String name;
  final int count;

  Genre({this.name, this.count});

  factory Genre.forGenre(Map<String, dynamic> genre) {
    return Genre(
      name: genre['name'].toString(),
      count: int.tryParse(genre['count']) ?? 0,
    );
  }
}
