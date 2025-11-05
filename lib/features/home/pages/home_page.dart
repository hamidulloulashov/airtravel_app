import 'dart:async';
import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/data/model/home_model.dart';
import 'package:airtravel_app/data/repositories/home_repository.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:airtravel_app/features/home/managers/home_bloc.dart';
import 'package:airtravel_app/features/home/managers/home_event.dart';
import 'package:airtravel_app/features/home/managers/home_state.dart';
import 'package:airtravel_app/features/home/widgets/banner_carudel_widget.dart';
import 'package:airtravel_app/features/home/widgets/package_card_widget.dart';
import 'package:airtravel_app/features/home/widgets/popular_places_carusel.dart';
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
  String? _errorMessage;
  
  Timer? _timer;
  int _hours = 12;
  int _minutes = 0;
  int _seconds = 30;

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
    
    _startCountdownTimer();
  }

  void _startCountdownTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          if (_seconds > 0) {
            _seconds--;
          } else if (_minutes > 0) {
            _minutes--;
            _seconds = 59;
          } else if (_hours > 0) {
            _hours--;
            _minutes = 59;
            _seconds = 59;
          } else {
            // Timer tugadi
            _timer?.cancel();
          }
        });
      }
    });
  }

  Future<void> _loadPopularPlaces() async {
    if (_placesLoaded) {
      return;
    }
    
    _placesLoaded = true;
    
    setState(() {
      _isLoadingPlaces = true;
      _errorMessage = null;
    });
    
    try {
      final repository = HomeRepository(context.read<ApiClient>());
      final result = await repository.getPopularPlaces();
      
      result.fold(
        (error) {
          if (mounted) {
            setState(() {
              _isLoadingPlaces = false;
              _popularPlaces = [];
              _errorMessage = error.toString();
            });
          }
        },
        (places) {
          if (mounted) {
            setState(() {
              _isLoadingPlaces = false;
              _popularPlaces = places;
              _errorMessage = null;
            });
          }
        },
      );
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoadingPlaces = false;
          _popularPlaces = [];
          _errorMessage = e.toString();
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
    _timer?.cancel();
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const AppBarWidget(showThemeToggle: true),
      bottomNavigationBar: const BottomNavigationBarApp(),
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
          
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  _placesLoaded = false;
                  _isLoadingPlaces = true;
                  _errorMessage = null;
                });
                await _loadPopularPlaces();
                context.read<HomeBloc>().add(
                  const LoadPackages(isRefresh: true),
                );
              },
              child: CustomScrollView(
                controller: _scrollController,
                slivers: [
                  if (_errorMessage != null)
                    SliverToBoxAdapter(
                      child: Container(
                        margin: const EdgeInsets.all(16),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.red.shade50,
                          border: Border.all(color: Colors.red),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              '⚠️ Debug Info:',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              _errorMessage!,
                              style: const TextStyle(
                                fontSize: 12,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  
                  SliverToBoxAdapter(
                    child: BannerCarousel(
                      places: _popularPlaces,
                      isLoading: _isLoadingPlaces,
                      onBannerTapped: (place) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${place.title} banner bosildi'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: const Color(0xFF4CAF50),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 24),
                  ),
                  
                  SliverToBoxAdapter(
                    child: PopularPlacesCarousel(
                      places: _popularPlaces,
                      isLoading: _isLoadingPlaces,
                      onPlaceSelected: (place) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${place.title} tanlandi'),
                            duration: const Duration(seconds: 2),
                            backgroundColor: const Color(0xFF4CAF50),
                          ),
                        );
                      },
                    ),
                  ),
                  
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                  
                  SliverToBoxAdapter(
                    child: _buildTimerSection(),
                  ),
                  
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                  
                  BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state) {
                      if (state is PackageLoading) {
                        return const SliverFillRemaining(
                          child: Center(child: CircularProgressIndicator()),
                        );
                      }
                      
                      if (state is PackageError) {
                        return SliverFillRemaining(
                          child: _buildErrorWidget(state.message),
                        );
                      }
                      
                      if (state is PackageEmpty) {
                        return SliverFillRemaining(
                          child: _buildEmptyWidget(),
                        );
                      }
                      
                      if (state is PackageLoaded || state is PackageLoadingMore) {
                        final packages = state is PackageLoaded
                            ? state.packages
                            : (state as PackageLoadingMore).packages;
                        
                        return SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                if (index == packages.length &&
                                    state is PackageLoadingMore) {
                                  return const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  );
                                }
                                
                                if (index >= packages.length) return null;
                                
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 16),
                                  child: PackageCardWidget(
                                    package: packages[index],
                                    index: index,
                                  ),
                                );
                              },
                              childCount: state is PackageLoadingMore
                                  ? packages.length + 1
                                  : packages.length,
                            ),
                          ),
                        );
                      }
                      
                      return const SliverFillRemaining(
                        child: Center(child: Text('Kutilmoqda...')),
                      );
                    },
                  ),
                  
                  const SliverToBoxAdapter(
                    child: SizedBox(height: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFF176), Color(0xFFFFEB3B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.access_time_filled,
              color: Colors.orange,
              size: 32,
            ),
          ),
          
          const SizedBox(width: 16),
          
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shoshiling',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Chegirma tugashiga:',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
          
          _buildTimeDisplay(),
        ],
      ),
    );
  }

  Widget _buildTimeDisplay() {
    return Row(
      children: [
        _buildTimeBox(_hours.toString().padLeft(2, '0')),
        _buildTimeSeparator(),
        _buildTimeBox(_minutes.toString().padLeft(2, '0')),
        _buildTimeSeparator(),
        _buildTimeBox(_seconds.toString().padLeft(2, '0')),
      ],
    );
  }

  Widget _buildTimeBox(String value) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        value,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.orange,
          height: 1,
        ),
      ),
    );
  }

  Widget _buildTimeSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        ':',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          height: 1,
        ),
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
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
              ),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<HomeBloc>().add(
                const LoadPackages(isRefresh: true),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF4CAF50),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
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
          Icon(
            Icons.inventory_2_outlined,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'Paketlar topilmadi',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Keyinroq qayta urinib ko\'ring',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }
}