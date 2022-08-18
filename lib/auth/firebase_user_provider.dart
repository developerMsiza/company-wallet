import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class CompanyWalletFirebaseUser {
  CompanyWalletFirebaseUser(this.user);
  User? user;
  bool get loggedIn => user != null;
}

CompanyWalletFirebaseUser? currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<CompanyWalletFirebaseUser> companyWalletFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<CompanyWalletFirebaseUser>(
            (user) => currentUser = CompanyWalletFirebaseUser(user));
