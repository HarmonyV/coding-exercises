import 'dart:collection';

import 'package:library_exercise/library.dart';
import 'package:library_exercise/items/library_item.dart';
import 'package:uuid/uuid.dart';

class User {
  User({
    required this.name,
    int? myBorrowLimit,
  })  : borrowLimit = myBorrowLimit ?? defaultBorrowLimit,
        userID = Uuid().v1();

  final String name;
  final String userID;
  final int borrowLimit;
  final _borrowedItems = <LibraryItem>[];
  final _borrowedHistory = <LibraryItem>[];
  final _returnedItemsWithFee = <String, double>{};

  static const int defaultBorrowLimit = 2;

  UnmodifiableListView<LibraryItem> get borrowedItems =>
      UnmodifiableListView(_borrowedItems);

  UnmodifiableListView<LibraryItem> get borrowedHistory =>
      UnmodifiableListView(_borrowedHistory);

  LibraryItem get lastBorrowed => _borrowedHistory.last;

  UnmodifiableMapView<String, double> get returnedItemsWithFee =>
      UnmodifiableMapView(_returnedItemsWithFee);

  UnmodifiableListView<LibraryItem> get overdueItems {
    return UnmodifiableListView(
        _borrowedItems.where((i) => i.isOverdue() == true).toList());
  }

  double get amountOwed {
    var sum = 0.0;

    for (final item in overdueItems) {
      sum += item.overdueFee();
    }

    for (final fee in _returnedItemsWithFee.values) {
      sum += fee;
    }

    return sum;
  }

  void borrowItems(List<LibraryItem> items, Library library) {
    if (!canBorrowMoreItems()) {
      print(
          "You can't borrow any items. Please check if you have any overdue items, unpayed fees or reached your borrow-limit");
      return;
    }

    for (final item in items) {
      if (hasReachedLimit()) {
        print("You reached your borrow-limit. No more items can be borrowed");
        return;
      }

      item.borrow();
      _borrowedItems.add(item);
      _borrowedHistory.add(item);
    }
  }

  void returnItems(List<LibraryItem> items) {
    for (final item in items) {
      if (overdueItems.contains(item)) {
        final fee = item.overdueFee();
        _returnedItemsWithFee[item.title] = item.overdueFee();

        print(
            "the book: ${item.title} is overdue and you need to pay a fee of $fee \$");
      }

      item.returnItem();
      _borrowedItems.remove(item);
    }
  }

  bool canBorrowMoreItems() {
    if (overdueItems.isNotEmpty || amountOwed > 0) return false;

    return !hasReachedLimit();
  }

  UnmodifiableListView<Map<String, dynamic>> overdueItemDetails() {
    final overdueDetails = <Map<String, dynamic>>[];
    for (final item in overdueItems) {
      final refference = <String, dynamic>{
        "Title": item.title,
        "ID": item.publicationID,
        "Fee": item.overdueFee()
      };
      overdueDetails.add(refference);
    }
    return UnmodifiableListView(overdueDetails);
  }

  bool hasReachedLimit() {
    if (_borrowedItems.length >= borrowLimit) return true;

    return false;
  }

  @override
  bool operator ==(Object other) => other is User && other.userID == userID;

  @override
  int get hashCode => userID.hashCode;
}
