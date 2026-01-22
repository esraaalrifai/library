import 'dart:convert';
import 'dart:io';

import 'author.dart';
import 'book.dart';
import 'library.dart';
import 'shelf.dart';

void main() {
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
    Book(id: 11, name: 'Clean Code', authorId: 1),
    Book(id: 12, name: 'The Pragmatic Programmer', authorId: 2),
    Book(id: 13, name: 'Design Patterns', authorId: 4),
    Book(id: 14, name: 'Refactoring', authorId: 5),
    Book(id: 15, name: 'You Don’t Know JS', authorId: 6),
    Book(id: 16, name: 'Clean Code', authorId: 1),
    Book(id: 17, name: 'The Pragmatic Programmer', authorId: 2),
    Book(id: 18, name: 'Design Patterns', authorId: 4),
    Book(id: 19, name: 'Refactoring', authorId: 5),
    Book(id: 20, name: 'You Don’t Know JS', authorId: 6),
  ];

  List<Shelf> shelf = [
    Shelf(id: 1, name: 'FirstShelf', bookId: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]),
    Shelf(
      id: 2,
      name: 'SecondShelf',
      bookId: [11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
    ),
  ];

  List<Library> library = [
    Library(id: 1, name: 'Esraa Library', shelfId: [0, 1]),
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

  // for (Shelf sh in shelf) {
  //   List<int>? bookId = sh.bookId;
  //   List<Book> b1 = book1.where((b) {
  //     return bookId == b.id;
  //   }).toList();
  //   for (Book b in book1) {
  //     int authorId = b.authorId!;
  //     Author a1 = author1.firstWhere((a) {
  //       return authorId == a.id;
  //     });
  //     print('${sh.name},${b.id},${b.name},${a1.firstName},${a1.lastName}');
  //   }
  // }
  printBookWithShelves(book1, author1, shelf);
  // printBookAndAuthor(book1, author1);
  while (true) {
    stdout.write(
      'Choose an operation\nadd:\nremove:\nedit:\nsearch:\neditshelf:\ntransferbook:\n exit: ',
    );
    String operation = stdin.readLineSync()!.toLowerCase();
    switch (operation) {
      case 'add':
        addItem(book1, author1, shelf);
        break;
      case 'remove':
        removeItem(book1, shelf, author1);
        break;
      case 'edit':
        editItem(book1, author1);
        break;
      case 'search':
        searchItem(book1, author1, shelf);
        break;
      case 'transferbook':
        transferBookBetweenShelves(shelf, book1, author1);
        break;
      case 'editshelf':
        editShelf(shelf, book1, author1);
        break;
      case 'exit':
        return;
      default:
        print('invalid');
    }
  }
}

void addItem(List<Book> book, List<Author> author, List<Shelf> shelf) {
  for (Shelf sh in shelf) {
    print('Shelf name:${sh.name}');
  }
  Shelf selectedShelf;
  stdout.write('Enter Shelf name or type (add): ');
  String shelfName = stdin.readLineSync()!;
  if (shelfName.toLowerCase() == 'add') {
    int maxmaShelfId = MaxShelfId(shelf);
    stdout.write('Shelf name: ');
    String name = stdin.readLineSync()!;
    Shelf newshelf = Shelf(id: maxmaShelfId, name: name, bookId: []);
    shelf.add(newshelf);
    selectedShelf = newshelf;
  } else {
    selectedShelf = shelf.firstWhere((sh) {
      return sh.name == shelfName;
    });
  }
  for (Author a in author) {
    print('Author iD : ${a.id},${a.firstName},${a.lastName}');
  }
  stdout.write('Enter author ID or type (add): ');
  String input = stdin.readLineSync()!.toLowerCase();
  int? authorId = int.tryParse(input);
  if (authorId != null) {
    stdout.write('book name: ');
    String name = stdin.readLineSync()!;
    // int lastId = book.last.id + 1;
    int maxBookId = MaxbookId(book);
    book.add(Book(name: name, id: maxBookId, authorId: authorId));
    selectedShelf.bookId!.add(maxBookId);
  } else {
    stdout.write('book name: ');
    String name = stdin.readLineSync()!;
    stdout.write('Author\'s firstName: ');
    String firstName = stdin.readLineSync()!;
    stdout.write('Author\'s lastName: ');
    String lastName = stdin.readLineSync()!;
    // int lastAuthorId = author.last.id + 1;
    int maxAuthorId = MaxauthorId(author);
    // int lastId = book.last.id + 1;
    int maxBookId = MaxbookId(book);
    author.add(
      Author(id: maxAuthorId, firstName: firstName, lastName: lastName),
    );
    book.add(Book(name: name, id: maxBookId, authorId: maxAuthorId));
    selectedShelf.bookId!.add(maxBookId);
  }
  printBookWithShelves(book, author, shelf);
  // printBookAndAuthor(book, author,);
}

void removeItem(List<Book> book, List<Shelf> shelf, List<Author> author) {
  stdout.write('id: ');
  int id = int.parse(stdin.readLineSync()!);
  for (Shelf sh in shelf) {
    sh.bookId!.removeWhere((bookId) {
      return bookId == id;
    });
  }
  book.removeWhere((book) {
    return book.id == id;
  });
  printBookWithShelves(book, author, shelf);
  // print(book);
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

void searchItem(List<Book> book, List<Author> author, List<Shelf> shelf) {
  stdout.write('book name or Author\'s name:');
  String name = stdin.readLineSync()!;
  List<Book> result = book.where((book) {
    return book.name.toLowerCase().contains(name.toLowerCase());
  }).toList();
  List<Author> resultAuthor = author.where((a) {
    return a.firstName.toLowerCase().contains(name.toLowerCase()) ||
        a.lastName!.toLowerCase().contains(name.toLowerCase());
  }).toList();
  List<Shelf> resultShelf = shelf.where((sh) {
    return sh.name.toLowerCase().contains(name.toLowerCase());
  }).toList();
  if (result.isNotEmpty) {
    for (Book b in result) {
      int bookId = b.id;
      int authorId1 = b.authorId!;
      Author a1 = author.firstWhere((a) {
        return authorId1 == a.id;
      });
      Shelf sh1 = shelf.firstWhere((sh) {
        return sh.bookId!.contains(bookId);
      });
      print('${sh1.name}${b.id},${b.name}-${a1.firstName}${a1.lastName}');
    }
  } else if (resultAuthor.isNotEmpty) {
    for (Author a in resultAuthor) {
      int authorId = a.id;
      List<Book> b1 = book.where((b) {
        return authorId == b.authorId;
      }).toList();
      for (Book book in b1) {
        int bookId = book.id;
        Shelf sh1 = shelf.firstWhere((sh) {
          return sh.bookId!.contains(bookId);
        });
        print('${sh1.name}${book.id}-${book.name}${a.firstName},${a.lastName}');
      }
    }
  } else if (resultShelf.isNotEmpty) {
    for (Shelf sh in resultShelf) {
      List<int>? bookId = sh.bookId;
      List<Book> b2 = book.where((b) {
        return bookId!.contains(b.id);
      }).toList();
      for (Book b in b2) {
        Author a1 = author.firstWhere((a) {
          return b.authorId == a.id;
        });
        print('${sh.name} ${b.id} ${b.name} ${a1.firstName} ${a1.lastName}');
      }
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

void editShelf(List<Shelf> shelf, List<Book> book, List<Author> author) {
  stdout.write('shelf name: ');
  String name = stdin.readLineSync()!;
  Shelf result = shelf.firstWhere((sh) {
    return sh.name == name;
  });
  stdout.write('rename: ');
  String rename = stdin.readLineSync()!;
  result.name = rename;
  printBookWithShelves(book, author, shelf);
}

void printBookWithShelves(
  List<Book> book,
  List<Author> author,
  List<Shelf> shelf,
) {
  for (Shelf sh in shelf) {
    List<int>? bookId = sh.bookId;
    List<Book> b1 = book.where((b) {
      return bookId!.contains(b.id);
    }).toList();
    for (Book b in b1) {
      int authorId = b.authorId!;
      Author a1 = author.firstWhere((a) {
        return authorId == a.id;
      });
      print('${sh.name},${b.id},${b.name},${a1.firstName},${a1.lastName}');
    }
  }
}

void transferBookBetweenShelves(
  List<Shelf> shelf,
  List<Book> book,
  List<Author> author,
) {
  stdout.write('book IDs (comma separated): ');
  String input = stdin.readLineSync()!;
  List<String>? id = input.split(',');
  List<int> bookId = id.map((e) => int.parse(e.trim())).toList();
  stdout.write('Source shelf: ');
  String source = stdin.readLineSync()!;
  stdout.write('Destination shelf: ');
  String destination = stdin.readLineSync()!;
  Shelf sourceName = shelf.firstWhere((sh) {
    return sh.name == source;
  });
  List<int> bookToTransfer = sourceName.bookId!.where((b) {
    return bookId.contains(b);
  }).toList();
  Shelf destinationName = shelf.firstWhere((sh) {
    return sh.name == destination;
  });
  destinationName.bookId!.addAll(bookToTransfer);
  sourceName.bookId!.removeWhere((id) {
    return bookToTransfer.contains(id);
  });
  printBookWithShelves(book, author, shelf);
}

int MaxauthorId(List<Author> author) {
  int maxId = 0;
  for (Author a in author) {
    if (a.id > maxId) {
      maxId = a.id;
    }
  }
  return maxId + 1;
}

int MaxbookId(List<Book> book) {
  int maxId = 0;
  for (Book b in book) {
    if (b.id > maxId) {
      maxId = b.id;
    }
  }
  return maxId + 1;
}

int MaxShelfId(List<Shelf> shelf) {
  int maxId = 0;
  for (Shelf sh in shelf) {
    if (sh.id > maxId) {
      maxId = sh.id;
    }
  }
  return maxId + 1;
}
