import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test_task/helpers/database.dart';
import 'package:flutter_test_task/helpers/routes.dart';
import 'package:flutter_test_task/models/current_user_model.dart';
import 'package:flutter_test_task/models/user_model.dart';
import 'package:flutter_test_task/utils/validators.dart';
import 'package:flutter_test_task/widgets/custom_snackbar.dart';
import 'package:sembast/sembast.dart';

class AuthProvider extends ChangeNotifier {
  //check if user already registered
  bool doesUserAlreadyExist = false;
  bool doesUserpasswordMatch = false;
  static const String folderName = "CurrentUser";
  final _currentUserFolder = intMapStoreFactory.store(folderName);
  static const String folderName1 = "CurrentUserSession";

  final _currentUserFolder1 = intMapStoreFactory.store(folderName1);
  Future<Database> get _db async => await AppDatabase.instance.database;

  //function to match user credentials at login
  doesUserMatch(allUsers, email, password) {
    if (allUsers != null && allUsers.isNotEmpty) {
      for (var i = 0; i <= allUsers.length - 1; i++) {
        if (email == allUsers[i].email) {
          if (password == allUsers[i].password) {
            doesUserpasswordMatch = true;
            notifyListeners();
          }
          doesUserAlreadyExist = true;
          notifyListeners();
        }
      }
    }
  }

  //function to check if user already exists
  doesUserAlreadyExists(allUsers, email) {
    if (allUsers != null && allUsers.isNotEmpty) {
      for (var i = 0; i <= allUsers.length - 1; i++) {
        if (email == allUsers[i].email) {
          doesUserAlreadyExist = true;
          notifyListeners();
        }
      }
    }
  }

  // Future getUser(CurrentUser user) async {
  //   final finder = Finder(filter: Filter.byKey(user.email));
  //   final currentUser =
  //       await _currentUserFolder.findFirst(await _db, finder: finder);

  //   return currentUser;
  // }

  //get all the signed up users
  Future<List<User>> getAllUsers() async {
    final usersSnapshot = await _currentUserFolder.find(await _db);
    return usersSnapshot.map((snapshot) {
      final users = User.fromJson(snapshot.value);
      return users;
    }).toList();
  }

  //create a new user
  Future createUser(User user) async {
    await _currentUserFolder.add(await _db, user.toJson());
  }

  // get current user
  Future getCurrentUser() async {
    final usersSnapshot = await _currentUserFolder1.find(await _db);
    return usersSnapshot.map((snapshot) {
      final user = User.fromJson(snapshot.value);
      return user;
    }).toList();
  }

  //create a user session
  Future createUserSession(CurrentUser user) async {
    await _currentUserFolder1.add(await _db, user.toJson());
  }

  // Future updateBooks(Books books) async {
  //   final finder = Finder(filter: Filter.byKey(books.rollNo));
  //   await _booksFolder.update(await _db, books.toJson(), finder: finder);
  // }

  // Future delete(Books books) async {
  //   final finder = Finder(filter: Filter.byKey(books.rollNo));
  //   await _booksFolder.delete(await _db, finder: finder);
  // }

  // Future<List<Books>> getAllBooks() async {
  //   final recordSnapshot = await _booksFolder.find(await _db);
  //   return recordSnapshot.map((snapshot) {
  //     final books = Books.fromJson(snapshot.value);
  //     return books;
  //   }).toList();
  // }

  //login user
  void login(emailController, passwordController, key) async {
    String response = await rootBundle.loadString('assets/login.json');
    String _email = emailController;
    String _password = passwordController;
    var responce;
    List<User> allUsers = await getAllUsers();
    doesUserMatch(allUsers, _email, _password);
    if (_email.isEmpty) {
      showCustomSnackBar(key.currentContext, 'Please enter your email address');
    } else if (!Validators.isEmail(_email)) {
      showCustomSnackBar(key.currentContext, 'Enter a valid email address');
    } else if (_password.isEmpty) {
      showCustomSnackBar(key.currentContext, 'Password cannot be empty');
    } else if (_password.length < 6) {
      showCustomSnackBar(
          key.currentContext, 'Password should be 6 or more characters long');
    } else if (doesUserAlreadyExist == false) {
      showCustomSnackBar(
          key.currentContext, 'User doesnt exist,plz signup first');
    } else if (doesUserAlreadyExist == true && doesUserpasswordMatch == false) {
      showCustomSnackBar(key.currentContext, 'Password incorrect');
    } else {
      CurrentUser _user = CurrentUser(email: _email, password: _password);

      showCustomSnackBar(key.currentContext, 'Login Successfull');
      createUserSession(_user).then((_) => Navigator.of(key.currentContext)
          .pushNamed(RouteHelper.userDashboard));
    }
    notifyListeners();
  }

  //register a user
  void register(emailController, passwordController, firstNameController,
      lastNameController, key) async {
    String _email = emailController;
    String _password = passwordController;
    String _firstName = firstNameController;
    String _lastName = lastNameController;

    List<User> allUsers = await getAllUsers();
    doesUserAlreadyExists(allUsers, _email);
    if (_firstName.isEmpty) {
      showCustomSnackBar(key.currentContext, 'Enter your first name');
    } else if (_lastName.isEmpty) {
      showCustomSnackBar(key.currentContext, 'Enter your last name');
    } else if (_email.isEmpty) {
      showCustomSnackBar(key.currentContext, 'Enter your email address');
    } else if (!Validators.isEmail(_email)) {
      showCustomSnackBar(key.currentContext, 'Enter a valid email address');
    } else if (_password.isEmpty) {
      showCustomSnackBar(key.currentContext, 'Password cannot be empty');
    } else if (_password.length < 6) {
      showCustomSnackBar(
          key.currentContext, 'Password should be 6 or more characters long');
    } else if (doesUserAlreadyExist) {
      showCustomSnackBar(key.currentContext, 'User already exists,plz login');
      doesUserAlreadyExist = false;
      notifyListeners();
    } else {
      User _user = User(
          email: _email,
          password: _password,
          firstName: _firstName,
          lastName: _lastName);
      createUser(_user).then((_) =>
          showCustomSnackBar(key.currentContext, 'Registered Successfully'));
    }
  }
}
