import 'dart:collection';

import 'package:library_exercise/items/library_item.dart';

class Book extends LibraryItem {
  Book({
    required super.title,
    required super.author,
    required super.genre,
    required super.publisher,
    super.isAvailable,
    super.newId,
  }) : super(
          baseFee: 0.3,
          interestRate: 0.2,
        );

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      title: json["title"] ?? "N/A",
      author: json["author"] ?? "N/A",
      publisher: json["title"] ?? "N/A",
      genre: json["genre"] ?? "N/A",
      newId: json["isbn"],
      isAvailable: json["isAvailable"] ?? true,
    );
  }

  @override
  UnmodifiableMapView<String, dynamic> get details => UnmodifiableMapView({
        "Title": title,
        "Author": author,
        "Genre": genre.name,
        "isbn": publicationID,
      });
}
