import 'package:collection/collection.dart';
import 'package:uuid/uuid.dart';

enum Genre {
  romance(string: "Romance"),
  fantasy(string: "Fantasy"),
  history(string: "History"),
  science(string: "Science"),
  fiction(string: "Fiction"),
  dystopian(string: "Dystopian"),
  southernGothic(string: "Southern Ghothic"),
  fashion(string: "Fashion"),
  sports(string: "Sports"),
  entertainment(string: "Entertainment"),
  ;

  const Genre({required this.string});
  final String string;
}

abstract class LibraryItem {
  final String title;
  final String author;
  final String publisher;
  final Genre genre;
  final String publicationID;
  bool isAvailable;
  DateTime? toReturnDate;
  DateTime? borrowDate;
  final double baseFee;
  final double interestRate;
  abstract final UnmodifiableMapView<String, dynamic> details;

  LibraryItem(
      {required this.title,
      required this.author,
      required this.publisher,
      required this.genre,
      required this.baseFee,
      required this.interestRate,
      this.isAvailable = true,
      String? newId})
      : publicationID = newId ?? Uuid().v1();

  bool isOverdue() {
    if (toReturnDate == null) return false;

    final today =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    return toReturnDate!.isBefore(today);
  }

  double overdueFee() {
    if (borrowDate == null || toReturnDate == null) return 0.0;

    var overdueDay = borrowDate!.compareTo(toReturnDate!);
    return overdueDay * baseFee * interestRate;
  }

  void borrow() {
    if (!isAvailable) {
      print("The item is not available");
      return;
    }
    isAvailable = false;
    borrowDate = DateTime.now();
    toReturnDate = borrowDate!.copyWith(day: borrowDate!.day + 12);
    print("you succesfully borrowed: ${toString()}.");
  }

  void returnItem() {
    if (isAvailable) {
      print("${toString()}, hasn't been borrowed yet");
      return;
    }
    isAvailable = true;
    borrowDate = null;
    toReturnDate = null;
    print("Thanks for returning ${toString()}.");
  }

  @override
  String toString() {
    return "$title with the ID: $publicationID";
  }
}
