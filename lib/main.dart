import 'dart:io';

import 'book.dart';

void main() {
  List<Book> book1 = [
    Book(name: 'Clean Code', author: 'Robert C. Martin'),
    Book(
      name: 'The Pragmatic Programmer',
      author: 'Andrew Hunt & David Thomas',
    ),
    Book(name: 'Design Patterns', author: 'Erich Gamma'),
    Book(name: 'Refactoring', author: 'Martin Fowler'),
    Book(name: 'You Don’t Know JS', author: 'Kyle Simpson'),
    Book(name: 'Clean Code', author: 'Robert C. Martin'),
    Book(
      name: 'The Pragmatic Programmer',
      author: 'Andrew Hunt & David Thomas',
    ),
    Book(name: 'Design Patterns', author: 'Erich Gamma'),
    Book(name: 'Refactoring', author: 'Martin Fowler'),
    Book(name: 'You Don’t Know JS', author: 'Kyle Simpson'),
  ];
  for (int i = 0; i < book1.length; i++) {
    print('$i -${book1[i].name}- ${book1[i].author}');
  }

  while (true) {
    stdout.write('Choose an operation\nAdd:\nRemove:\nEdit:\nSearch:\n Exit: ');
    String operation = stdin.readLineSync()!;
    switch (operation) {
      case 'Add':
        addItem(book1);
        break;
      case 'Remove':
        removeItem(book1);
        break;
      case 'Edit':
        editItem(book1);
        break;
      case 'Search':
        searchItem(book1);
        break;
      case 'Exit':
        return;
      default:
        print('invalid');
    }
  }
}

void addItem(List<Book> book) {
  stdout.write('book name: ');
  String name = stdin.readLineSync()!;
  stdout.write('Author\'s name: ');
  String auther = stdin.readLineSync()!;

  book.add(Book(name: name, author: auther));
  print(book);
}

void removeItem(List<Book> book) {
  stdout.write('index: ');
  int i = int.parse(stdin.readLineSync()!);
  book.removeAt(i);
  print(book);
}

void editItem(List<Book> book) {
  stdout.write('index: ');
  int i = int.parse(stdin.readLineSync()!);
  print(book[i]);
  stdout.write('book name: ');
  String x = stdin.readLineSync()!;
  stdout.write('Author\'s name: ');
  String y = stdin.readLineSync()!;
  book[i].name = x;
  book[i].author = y;
  print(book);
}

void searchItem(List<Book> book) {
  stdout.write('book name or Author\'s name:');
  String name = stdin.readLineSync()!;
  List<Book> result = book.where((book) {
    return book.name.toLowerCase().contains(name.toLowerCase()) ||
        book.author.toLowerCase().contains(name.toLowerCase());
  }).toList();
  print(result);
}
