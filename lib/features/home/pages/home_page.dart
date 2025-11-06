import 'dart:async';
import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/data/model/home_model.dart';
import 'package:airtravel_app/data/repositories/home_repository.dart';
import 'package:airtravel_app/features/common/widgets/app_bar_widget.dart';
import 'package:airtravel_app/features/common/widgets/bottom_navigation_bar_app.dart';
import 'package:airtravel_app/features/home/managers/home_bloc.dart';
import 'package:airtravel_app/features/home/managers/home_event.dart';
import 'package:airtravel_app/features/home/managers/home_state.dart';
import 'package:airtravel_app/features/home/widgets/search_bar_widget.dart';
import 'package:airtravel_app/features/home/widgets/home_content_widget.dart';
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
              child: HomeContentWidget(
                errorMessage: _errorMessage,
                popularPlaces: _popularPlaces,
                isLoadingPlaces: _isLoadingPlaces,
                hours: _hours,
                minutes: _minutes,
                seconds: _seconds,
                onBannerTapped: (place) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${place.title} banner bosildi'),
                      duration: const Duration(seconds: 2),
                      backgroundColor: const Color(0xFF4CAF50),
                    ),
                  );
                },
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
          ),
        ],
      ),
    );
  }
}