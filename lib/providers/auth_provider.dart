import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/supabase_client.dart';

class AuthProvider with ChangeNotifier {
  User? _user;
  bool _isLoading = false;
  String? _error;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get error => _error;

  AuthProvider() {
    _getCurrentUser();
  }

  Future<void> _getCurrentUser() async {
    _user = SupabaseClient.auth.currentUser;
    notifyListeners();
  }

  Future<void> signUpWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final AuthResponse response = await SupabaseClient.auth.signUp(
        email: email,
        password: password,
      );

      _user = response.user;
      _isLoading = false;
      notifyListeners();
    } on AuthException catch (e) {
      _isLoading = false;
      _error = e.message;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'An unexpected error occurred';
      notifyListeners();
    }
  }

  Future<void> signInWithEmail(String email, String password) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final AuthResponse response = await SupabaseClient.auth.signInWithPassword(
        email: email,
        password: password,
      );

      _user = response.user;
      _isLoading = false;
      notifyListeners();
    } on AuthException catch (e) {
      _isLoading = false;
      _error = e.message;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'An unexpected error occurred';
      notifyListeners();
    }
  }

  Future<void> signInWithOAuth(Provider provider) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await SupabaseClient.auth.signInWithOAuth(
        provider,
        redirectTo: 'com.zhafiran.zvhive://login-callback/',
      );
    } on AuthException catch (e) {
      _isLoading = false;
      _error = e.message;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = 'An unexpected error occurred';
      notifyListeners();
    }
  }

  Future<void> signOut() async {
    try {
      await SupabaseClient.auth.signOut();
      _user = null;
      notifyListeners();
    } catch (e) {
      _error = 'Error signing out';
      notifyListeners();
    }
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }
}