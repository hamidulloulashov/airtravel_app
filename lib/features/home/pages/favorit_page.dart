import 'package:airtravel_app/core/token_storage.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/home/widgets/package_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:airtravel_app/data/model/home_model.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({Key? key}) : super(key: key);

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  List<Package> _favoritePackages = [];
  Map<String, bool> _likedStatus = {};
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _isLoading = true;
    });

    final favorites = await TokenStorage.getFavorites();
    
    setState(() {
      _favoritePackages = favorites;
      
      _likedStatus.clear();
      for (var package in _favoritePackages) {
        _likedStatus[package.id?.toString() ?? ''] = true;
      }
      
      _isLoading = false;
    });
  }

  Future<void> _removeFavorite(Package package) async {
    setState(() {
      _favoritePackages.removeWhere((p) => p.id == package.id);
      _likedStatus[package.id?.toString() ?? ''] = false;
    });

    await TokenStorage.removeFromFavorites(package);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.favorite_border, color: Colors.white, size: 20),
              SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Sevimlilardan o\'chirildi',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          duration: const Duration(seconds: 2),
          backgroundColor: Colors.grey[700],
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.all(16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
    }
  }

  Future<void> _clearAllFavorites() async {
    if (mounted && context.canPop()) {
      context.pop();
    }
    
    setState(() {
      _favoritePackages.clear();
      _likedStatus.clear();
    });
    
    await TokenStorage.clearAllFavorites();
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Barcha sevimlilar o\'chirildi'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1A1A) : const Color(0xFFF5F5F5),
      appBar: AppBarWidget(
        showThemeToggle: true,
        showBackButton: false, 
        title: 'Sevimlilar',
        actions: [
          if (_favoritePackages.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: _showClearAllDialog,
              tooltip: 'Hammasini tozalash',
            ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF4CAF50),
              ),
            )
          : _favoritePackages.isEmpty
              ? _buildEmptyState()
              : _buildFavoritesList(),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.favorite_border,
            size: 100,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 20),
          Text(
            'Sevimlilar ro\'yxati bo\'sh',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            'Paketlarni sevimlilar qo\'shing',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () {
              
              context.go('/home'); 
            },
            icon: const Icon(Icons.explore),
            label: const Text('Paketlarni ko\'rish'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFavoritesList() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              const Icon(
                Icons.favorite,
                color: Colors.red,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                '${_favoritePackages.length} ta sevimli paket',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              childAspectRatio: 0.75,
              mainAxisSpacing: 16,
            ),
            itemCount: _favoritePackages.length,
            itemBuilder: (context, index) {
              final package = _favoritePackages[index];
              return PackageCardWidget(
                package: package,
                index: index,
                isLiked: _likedStatus[package.id?.toString() ?? ''] ?? true,
                onLikeChanged: (isLiked) {
                  setState(() {
                    _likedStatus[package.id?.toString() ?? ''] = isLiked;
                  });
                  if (!isLiked) {
                    _removeFavorite(package);
                  }
                },
                onDetailsPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Batafsil sahifaga o\'tilmoqda...'),
                      duration: Duration(seconds: 2),
                      backgroundColor: Color(0xFF4CAF50),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Hammasini o\'chirish?'),
        content: const Text(
          'Barcha sevimli paketlarni o\'chirmoqchimisiz?',
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Bekor qilish'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(dialogContext).pop(); 
              _clearAllFavorites(); 
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('O\'chirish'),
          ),
        ],
      ),
    );
  }
}