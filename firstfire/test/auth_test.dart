import 'package:firstfire/services/auth/auth_exceptions.dart';
import 'package:firstfire/services/auth/auth_provider.dart';
import 'package:firstfire/services/auth/auth_user.dart';
import 'package:test/test.dart';

void main() {
  group("mock authentication", () {
    final provider = MockAuthProvider();
    test("should not be initialized by default", () {
      expect(provider.isInitialized, false);
    });
    test("Cannot logout before login", () {
      expect(provider.logout(),
          throwsA(const TypeMatcher<NotInitializedException>()));
    });
    test("can be initialized", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    });
    test("user should null after initialization", () {
      expect(provider.currentUser, null);
    });
    test("initialization should take less than 2 seconds", () async {
      await provider.initialize();
      expect(provider.isInitialized, true);
    }, timeout: Timeout(Duration(seconds: 2)));
    test("invalid email should throw exception", () async {
      final badEmailUser =
          await provider.createUser(email: "adfs", password: "124d2433");
      expect(badEmailUser, throwsA(TypeMatcher<InvalidEmailAuthException>()));
      final badPasswordUser =
          await provider.createUser(email: "ad@bc.di", password: "124");
      expect(
          badPasswordUser, throwsA(TypeMatcher<WeakPasswordAuthException>()));
      final user =
          await provider.createUser(email: "ad@bc.di", password: "sadfs312");
      expect(provider.currentUser, user);
      expect(provider.isInitialized, false);
    });
  });
}

class NotInitializedException implements Exception {}

class MockAuthProvider implements AuthProvider {
  AuthUser? _user;
  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;
  @override
  Future<AuthUser> createUser({
    required String email,
    required String password,
  }) async {
    if (!isInitialized) throw NotInitializedException();
    await Future.delayed(Duration(seconds: 1));
    return login(email: email, password: password);
  }

  @override
  // TODO: implement currentUser
  AuthUser? get currentUser => _user;

  @override
  Future<void> initialize() async {
    await Future.delayed(Duration(seconds: 1));
    _isInitialized = true;
  }

  @override
  Future<AuthUser> login({
    required String email,
    required String password,
  }) {
    if (!isInitialized) throw NotInitializedException();
    RegExp emailPattern = RegExp(r"^[a-zA-Z0-9._]+@\w+(\.\w{2,}){1,2}$");
    if (emailPattern.firstMatch(email) == null) {
      throw InvalidEmailAuthException();
    } else if (password.length < 6) {
      throw WeakPasswordAuthException();
    }
    _user = AuthUser(isEmailVerified: false, email: email);
    return Future.value(_user);
  }

  @override
  Future<void> logout() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user != null) throw UserNotFoundAuthException();
    await Future.delayed(Duration(seconds: 1));
    _user = null;
  }

  @override
  Future<void> sendEmailVerification() async {
    if (!isInitialized) throw NotInitializedException();
    if (_user != null) throw UserNotFoundAuthException();
    await Future.delayed(Duration(seconds: 1));
    _user = AuthUser(isEmailVerified: true, email: "foo@bar.baz");
  }
}
