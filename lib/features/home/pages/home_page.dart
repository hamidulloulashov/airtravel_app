import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/data/model/home_model.dart';
import 'package:airtravel_app/data/repositories/home_repository.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/home/managers/home_bloc.dart';
import 'package:airtravel_app/features/home/managers/home_event.dart';
import 'package:airtravel_app/features/home/managers/home_state.dart';
import 'package:airtravel_app/features/home/widgets/package_card_widget.dart';
import 'package:airtravel_app/features/home/widgets/popular_place_widgted.dart';
import 'package:airtravel_app/features/home/widgets/search_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  bool _isInitialized = false;
  List<PopularPlace>? _popularPlaces;
  bool _isLoadingPlaces = true;
  bool _placesLoaded = false; 
  @override
  void initState() {
    super.initState();
    
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        final state = context.read<HomeBloc>().state;
        if (state is PackageLoaded && state.hasMore) {
          context.read<HomeBloc>().add(const LoadMorePackages());
        }
      }
    });
  }

  Future<void> _loadPopularPlaces() async {
    if (_placesLoaded) return; 
    _placesLoaded = true; 
    
    try {
      final repository = HomeRepository(context.read<ApiClient>());
      final result = await repository.getPopularPlaces();
      
      result.fold(
        (error) {
          if (mounted) {
            setState(() {
              _isLoadingPlaces = false;
              _popularPlaces = [];
            });
          }
        },
        (places) {
          if (mounted) {
            setState(() {
              _isLoadingPlaces = false;
              _popularPlaces = places;
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingPlaces = false;
          _popularPlaces = [];
        });
      }
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      _isInitialized = true;
      context.read<HomeBloc>().add(const LoadPackages());
      
      _loadPopularPlaces();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBarWidget(),
      body: Column(
        children: [
          SearchBarWidget(
            controller: _searchController,
            onSearch: (value) {
              if (value.isNotEmpty) {
                context.read<HomeBloc>().add(SearchPackages(value));
              }
            },
            onClear: () {
              context.read<HomeBloc>().add(
                const LoadPackages(isRefresh: true),
              );
            },
          ),
          PopularPlacesWidget(
            places: _popularPlaces,
            isLoading: _isLoadingPlaces,
          ),
          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                
                if (state is PackageLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (state is PackageError) {
                  return _buildErrorWidget(state.message);
                }
                
                if (state is PackageEmpty) {
                  return _buildEmptyWidget();
                }
                
                if (state is PackageLoaded) {
                  return _buildPackageList(state);
                }
                
                if (state is PackageLoadingMore) {
                  return _buildPackageListWithLoader(state);
                }
                
                return const Center(child: Text('Kutilmoqda...'));
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                const LoadPackages(isRefresh: true),
              );
            },
            child: const Text('Qayta urinish'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inventory_2_outlined, 
            size: 64, 
            color: Colors.grey[400]
          ),
          const SizedBox(height: 16),
          Text(
            'Paketlar topilmadi',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPackageList(PackageLoaded state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(
          const LoadPackages(isRefresh: true),
        );
      },
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: state.packages.length,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          return PackageCardWidget(
            package: state.packages[index],
            index: index,
          );
        },
      ),
    );
  }

  Widget _buildPackageListWithLoader(PackageLoadingMore state) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<HomeBloc>().add(
          const LoadPackages(isRefresh: true),
        );
      },
      child: ListView.separated(
        controller: _scrollController,
        padding: const EdgeInsets.all(16),
        itemCount: state.packages.length + 1,
        separatorBuilder: (context, index) => const SizedBox(height: 20),
        itemBuilder: (context, index) {
          if (index == state.packages.length) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            );
          }
          return PackageCardWidget(
            package: state.packages[index],
            index: index,
          );
        },
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Filtrlar',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Qo\'llash'),
            ),
          ],
        ),
      ),
    );
  }
}