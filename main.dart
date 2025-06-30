import 'dart:ui';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Profile Card',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  bool _isHovered = false;
  late AnimationController _cardAnimationController;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  late AnimationController _backgroundAnimationController;
  late Animation<Color?> _backgroundColor1;
  late Animation<Color?> _backgroundColor2;

  @override
  void initState() {
    super.initState();
    // Card animation setup
    _cardAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _cardAnimationController, curve: Curves.easeInOut),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, -0.2), end: Offset.zero).animate(
      CurvedAnimation(
          parent: _cardAnimationController, curve: Curves.easeInOut),
    );
    _cardAnimationController.forward();

    // Background animation setup
    _backgroundAnimationController = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true);
    _backgroundColor1 = ColorTween(
      begin: Colors.deepPurple,
      end: Colors.blueAccent,
    ).animate(_backgroundAnimationController);
    _backgroundColor2 = ColorTween(
      begin: Colors.purpleAccent,
      end: Colors.pinkAccent,
    ).animate(_backgroundAnimationController);
  }

  @override
  void dispose() {
    _cardAnimationController.dispose();
    _backgroundAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _backgroundAnimationController,
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [_backgroundColor1.value!, _backgroundColor2.value!],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _isHovered = !_isHovered;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(24),
                  width: 340,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: _isHovered
                            ? Colors.deepPurple.withOpacity(0.6)
                            : Colors.black.withOpacity(0.3),
                        blurRadius: _isHovered ? 25 : 12,
                        spreadRadius: _isHovered ? 5 : 0,
                        offset: const Offset(0, 6),
                      ),
                    ],
                    border: Border.all(
                      color: _isHovered
                          ? Colors.white.withOpacity(0.5)
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: FadeTransition(
                        opacity: _opacityAnimation,
                        child: SlideTransition(
                          position: _slideAnimation,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                children: [
                                  CircleAvatar(
                                    radius: 60,
                                    backgroundColor: Colors.deepPurple[100],
                                    child: CircleAvatar(
                                      radius: 55,
                                      backgroundColor: Colors.deepPurple,
                                      child: Text(
                                        'AK',
                                        style: TextStyle(
                                          fontSize: 32,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: const BoxDecoration(
                                        color: Colors.deepPurple,
                                        shape: BoxShape.circle,
                                      ),
                                      child: const Icon(
                                        Icons.verified,
                                        color: Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'Adarsh Kumar',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  letterSpacing: 1.2,
                                  shadows: [
                                    Shadow(
                                      color: Colors.black26,
                                      blurRadius: 4,
                                      offset: Offset(0, 2),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Flutter Developer Intern',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white70,
                                  fontStyle: FontStyle.italic,
                                  letterSpacing: 0.8,
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Divider(
                                color: Colors.white54,
                                thickness: 0.5,
                                indent: 20,
                                endIndent: 20,
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  _buildSkillColumn(Icons.phone_android,
                                      'Mobile Dev', Colors.blueAccent),
                                  _buildSkillColumn(Icons.palette,
                                      'UI/UX Design', Colors.pinkAccent),
                                  _buildSkillColumn(Icons.code, 'Flutter',
                                      Colors.greenAccent),
                                ],
                              ),
                              const SizedBox(height: 20),
                              AnimatedOpacity(
                                opacity: _isHovered ? 1.0 : 0.7,
                                duration: const Duration(milliseconds: 300),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                          content: Text('Contact Me Clicked!')),
                                    );
                                  },
                                  icon: const Icon(Icons.email),
                                  label: const Text('Contact Me'),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Colors.deepPurple.withOpacity(0.8),
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 12),
                                    shadowColor: _isHovered
                                        ? Colors.deepPurple
                                        : Colors.black26,
                                    elevation: _isHovered ? 8 : 4,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSkillColumn(IconData icon, String label, Color color) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: _isHovered
                ? color.withOpacity(0.2)
                : Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: color.withOpacity(0.4),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ]
                : [],
          ),
          child: Icon(icon, color: color, size: 30),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
