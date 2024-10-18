import 'dart:math';

import 'package:library_exercise/institutes/library.dart';
import 'package:library_exercise/items/library_item.dart';

class User {
  User({
    required String name,
    int borrowLimit = defaultBorrowLimit,
  })  : _name = name,
        _borrowLimit = borrowLimit,
        _userID = "${Random().nextInt(10000)}.${Random().nextInt(100)}";

  final String _name;
  final String _userID;
  final int _borrowLimit;
  final _borrowedItems = <LibraryItem>[];
  final _overdueItems = <LibraryItem>[];
  final _borrowedHistory = <LibraryItem>[];
  final _returnedItemsWithFee = <String, double>{};
  var _feesToPay = 0.0;

  static const int defaultBorrowLimit = 2;

  String get name => _name;
  String get userID => _userID;
  int get borrowLimit => _borrowLimit;
  List<LibraryItem> get borrowedItems => _borrowedItems;
  List<LibraryItem> get borrowedHistory => _borrowedHistory;
  Map<String, double> get returnedItemsWithFee => _returnedItemsWithFee;

  List<LibraryItem> get overdueItems {
    _overdueItems.clear();
    checkForOverdueItems();

    return _overdueItems;
  }

  double get feesToPay {
    _feesToPay = 0;

    for (final item in overdueItems) {
      _feesToPay += item.overdueFee();
    }

    for (final fee in _returnedItemsWithFee.values) {
      _feesToPay += fee;
    }

    return _feesToPay;
  }

  void borrowItems(List<LibraryItem> items, Library library) {
    if (!canBorrowMoreItems()) return;

    for (final item in items) {
      if (reachedLimit()) return;

      library.logistic.inventory
          .firstWhere((i) => i.publicationID == item.publicationID)
          .borrow();

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

  void checkForOverdueItems() {
    for (final item in _borrowedItems) {
      if (item.isOverdue()) {
        _overdueItems.add(item);
      }
    }
  }

  bool canBorrowMoreItems() {
    if (overdueItems.isNotEmpty || feesToPay > 0) {
      print(
          "There are overdue Items in you posetion. please return them before borrowing any new Items");
      print("Items in Question are: ${getOverdueItemDetails()}");
      print(_feesToPay);
      return false;
    }

    return !reachedLimit();
  }

  List<Map<String, dynamic>> getOverdueItemDetails() {
    final overdueDetails = <Map<String, dynamic>>[];
    for (final item in overdueItems) {
      final itemDetails = item.getDetails();
      itemDetails["overdueFee"] = item.overdueFee();
      overdueDetails.add(itemDetails);
    }
    return overdueDetails;
  }

  bool reachedLimit() {
    if (_borrowedItems.length >= borrowLimit) {
      print("You already reached your limit for borrowed books.");
      print("You have to return the books before borrowing a new one.");
      return true;
    }
    return false;
  }
}
