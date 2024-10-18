import 'package:library_exercise/items/library_item.dart';

class Magazine extends LibraryItem {
  Magazine({
    required super.title,
    required super.author,
    required super.publisher,
    required super.genre,
    super.isAvailable,
    super.newId,
  }) : super(
          baseFee: 0.2,
          interestRate: 0.2,
        );

  @override
  Map<String, dynamic> getDetails() {
    return {
      "Title": title,
      "Publisher": publisher,
      "Type": genre,
    };
  }

  @override
  void borrow() {
    if (!isAvailable) {
      print("This magazine is not available");
      return;
    }
    isAvailable = false;
    print(
        "You successfully borrowed the magazine: $title with ISSN: $publicationID");
  }

  @override
  void returnItem() {
    if (isAvailable) {
      print(
          "The magazine: $title with ISSN: $publicationID, hasn't been borrowed yet");
      return;
    }
    isAvailable = true;
    print("Thanks for returning the magazine: $title");
  }
}
