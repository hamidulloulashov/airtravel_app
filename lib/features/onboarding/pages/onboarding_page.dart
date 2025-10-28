import 'dart:async';
import 'package:airtravel_app/core/client.dart';
import 'package:airtravel_app/data/repositories/onboarding_repository.dart';
import 'package:airtravel_app/features/onboarding/managers/onboarding_bloc.dart';
import 'package:airtravel_app/features/onboarding/managers/onboarding_event.dart';
import 'package:airtravel_app/features/onboarding/managers/onboarding_state.dart';
import 'package:airtravel_app/features/onboarding/widgtes/onboarding_slade.dart';
import 'package:airtravel_app/features/onboarding/widgtes/splash_page_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  bool _showSplash = true;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _showSplash = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_showSplash) {
      return const SplashPageWidget();
    }

    return BlocProvider(
      create: (_) => OnboardingBloc(OnboardingRepository(ApiClient()))
        ..add(LoadOnboardingEvent()),
      child: Scaffold(
        body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
            if (state is OnboardingLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OnboardingError) {
              return Center(
                child: Text(
                  "Xato: ${state.message}",
                  style: const TextStyle(color: Colors.red),
                ),
              );
            } else if (state is OnboardingLoaded) {
              final pages = state.slides;
              return Column(
                children: [
                
                  Expanded(
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: pages.length,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                      itemBuilder: (context, index) {
                        final data = pages[index];
                        return OnboardingSlideWidget(
                          data: OnboardingData(
                            title: data.title,
                            imagePath: data.picture,
                            showAutoLayout: index == pages.length - 1,
                            prompt: data.prompt,
                            id: data.id
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            pages.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentPage == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentPage == index
                                    ? const Color(0xFF4CAF50)
                                    : const Color(0xFF2C2C2C).withOpacity(0.3),
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          height: 54,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_currentPage < pages.length - 1) {
                                _pageController.nextPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              } else {
                                GoRouter.of(context).go("/home");
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF4CAF50),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(27),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              _currentPage == pages.length - 1
                                  ? 'Boshlash'
                                  : 'Keyingi',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
