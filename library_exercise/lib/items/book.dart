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
  Map<String, dynamic> getDetails() {
    return {
      "Title": title,
      "Author": author,
      "Genre": genre.name,
      "isbn": publicationID,
    };
  }

  @override
  void borrow() {
    if (!isAvailable) {
      print("this book is not available");
      return;
    }
    isAvailable = false;
    borrowDate = DateTime.now();
    toReturnDate = borrowDate!.copyWith(day: borrowDate!.day + 12);
    print(
        "you succesfully borrowed the Book: $title with ISBN: $publicationID");
  }

  @override
  void returnItem() {
    if (isAvailable) {
      print(
          "The Book: $title with the ISBN: $publicationID hasn't been borrowed yet");
      return;
    }
    isAvailable = true;
    borrowDate = null;
    toReturnDate = null;
    print(
        "Thanks for returning the Book: $title with the isbn: $publicationID");
  }
}
