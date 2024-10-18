import 'package:library_exercise/institutes/logistic.dart';
import 'package:library_exercise/users/user.dart';
import 'package:library_exercise/utils.dart';

enum Reports {
  borrowedBooksByUsers,
  overdueItems,
  lastBorrowedBookByUser,
}

class Accounting {
  final Logistic logistic;
  final List<User> members;

  Accounting({required this.logistic, required this.members});

  void generateReport(Reports reportType, [User? user]) {
    switch (reportType) {
      case Reports.borrowedBooksByUsers:
        for (final member in members) {
          print(
              "${member.name} currently has these items: ${getTitles(member.borrowedItems)}");
        }

      case Reports.overdueItems:
        final overdueItems = logistic.inventory
            .where((i) => !i.isAvailable && i.isOverdue())
            .toList();
        print("Here are all the overdue items: $overdueItems");

      case Reports.lastBorrowedBookByUser:
        if (user == null) {
          print("Please provide a user");
          return;
        }
        if (user.borrowedHistory.isNotEmpty) {
          print(
              "${user.name} has last borrowed ${user.borrowedHistory.last.title}");
        } else {
          print("${user.name} has no borrowing history.");
        }

      default:
        print("Invalid report type");
    }
  }
}
