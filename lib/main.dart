import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const GramSebaApp());
}

class GramSebaApp extends StatelessWidget {
  const GramSebaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'গ্রাম সেবা',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF10B981)),
        textTheme: GoogleFonts.hindSiliguriTextTheme(),
      ),
      home: const IntroScreen(),
    );
  }
}

/// ---------------- INTRO / ONBOARDING ----------------
class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  final PageController _controller = PageController();
  int index = 0;

  final pages = const [
    _IntroPageData(
      title: "গ্রাম সেবা",
      subtitle: "সরিষাবাড়ীর ডিজিটাল সেবা প্ল্যাটফর্ম",
      desc: "এক অ্যাপেই পাবেন জরুরি নম্বর, লোকাল ডিরেক্টরি, দ্রুত সার্চ ও প্রয়োজনীয় তথ্য।",
      icon: Icons.grid_view_rounded,
    ),
    _IntroPageData(
      title: "দ্রুত সার্চ",
      subtitle: "Smart Directory • Fast Search",
      desc: "ডাক্তার, হাসপাতাল, রক্ত, অ্যাম্বুলেন্স, থানার নাম্বার—সব সহজে খুঁজে পান।",
      icon: Icons.manage_search_rounded,
    ),
    _IntroPageData(
      title: "জরুরি সেবা",
      subtitle: "Emergency Ready",
      desc: "যেকোনো জরুরিতে এক ক্লিকেই যোগাযোগ করুন। নিরাপদ থাকুন, প্রস্তুত থাকুন।",
      icon: Icons.local_hospital_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Premium gradient background
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.9),
                radius: 1.3,
                colors: [
                  Color(0x3310B981),
                  Color(0x226366F1),
                  Color(0xFF0B1220),
                ],
              ),
            ),
          ),

          // Glass card content
          SafeArea(
            child: Column(
              children: [
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      _ChipBadge(
                        text: "NEW • 2026",
                        icon: Icons.auto_awesome_rounded,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text("Skip"),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 10),

                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    onPageChanged: (i) => setState(() => index = i),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: _GlassCard(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: size.width * 0.35,
                                width: size.width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(28),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF10B981),
                                      Color(0xFF6366F1),
                                    ],
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 30,
                                      spreadRadius: 2,
                                      color: Color(0x4410B981),
                                      offset: Offset(0, 10),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  pages[i].icon,
                                  size: size.width * 0.18,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 28),
                              Text(
                                pages[i].title,
                                style: const TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                pages[i].subtitle,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFB9C6FF),
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  pages[i].desc,
                                  style: const TextStyle(
                                    fontSize: 14.5,
                                    height: 1.5,
                                    color: Color(0xFFB8C0D9),
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 10),
                _Dots(count: pages.length, activeIndex: index),
                const SizedBox(height: 18),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    children: [
                      Expanded(
                        child: _PremiumButton(
                          text: index == pages.length - 1 ? "Get Started" : "Next",
                          icon: Icons.arrow_forward_rounded,
                          onTap: () {
                            if (index < pages.length - 1) {
                              _controller.nextPage(
                                duration: const Duration(milliseconds: 350),
                                curve: Curves.easeOut,
                              );
                            } else {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const LoginScreen()),
                              );
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _IntroPageData {
  final String title;
  final String subtitle;
  final String desc;
  final IconData icon;

  const _IntroPageData({
    required this.title,
    required this.subtitle,
    required this.desc,
    required this.icon,
  });
}

/// ---------------- LOGIN ----------------
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;
  bool showPass = false;

  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0B1220),
                  Color(0xFF101B3D),
                ],
              ),
            ),
          ),
          Positioned(
            left: -40,
            top: 80,
            child: _GlowBlob(color: const Color(0x6610B981)),
          ),
          Positioned(
            right: -30,
            bottom: 120,
            child: _GlowBlob(color: const Color(0x666366F1)),
          ),

          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      ),
                      const Spacer(),
                      _ChipBadge(
                        text: "Secure Login",
                        icon: Icons.verified_user_rounded,
                      )
                    ],
                  ),
                  const SizedBox(height: 18),

                  const Text(
                    "স্বাগতম 👋",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "আপনার Gram Seba একাউন্টে লগইন করুন",
                    style: TextStyle(
                      fontSize: 14.5,
                      color: Color(0xFFB8C0D9),
                    ),
                  ),
                  const SizedBox(height: 20),

                  _GlassCard(
                    child: Column(
                      children: [
                        _InputField(
                          label: "মোবাইল নাম্বার",
                          hint: "01XXXXXXXXX",
                          controller: phoneCtrl,
                          prefix: Icons.phone_rounded,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 12),
                        _InputField(
                          label: "পাসওয়ার্ড",
                          hint: "••••••••",
                          controller: passCtrl,
                          prefix: Icons.lock_rounded,
                          obscure: !showPass,
                          suffix: IconButton(
                            onPressed: () => setState(() => showPass = !showPass),
                            icon: Icon(
                              showPass ? Icons.visibility_off_rounded : Icons.visibility_rounded,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),
                        _PremiumButton(
                          text: isLoading ? "Please wait..." : "Login",
                          icon: Icons.login_rounded,
                          onTap: isLoading
                              ? null
                              : () async {
                                  setState(() => isLoading = true);
                                  await Future.delayed(const Duration(seconds: 1));
                                  setState(() => isLoading = false);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (_) => const HomeScreen()),
                                  );
                                },
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot password?",
                            style: TextStyle(color: Color(0xFFB9C6FF)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 18),

                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "No account? Create one",
                        style: TextStyle(color: Color(0xFF10B981), fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- HOME (Basic Premium UI) ----------------
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF0B1220),
                  Color(0xFF0D1630),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Text(
                        "গ্রাম সেবা",
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0x1AFFFFFF),
                          border: Border.all(color: const Color(0x22FFFFFF)),
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.location_on_rounded, color: Color(0xFF10B981), size: 18),
                            SizedBox(width: 6),
                            Text(
                              "সরিষাবাড়ী",
                              style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Smart Directory • Fast Search • Emergency Ready",
                    style: TextStyle(color: Color(0xFFB8C0D9)),
                  ),
                  const SizedBox(height: 18),

                  _GlassCard(
                    child: Row(
                      children: [
                        const Icon(Icons.search_rounded, color: Colors.white),
                        const SizedBox(width: 10),
                        const Expanded(
                          child: Text(
                            "Search services, doctors, emergency...",
                            style: TextStyle(color: Colors.white70),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
                            gradient: const LinearGradient(
                              colors: [Color(0xFF10B981), Color(0xFF6366F1)],
                            ),
                          ),
                          child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 18),
                  const Text(
                    "Quick Services",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 10),

                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      children: const [
                        _ServiceTile(
                          title: "ডাক্তার",
                          icon: Icons.medical_services_rounded,
                        ),
                        _ServiceTile(
                          title: "হাসপাতাল",
                          icon: Icons.local_hospital_rounded,
                        ),
                        _ServiceTile(
                          title: "অ্যাম্বুলেন্স",
                          icon: Icons.emergency_rounded,
                        ),
                        _ServiceTile(
                          title: "রক্ত ডোনার",
                          icon: Icons.bloodtype_rounded,
                        ),
                        _ServiceTile(
                          title: "থানা",
                          icon: Icons.local_police_rounded,
                        ),
                        _ServiceTile(
                          title: "ফায়ার সার্ভিস",
                          icon: Icons.fire_truck_rounded,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---------------- UI Widgets ----------------

class _GlassCard extends StatelessWidget {
  final Widget child;
  const _GlassCard({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: const Color(0x14FFFFFF),
        border: Border.all(color: const Color(0x22FFFFFF)),
        boxShadow: const [
          BoxShadow(
            blurRadius: 30,
            color: Color(0x33000000),
            offset: Offset(0, 18),
          )
        ],
      ),
      child: child,
    );
  }
}

class _PremiumButton extends StatelessWidget {
  final String text;
  final IconData icon;
  final VoidCallback? onTap;

  const _PremiumButton({
    required this.text,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.6 : 1,
        child: Container(
          height: 54,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
              colors: [Color(0xFF10B981), Color(0xFF6366F1)],
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 25,
                color: Color(0x4410B981),
                offset: Offset(0, 12),
              )
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.5,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(width: 10),
              Icon(icon, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final IconData prefix;
  final Widget? suffix;
  final bool obscure;
  final TextInputType keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    required this.prefix,
    this.suffix,
    this.obscure = false,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white70,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscure,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: Colors.white38),
            prefixIcon: Icon(prefix, color: Colors.white70),
            suffixIcon: suffix,
            filled: true,
            fillColor: const Color(0x18FFFFFF),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(18),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ],
    );
  }
}

class _ServiceTile extends StatelessWidget {
  final String title;
  final IconData icon;

  const _ServiceTile({
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 52,
            width: 52,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF10B981), Color(0xFF6366F1)],
              ),
            ),
            child: Icon(icon, color: Colors.white),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}

class _Dots extends StatelessWidget {
  final int count;
  final int activeIndex;

  const _Dots({required this.count, required this.activeIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (i) {
        final active = i == activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: active ? 22 : 8,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF10B981) : const Color(0x44FFFFFF),
            borderRadius: BorderRadius.circular(20),
          ),
        );
      }),
    );
  }
}

class _ChipBadge extends StatelessWidget {
  final String text;
  final IconData icon;

  const _ChipBadge({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0x14FFFFFF),
        border: Border.all(color: const Color(0x22FFFFFF)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: const Color(0xFF10B981)),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white70,
              fontWeight: FontWeight.w800,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _GlowBlob extends StatelessWidget {
  final Color color;
  const _GlowBlob({required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            blurRadius: 140,
            spreadRadius: 60,
            color: color,
          )
        ],
      ),
    );
  }
}
