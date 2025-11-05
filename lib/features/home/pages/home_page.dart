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
                      print('🎨 Current state: ${state.runtimeType}');
                      
                      if (state is PackageLoading) {
                        return const SliverFillRemaining(
                          child: Center(
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                            ),
                          ),
                        );
                      }
                      
                      if (state is PackageSearching) {
                        return SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                                ),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    'Qidirilmoqda: "${state.query}"',
                                    style: TextStyle(
                                      color: Theme.of(context).textTheme.bodyLarge?.color,
                                      fontSize: 16,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      if (state is PackageSearchResults) {
                        print('📊 Showing ${state.packages.length} search results');
                        
                        if (state.packages.isEmpty) {
                          return SliverFillRemaining(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Hech narsa topilmadi',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Boshqa qidiruv so\'zini kiriting',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey[500],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        
                        return SliverToBoxAdapter(
                          child: _buildPackageSection(
                            packages: state.packages,
                            showResultCount: true,
                            resultCount: state.resultCount,
                          ),
                        );
                      }
                      
                      if (state is PackageError) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.error_outline, size: 64, color: Colors.red),
                                const SizedBox(height: 16),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 32),
                                  child: Text(
                                    state.message,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(fontSize: 16),
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
                          ),
                        );
                      }
                      
                      if (state is PackageEmpty) {
                        return SliverFillRemaining(
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.inbox_outlined, size: 64, color: Colors.grey[400]),
                                const SizedBox(height: 16),
                                Text(
                                  state.message ?? 'Paketlar topilmadi',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }
                      
                      if (state is PackageLoaded || state is PackageLoadingMore) {
                        final packages = state is PackageLoaded
                            ? state.packages
                            : (state as PackageLoadingMore).packages;
                        
                        
                        if (packages.isEmpty) {
                          return SliverFillRemaining(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.inventory_2_outlined, size: 64, color: Colors.grey[400]),
                                  const SizedBox(height: 16),
                                  Text(
                                    'Paketlar yo\'q',
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey[700],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        
                        return SliverToBoxAdapter(
                          child: _buildPackageSection(
                            packages: packages,
                            isLoadingMore: state is PackageLoadingMore,
                          ),
                        );
                      }
                      
                      return const SliverFillRemaining(
                        child: Center(
                          child: Text('Yuklanmoqda...'),
                        ),
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

  Widget _buildPackageSection({
    required List<Package> packages,
    bool isLoadingMore = false,
    bool showResultCount = false,
    int? resultCount,
  }) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = 320.0;
    final totalCardsWidth = packages.length * (cardWidth + 16);
    final centerPadding = (screenWidth - cardWidth) / 2;
    
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFB2FF59).withOpacity(0.2),
            const Color(0xFFFFEB3B).withOpacity(0.3),
          ],
        ),
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (showResultCount && resultCount != null)
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4CAF50).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: const Color(0xFF4CAF50),
                        width: 1.5,
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.search,
                          color: Color(0xFF4CAF50),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '$resultCount ta natija topildi',
                            style: const TextStyle(
                              color: Color(0xFF4CAF50),
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              
              const SizedBox(height: 16),
              
              SizedBox(
                height: 520,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: EdgeInsets.only(
                    left: totalCardsWidth < screenWidth ? centerPadding : 16,
                    right: totalCardsWidth < screenWidth ? centerPadding : 16,
                  ),
                  physics: const BouncingScrollPhysics(),
                  itemCount: packages.length + (isLoadingMore ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == packages.length && isLoadingMore) {
                      return Center(
                        child: Container(
                          width: 60,
                          margin: const EdgeInsets.only(right: 16),
                          child: const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                          ),
                        ),
                      );
                    }
                    
                    return PackageCardWidget(
                      package: packages[index],
                      index: index,
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
          
          Positioned(
            top: showResultCount && resultCount != null ? 24 : 24,
            right: 24,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFEB3B).withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.access_time,
                color: Color(0xFFFF6F00),
                size: 32,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTimerSection() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFFB2FF59).withOpacity(0.2),
            const Color(0xFFFFEB3B).withOpacity(0.3),
          ],
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Container(
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
}