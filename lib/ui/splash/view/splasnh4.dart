import '../../../all_packages.dart';

class SplashView extends StatefulWidget {
  final int index;
  const SplashView({super.key, required this.index});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  bool _isInitialized = false;

  final List<Map<String, dynamic>> splashData = [
    {
      "title": "Welcome to GameZone",
      "subtitle": "Experience the best gaming platform tailored for you.",
      "icon": Icons.sports_esports,
    },
    {
      "title": "Play Unlimited Games",
      "subtitle": "Discover and play thousands of games anytime, anywhere.",
      "icon": Icons.videogame_asset,
    },
    {
      "title": "Track Live Scores",
      "subtitle": "Stay updated with real-time scores and leaderboards.",
      "icon": Icons.leaderboard,
    },
    {
      "title": "Let's Get Started",
      "subtitle": "Join our community and begin your journey today.",
      "icon": Icons.rocket_launch,
    },
  ];

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutQuart));

    controller.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    });

    if (widget.index == 1) {
      checkOnboardingState();
    }
  }

  Future<void> checkOnboardingState() async {
    await Future.delayed(const Duration(milliseconds: 2500));
    if (FirebaseAuth.instance.currentUser != null) {
      Get.offAllNamed('/home');
      return;
    }
    final prefs = await SharedPreferences.getInstance();
    final bool hasSeenOnboarding = prefs.getBool('hasSeenOnboarding') ?? false;
    if (hasSeenOnboarding) {
      Get.offNamed(Routes.register);
    } else {
      Get.offNamed('/splash2');
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.index == 1) {
      return Scaffold(
        body: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF001540), Color(0xFF0052CC)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: !_isInitialized
              ? const SizedBox()
              : FadeTransition(
                  opacity: fadeAnimation,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.sports_esports,
                        size: 120,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        "GameZone",
                        style: Theme.of(context).textTheme.headlineLarge
                            ?.copyWith(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                      ),
                    ],
                  ),
                ),
        ),
      );
    }
    final data = splashData[widget.index - 1];
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF001540), Color(0xFF0052CC)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: !_isInitialized
            ? const SizedBox()
            : SafeArea(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    FadeTransition(
                      opacity: fadeAnimation,
                      child: SlideTransition(
                        position: slideAnimation,
                        child: Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withValues(alpha: 0.1),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(
                                  0xFF0052CC,
                                ).withValues(alpha: 0.5),
                                blurRadius: 30,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                          child: Icon(
                            data['icon'],
                            size: 100,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    FadeTransition(
                      opacity: fadeAnimation,
                      child: SlideTransition(
                        position: slideAnimation,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32),
                          child: Column(
                            children: [
                              Text(
                                data['title'],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineLarge
                                    ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                data['subtitle'],
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                      color: Colors.white.withValues(
                                        alpha: 0.8,
                                      ),
                                      height: 1.5,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.symmetric(horizontal: 5),
                          height: 8,
                          width: widget.index - 2 == index ? 24 : 8,
                          decoration: BoxDecoration(
                            color: widget.index - 2 == index
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.3),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      }),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: ElevatedButton(
                        onPressed: () async {
                          if (widget.index < 4) {
                            Get.offNamed('/splash${widget.index + 1}');
                          } else {
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setBool('hasSeenOnboarding', true);
                            Get.offNamed(Routes.register);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: const Color(0xFF0052CC),
                          elevation: 0,
                        ),
                        child: Text(widget.index < 4 ? "Next" : "Get Started"),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
      ),
    );
  }
}
