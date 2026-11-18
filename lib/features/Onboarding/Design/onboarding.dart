import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
// import 'package:onboarding/onboarding2.dart';
import 'dart:async'; //For Timer
import 'package:onboarding/Core/Directories.dart';
import 'package:onboarding/onboarding2.dart';

class AppRoutes {
  static const String home = '/';
  static const String feature = '/feature';
}

//Slide transition for Gorouter
CustomTransitionPage<void> buildSlidePage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(seconds: 3),
    reverseTransitionDuration: const Duration(seconds: 3),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      // Slide in from the right (1.0, 0.0) to center (0.0, 0.0)
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => buildSlidePage(
        context: context,
        state: state,
        child: const AidlyOnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.feature,
      pageBuilder: (context, state) => buildSlidePage(
        context: context,
        state: state,
        child: const AidlyOnboardingScreen2(),
      ),
    ),
  ],
);

void main() {
  runApp(const AidlyApp());
}

// MAIN APPLICATION
class AidlyApp extends StatelessWidget {
  const AidlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: appRouter,
    );
  }
}

// ONBOARDING SCREEN
class AidlyOnboardingScreen extends StatefulWidget {
  const AidlyOnboardingScreen({super.key});

  @override
  State<AidlyOnboardingScreen> createState() =>
      _AidlyOnboardingScreenState();
}

class _AidlyOnboardingScreenState extends State<AidlyOnboardingScreen> {
  Timer? navigationTimer;
  bool hasNavigated = false;
  int currentPage = 0;

  final Color primaryBlue = const Color(0xFF0782FF);
  final Color darkBlue = const Color(0xFF18345D);

  //Timer Start when page open
  @override
  void initState() {
    super.initState();

    navigationTimer = Timer(
      const Duration(seconds: 3),
          () {navigateToNextPage();},
    );
  }

  @override
  void dispose() {          //CANCEL TIMER WHEN PAGE IS CLOSED
    navigationTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFFAFCFF),
              Color(0xFFE3F5FF),
              Color(0xFFB9E7FA),
            ],
          ),
        ),

        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(         //LOGO
              top: screenHeight * 0.060,
              child: Image.asset(
                'assets/icons/darklogo.png',
                width: screenWidth * 0.40,
                height: screenHeight * 0.200,
                fit: BoxFit.contain,
              ),
            ),
            Positioned(             // 2. AIDLY TAGLINE
              top: screenHeight * 0.250,
              child: Text(
                'ALL IN ONE HEALTHCARE PLATFORM',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (screenWidth * 0.041)
                      .clamp(9.0, 12.0)
                      .toDouble(),
                  color: primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Positioned(         // 3. MAIN HEADING
              top: screenHeight * 0.300,
              child: SizedBox(
                width: screenWidth * 0.85,
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      fontSize: (screenWidth * 0.091)
                          .clamp(19.0, 23.0)
                          .toDouble(),
                      fontWeight: FontWeight.bold,
                      height: 1.02,
                    ),
                    children: [
                      TextSpan(
                        text: 'Healthcare for\n'
                            'every moment\n',
                        style: TextStyle(
                          color: darkBlue,
                        ),
                      ),
                      TextSpan(
                        text: 'that matters',
                        style: TextStyle(
                          color: primaryBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(        // 4. DESCRIPTION
              top: screenHeight * 0.400,
              child: SizedBox(
                width: screenWidth * 0.85,
                child: Text(
                  'Faster access. Better care.\nAll in one place.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: (screenWidth * 0.052)
                        .clamp(11.0, 14.0)
                        .toDouble(),
                    color: const Color(0xFF64748B),
                    fontWeight: FontWeight.w500,
                    height: 1.25,
                  ),
                ),
              ),
            ),
            Positioned(       // 5. HEALTHCARE IMAGE
              bottom: screenHeight * 0.078,
              child: Image.asset(
                'assets/images/splashImage.png',
                width: screenWidth,
                height: screenWidth * (179 / 219),
                fit: BoxFit.fill,
              ),
            ),
            Positioned(      //  THREE DOTS BOTTOM NAVIGATION
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: screenHeight * 0.16,
                child: Stack(
                  children: [
                    Positioned(          // TRANSPARENT CURVED BACKGROUND
                      left: 0,
                      right: 0,
                      bottom: 10,
                      height: screenHeight * 0.12,
                      child: ClipPath(
                        clipper: BottomNavCurveClipper(),
                        child: Container(
                          color: Colors.white.withValues(
                            alpha: 0.5,
                          ),
                        ),
                      ),
                    ),
                    ClipPath(          // MAIN WHITE CURVED CONTAINER
                      clipper: BottomNavCurveClipper(),
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.14,
                        color: Colors.white,

                        padding: EdgeInsets.only(
                          left: screenWidth * 0.10,
                          right: screenWidth * 0.05,
                          top: screenHeight * 0.055,
                        ),

                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment:
                          CrossAxisAlignment.center,
                          children: [
                            Row(       // PAGE INDICATORS
                              children: List.generate(3, (index) {
                                return GestureDetector(
                                  onTap: () {        //Navigation using blue button manual
                                    navigateToNextPage();
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      seconds: 1,
                                    ),
                                    margin: const EdgeInsets.only(right: 6),
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPage == index
                                          ? primaryBlue
                                          : const Color(0xFFDBEAFE),
                                    ),
                                  ),
                                );
                              }),
                            ),

                            Material(         // next button  auto
                              color: primaryBlue,
                              shape: const CircleBorder(),
                              elevation: 5,
                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  navigateToNextPage();       // Cancels timer safely and triggers slide transition
                                },
                                child: SizedBox(
                                  width: screenWidth * 0.135,
                                  height: screenWidth * 0.135,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigateToNextPage() {           //COMMON NAVIGATION FUNCTION
    if (hasNavigated || !mounted) {
      return;
    }
    navigationTimer?.cancel();
    hasNavigated = true;
    context.go('/feature');
  }
}

// CUSTOM CLIPPER FOR CURVED BOTTOM NAVIGATION
class BottomNavCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.moveTo(0, size.height * 0.35);

    path.quadraticBezierTo(
      size.width / 2,
      -size.height * 0.35,
      size.width,
      size.height * 0.35,
    );

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
