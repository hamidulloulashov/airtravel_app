import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:airtravel_app/data/model/home_model.dart';

class TokenStorage {
  static const _tokenKey = 'accsess_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _favoritesKey = 'favorites';
  
  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  static Future<void> deleteRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_refreshTokenKey);
  }

  static Future<bool> hasToken() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<List<Package>> getFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? favoritesJson = prefs.getString(_favoritesKey);
      
      if (favoritesJson != null && favoritesJson.isNotEmpty) {
        final List<dynamic> decoded = json.decode(favoritesJson);
        return decoded.map((item) => Package.fromJson(item)).toList();
      }
      
      return [];
    } catch (e) {
      return [];
    }
  }

  static Future<bool> saveFavorites(List<Package> favorites) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final String encoded = json.encode(
        favorites.map((p) => p.toJson()).toList()
      );
      await prefs.setString(_favoritesKey, encoded);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> addToFavorites(Package package) async {
    try {
      final favorites = await getFavorites();
      
      bool alreadyExists = favorites.any((p) => p.id == package.id);
      
      if (!alreadyExists) {
        favorites.add(package);
        return await saveFavorites(favorites);
      }
      
      return false; 
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeFromFavorites(Package package) async {
    try {
      final favorites = await getFavorites();
      
      favorites.removeWhere((p) => p.id == package.id);
      
      return await saveFavorites(favorites);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> removeFavoriteById(int packageId) async {
    try {
      final favorites = await getFavorites();
      
      favorites.removeWhere((p) => p.id == packageId);
      
      return await saveFavorites(favorites);
    } catch (e) {
      return false;
    }
  }

  static Future<bool> isFavorite(int? packageId) async {
    if (packageId == null) return false;
    
    try {
      final favorites = await getFavorites();
      return favorites.any((p) => p.id == packageId);
    } catch (e) {
      return false;
    }
  }

  static Future<int> getFavoritesCount() async {
    try {
      final favorites = await getFavorites();
      return favorites.length;
    } catch (e) {
      return 0;
    }
  }

  static Future<bool> clearAllFavorites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_favoritesKey);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> toggleFavorite(Package package) async {
    final isCurrentlyFavorite = await isFavorite(package.id);
    
    if (isCurrentlyFavorite) {
      return await removeFromFavorites(package);
    } else {
      return await addToFavorites(package);
    }
  }


  static Future<void> clearAll() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<void> clearTokensOnly() async {
    await deleteToken();
    await deleteRefreshToken();
  }
}