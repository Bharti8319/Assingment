import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding/Core/Constants/Appassets.dart';
import 'package:onboarding/Core/Directories.dart';

void main() {
  runApp(const AidlyApp());
}

// MAIN APPLICATION
class AidlyApp extends StatelessWidget {
  const AidlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AidlyOnboardingScreen2(),
    );
  }
}

// ONBOARDING SCREEN
class AidlyOnboardingScreen2 extends StatefulWidget {
  const AidlyOnboardingScreen2({super.key});

  @override
  State<AidlyOnboardingScreen2> createState() =>
      _AidlyOnboardingScreen2State();
}

class _AidlyOnboardingScreen2State
    extends State<AidlyOnboardingScreen2> {
  int currentPage = 1;
  final Color primaryBlue = const Color(0xFF0782FF);
  final Color darkBlue = const Color(0xFF18345D);

  // HEALTHCARE SERVICES BOXES
  final features = [
    {"title": "Ambulance\nBooking", "image": AppAssets.ambulanceBookingIcon},
    {"title": "Home Care\nServices", "image": AppAssets.homeCareServicesIcon},
    {"title": "Healthcare\nStore", "image": AppAssets.healthcareStoreIcon},
    {"title": "Doctor\nAppointment", "image": AppAssets.doctorAppointmentIcon,},
    {"title": "Lab\nTests", "image": AppAssets.labTestsIcon},
    {"title": "Health\nInsurance", "image": AppAssets.healthInsuranceIcon},
  ];

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
          children: [
            Positioned(
              top: screenHeight * 0.068,
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
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
                      text: 'Everything you\n'
                          'need for your\n'
                          'healthcare,\n',
                      style: TextStyle(
                        color: darkBlue,
                      ),
                    ),
                    TextSpan(
                      text: 'in one place.',
                      style: TextStyle(
                        color: primaryBlue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: screenHeight * 0.250,
              left: screenWidth * 0.08,
              right: screenWidth * 0.08,
              child: Text(
                'Ambulance, doctors, homemcare and\n'
                    'many more all from one app.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: (screenWidth * 0.035)
                      .clamp(9.0, 11.0)
                      .toDouble(),
                  color: const Color(0xFF64748B),
                  height: 1.3,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // 3. HEALTHCARE SERVICE BOXES DIMENSIONS
            Positioned(
              top: screenHeight * 0.320,
              left: screenWidth * 0.055,
              right: screenWidth * 0.055,
              height: screenHeight * 0.270,
              child: GridView.builder(
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: features.length,

                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.05,
                ),

                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      context.go('/onboarding3');
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.75),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.white,
                          width: 1,
                        ),
                      ),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(      // SERVICE IMAGE DIMENSIONS
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                top: 8,
                                left: 8,
                                right: 8,
                              ),
                              child: Image.asset(
                                features[index]['image']!,
                                fit: BoxFit.contain,
                                errorBuilder: (context, error, stackTrace) {
                                  return Icon(
                                    Icons.image_not_supported,
                                    color: primaryBlue,
                                    size: 24,
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(          // SERVICE NAME
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                bottom: 4,
                              ),
                              child: Text(features[index]['title']!,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: (screenWidth * 0.030)
                                      .clamp(8.0, 10.0)
                                      .toDouble(),
                                  color: const Color(0xFF18345D),
                                  fontWeight: FontWeight.w500,
                                  height: 1.05,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            Positioned(           // 4. BOTTOM HEALTHCARE IMAGE ILLUSTRATION
              bottom: screenHeight * 0.045,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/featuresImage.png',
                width: screenWidth,
                height: screenHeight * 0.270,
                fit: BoxFit.fill,


                errorBuilder: (context, error, stackTrace) {    //EXCEPTION IF IMAGE IS NOT FOUND
                  return SizedBox(
                    height: screenHeight * 0.270,
                    child: Icon(
                      Icons.health_and_safety,
                      size: 100,
                      color: primaryBlue,
                    ),
                  );
                },
              ),
            ),

            Positioned(      // CURVED BOTTOM NAVIGATION
              left: 0,
              right: 0,
              bottom: 0,
              child: SizedBox(
                height: screenHeight * 0.105,
                child: Stack(
                  children: [
                    Positioned(         //CURVED BACKGROUND
                      left: 0,
                      right: 0,
                      bottom: 8,
                      height: screenHeight * 0.095,
                      child: ClipPath(
                        clipper: BottomNavCurveClipper(),
                        child: Container(
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ),

                    ClipPath(       // WHITE CURVED CONTAINER
                      clipper: BottomNavCurveClipper(),
                      child: Container(
                        width: double.infinity,
                        height: screenHeight * 0.105,
                        color: Colors.white,

                        padding: EdgeInsets.only(
                          left: screenWidth * 0.06,
                          right: screenWidth * 0.055,
                          top: screenHeight * 0.045,
                        ),

                        child: Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: List.generate(3, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {currentPage = index;});
                                  },

                                  child: AnimatedContainer(
                                    duration: const Duration(
                                      seconds: 1,
                                    ),
                                    margin: const EdgeInsets.only(
                                      right: 6,
                                    ),
                                    width: 5,
                                    height: 5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: currentPage == index
                                          ? primaryBlue
                                          : const Color(0xFFD5E5F5),
                                    ),
                                  ),
                                );
                              }),
                            ),

                            Material(             // NEXT BUTTON
                              color: primaryBlue,
                              shape: const CircleBorder(),
                              elevation: 5,

                              child: InkWell(
                                customBorder: const CircleBorder(),
                                onTap: () {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Next onboarding page',
                                      ),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  width: screenWidth * 0.135,
                                  height: screenWidth * 0.135,
                                  child: const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.white,
                                    size: 22,
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
}

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
