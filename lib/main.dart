import 'dart:convert';
import 'dart:io';

import 'author.dart';
import 'book.dart';

void main() {
  int id1 = 11;
  int id2 = 7;
  List<Author> author1 = [
    Author(id: 1, firstName: 'Robert ', lastName: 'C. Martin'),
    Author(id: 2, firstName: 'Andrew', lastName: 'Hunt'),
    Author(id: 3, firstName: 'David', lastName: 'Thomas'),
    Author(id: 4, firstName: 'Erich', lastName: 'Gamma'),
    Author(id: 5, firstName: 'Martin', lastName: 'Fowler'),
    Author(id: 6, firstName: 'Kyle', lastName: 'Simpson'),
  ];
  List<Book> book1 = [
    Book(id: 1, name: 'Clean Code', authorId: 1),
    Book(id: 2, name: 'The Pragmatic Programmer', authorId: 2),
    Book(id: 3, name: 'Design Patterns', authorId: 4),
    Book(id: 4, name: 'Refactoring', authorId: 5),
    Book(id: 5, name: 'You Don’t Know JS', authorId: 6),
    Book(id: 6, name: 'Clean Code', authorId: 1),
    Book(id: 7, name: 'The Pragmatic Programmer', authorId: 2),
    Book(id: 8, name: 'Design Patterns', authorId: 4),
    Book(id: 9, name: 'Refactoring', authorId: 5),
    Book(id: 10, name: 'You Don’t Know JS', authorId: 6),
  ];

  Author? getAuthorById(int id) {
    return author1.firstWhere(
      (a) => a.id == id,
      orElse: () => Author(id: 1, firstName: 'Unknown', lastName: 'Unknown'),
    );
  }

  String jsonString = jsonEncode(
    book1.map((b) => b.toJson(author: getAuthorById(b.authorId!))).toList(),
  );
  // print(jsonString);
  File file = File('books.json');
  file.writeAsStringSync(jsonString);

  print('JSON file created!');

  // for (Book book in book1) {
  //   int authorId1 = book.authorId!;
  //   Author a1 = author1.firstWhere((a) {
  //     return authorId1 == a.id;
  //   });
  //   print('${book.id}-${book.name} -${a1.firstName}${a1.lastName}');
  // }
  printBookAndAuthor(book1, author1);
  while (true) {
    stdout.write('Choose an operation\nAdd:\nRemove:\nEdit:\nSearch:\n Exit: ');
    String operation = stdin.readLineSync()!;
    switch (operation) {
      case 'Add':
        id1 = addItem(book1, id1, id2, author1);
        break;
      case 'Remove':
        removeItem(book1);
        break;
      case 'Edit':
        editItem(book1, author1);
        break;
      case 'Search':
        searchItem(book1, author1);
        break;
      case 'Exit':
        return;
      default:
        print('invalid');
    }
  }
}

int addItem(List<Book> book, int id, int authorId, List<Author> author) {
  stdout.write('book name: ');
  String name = stdin.readLineSync()!;
  stdout.write('Author\'s firstName: ');
  String firstName = stdin.readLineSync()!;
  stdout.write('Author\'s lastName: ');
  String lastName = stdin.readLineSync()!;

  author.add(Author(id: authorId, firstName: firstName, lastName: lastName));
  book.add(Book(name: name, id: id, authorId: authorId));
  authorId++;
  printBookAndAuthor(book, author);
  // for (Book b in book) {
  //   Author a1 = author.firstWhere((a) {
  //     return b.authorId == a.id;
  //   });
  //   print('${b.id}-${b.name}-${a1.firstName}-${a1.lastName} ');
  // }

  return id + 1;
}

void removeItem(List<Book> book) {
  stdout.write('id: ');
  int id = int.parse(stdin.readLineSync()!);
  book.removeWhere((book) {
    return book.id == id;
  });
  print(book);
}

void editItem(List<Book> book, List<Author> author) {
  stdout.write('id: ');
  int id = int.parse(stdin.readLineSync()!);
  Book result = book.firstWhere((book) {
    return book.id == id;
  });
  Author resultAuthor = author.firstWhere((a) {
    return a.id == result.authorId;
  });

  stdout.write('book name: ');
  String name = stdin.readLineSync()!;
  stdout.write('Author\'s firstName: ');
  String firstName = stdin.readLineSync()!;
  stdout.write('Author\'s lastName: ');
  String lastName = stdin.readLineSync()!;
  result.name = name;
  resultAuthor.firstName = firstName;
  resultAuthor.lastName = lastName;
  // for (Book book in book) {
  //   int authorId1 = book.authorId!;
  //   Author a1 = author.firstWhere((a) {
  //     return authorId1 == a.id;
  //   });
  //   print('${book.id}-${book.name} -${a1.firstName}${a1.lastName}');
  // }
  printBookAndAuthor(book, author);
}

void searchItem(List<Book> book, List<Author> author) {
  stdout.write('book name or Author\'s name:');
  String name = stdin.readLineSync()!;
  List<Book> result = book.where((book) {
    return book.name.toLowerCase().contains(name.toLowerCase());
  }).toList();
  if (result.isNotEmpty) {
    for (Book b in result) {
      int authorId1 = b.authorId!;
      Author a1 = author.firstWhere((a) {
        return authorId1 == a.id;
      });
      print('${b.id},${b.name}-${a1.firstName}${a1.lastName}');
    }
  } else {
    List<Author> resultAuthor = author.where((a) {
      return a.firstName.toLowerCase().contains(name.toLowerCase()) ||
          a.lastName!.toLowerCase().contains(name.toLowerCase());
    }).toList();
    for (Author a in resultAuthor) {
      int authorId = a.id;
      List<Book> b1 = book.where((b) {
        return authorId == b.authorId;
      }).toList();
      for (Book book in b1)
        print('${book.id}-${book.name}${a.firstName},${a.lastName}');
    }
  }
}

void printBookAndAuthor(List<Book> book, List<Author> author) {
  for (Book b in book) {
    Author a1 = author.firstWhere((a) {
      return b.authorId == a.id;
    });
    print('${b.id}-${b.name}-${a1.firstName}-${a1.lastName} ');
  }
}
