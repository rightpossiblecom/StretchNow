import 'package:flutter/material.dart';
import 'package:stretchnow/core/constants/app_constants.dart';
import 'package:stretchnow/core/models/stretch_model.dart';
import 'package:stretchnow/core/services/storage_service.dart';

class StretchesViewModel extends ChangeNotifier {
  final StorageService _storageService;

  StretchesViewModel(this._storageService) {
    _loadFavorites();
  }

  BodyPart? _selectedBodyPart;
  BodyPart? get selectedBodyPart => _selectedBodyPart;

  final Set<String> _favoriteIds = {};
  Set<String> get favoriteIds => _favoriteIds;

  List<StretchExercise> get filteredStretches {
    if (_selectedBodyPart == null) return StretchExercise.catalog;
    return StretchExercise.getByBodyPart(_selectedBodyPart!);
  }

  List<StretchExercise> get favoriteStretches {
    return StretchExercise.catalog
        .where((s) => _favoriteIds.contains(s.id))
        .toList();
  }

  bool isFavorite(String id) => _favoriteIds.contains(id);

  void selectBodyPart(BodyPart? part) {
    _selectedBodyPart = part;
    notifyListeners();
  }

  Future<void> toggleFavorite(String id) async {
    if (_favoriteIds.contains(id)) {
      _favoriteIds.remove(id);
    } else {
      _favoriteIds.add(id);
    }
    await _saveFavorites();
    notifyListeners();
  }

  void _loadFavorites() {
    final stored =
        _storageService.getString(AppConstants.keyFavoriteStretches) ?? '';
    if (stored.isNotEmpty) {
      _favoriteIds.addAll(stored.split(','));
    }
  }

  Future<void> _saveFavorites() async {
    await _storageService.saveString(
      AppConstants.keyFavoriteStretches,
      _favoriteIds.join(','),
    );
  }
}
