import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:karthikprofile/core/provider/gradient_provider.dart';
import 'package:karthikprofile/core/widget/animated_text.dart';
import 'package:karthikprofile/core/widget/change_theme.dart';
import 'package:karthikprofile/core/widget/my_descrbtion.dart';
import 'package:karthikprofile/core/widget/profile_icon.dart';
import 'package:karthikprofile/core/widget/type_write_text.dart';
import 'package:karthikprofile/pdf_view.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return MaterialApp(
      title: 'Karthik - Flutter Developer',
      theme: theme,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePage();
}

class _MyHomePage extends ConsumerState<MyHomePage>
    with TickerProviderStateMixin {
  late ScrollController _scrollController;
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _bounceController;
  late AnimationController _parallaxController;

  final skills = [
    {'icon': 'assets/Flutter.png', 'name': 'Flutter'},
    {'icon': 'assets/Dart.png', 'name': 'Dart'},
    {'icon': 'assets/Appwrite.png', 'name': 'Appwrite'},
    {'icon': 'assets/Firebase.png', 'name': 'Firebase'},
    {'icon': 'assets/Git.png', 'name': 'Git'},
    {'icon': 'assets/restapi.png', 'name': 'REST API'},
  ];

  final companies = [
    {
      'name': 'Hifx It and media services pvt Ltd',
      'position': 'SrFlutter Developer',
      'duration': '2021 - Present',
      'description':
          'Developing cross-platform mobile applications using Flutter framework. Working on multiple projects including Posif, Tagcash, and various e-commerce applications.',
      'logo': 'assets/hifx.png',
    },
    {
      'name': 'Proaim Solutions llp',
      'position': 'Android/Flutter Developer',
      'duration': '2018 - 2021',
      'description':
          'Developed custom mobile applications for various clients. Specialized in Flutter development with focus on UI/UX and performance optimization.',
      'logo': 'assets/proaims.png',
    },
  ];

  final projects = [
    {
      'name': 'Posif',
      'description':
          'Posif is your all-in-one platform to chat, collaborate, manage users and groups, and run powerful apps—all under one roof.',
      'image': 'assets/posif.png',
      'android_link':
          'https://play.google.com/store/apps/details?id=com.posif.app&pcampaignid=web_share',
      'web_link': 'https://posif.com/',
      'type': 'Social Platform',
    },
    {
      'name': 'Tagcash',
      'description':
          'Philippines E-Wallet - Go Cashless with Tagcash. Set up a private or corporate account in seconds. Deposit via 7-11, Pesonet, bank deposits, Dragonpay and more.',
      'image': 'assets/tagcash.png',
      'android_link':
          'https://play.google.com/store/apps/details?id=app.tagcash.groups&pcampaignid=web_share',
      'web_link': 'https://tagcash.app/',
      'type': 'E-Wallet',
    },
    {
      'name': 'Saleena Gold',
      'description':
          'Our app contains different scheme for buying gold. Each month you can save up a little amount of gold. At the end of the scheme you can buy gold or get the money back.',
      'image': 'assets/tagcash.png',
      'android_link':
          'https://play.google.com/store/apps/details?id=com.saleena.goldflash&pcampaignid=web_share',
      'ios_link':
          'https://apps.apple.com/in/app/saleena-gold-flash/id1561582975',
      'type': 'E-Commerce',
    },
    {
      'name': 'ST Jewellery',
      'description':
          'Purchase beautiful gold jewellery directly from ST Jewellery. ST Jewellery\'s gold-saving app makes it easy to plan for weddings, festivals, or personal milestones.',
      'image': 'assets/tagcash.png',
      'android_link':
          'https://play.google.com/store/apps/details?id=com.stjewellery.stjewellerymsksoft&pcampaignid=web_share',
      'type': 'E-Commerce',
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _bounceController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _parallaxController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeController.forward();
    _slideController.forward();
    _bounceController.repeat(reverse: true);
    _parallaxController.repeat();

    // Add scroll listener for parallax effects
    _scrollController.addListener(() {
      final scrollOffset = _scrollController.offset;
      _parallaxController.value = (scrollOffset / 1000).clamp(0.0, 1.0);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _fadeController.dispose();
    _slideController.dispose();
    _bounceController.dispose();
    _parallaxController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final prev = ref.read(appEnvProvider);
      ref.read(appEnvProvider.notifier).state = AppEnv(
        size: size,
        isDark: prev.isDark,
      );
    });
    final gradient = ref.watch(backgroundGradientProvider);

    return Container(
      decoration: BoxDecoration(gradient: gradient),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              // Hero Section
              _buildHeroSection(),

              // About Section
              _buildAboutSection(),

              // Skills Section
              _buildSkillsSection(),

              // Experience Section
              _buildExperienceSection(),

              // Projects Section
              _buildProjectsSection(),

              // Contact Section
              _buildContactSection(),

              // Footer
              _buildFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeroSection() {
    return Container(
      height: 500, // Fixed height instead of percentage
      child: Stack(
        children: [
          // Parallax Background
          AnimatedBuilder(
            animation: _parallaxController,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  0,
                  _parallaxController.value * 30,
                ), // Reduced parallax effect
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.03),
                        Colors.white.withOpacity(0.01),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Main Content
          Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1400),
              child: _buildHeader(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ), // Reduced padding
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Theme Toggle
          //   Align(alignment: Alignment.topRight, child: ChangeTheme()),
          const SizedBox(height: 20), // Reduced spacing
          // Profile and Introduction
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 768) {
                // Mobile layout
                return Column(
                  children: [
                    ProfileIcon(),
                    const SizedBox(height: 15), // Reduced spacing
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TypewriterText(
                          text: 'Hi, I am Karthik',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 26, // Slightly smaller
                          ),
                        ),
                        const SizedBox(height: 8), // Reduced spacing
                        RainbowShimmerText(
                          text: 'Flutter Developer & Mobile App Creator',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18, // Slightly smaller
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              } else if (constraints.maxWidth < 1200) {
                // Tablet layout
                return Row(
                  children: [
                    ProfileIcon(),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TypewriterText(
                            text: 'Hi, I am Karthik',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 28, // Slightly smaller
                            ),
                          ),
                          const SizedBox(height: 8), // Reduced spacing
                          RainbowShimmerText(
                            text: 'Flutter Developer & Mobile App Creator',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20, // Slightly smaller
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                // Desktop layout
                return Row(
                  children: [
                    ProfileIcon(),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          TypewriterText(
                            text: 'Hi, I am Karthik',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30, // Slightly smaller
                            ),
                          ),
                          const SizedBox(height: 8), // Reduced spacing
                          RainbowShimmerText(
                            text: 'Flutter Developer & Mobile App Creator',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 22, // Slightly smaller
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),

          const SizedBox(height: 15), // Reduced spacing
          // Action Buttons
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth < 768) {
                // Mobile layout - centered buttons
                return Column(
                  children: [
                    _buildAnimatedButton('View CV', Icons.description, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfViews()),
                      );
                    }),
                    const SizedBox(height: 12), // Reduced spacing
                    _buildAnimatedButton('Hire Me', Icons.work, () async {
                      final url = Uri.parse('https://wa.me/917907831095');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }),
                  ],
                );
              } else if (constraints.maxWidth < 1200) {
                // Tablet layout - side by side buttons with center alignment
                return Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildAnimatedButton('View CV', Icons.description, () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => PdfViews()),
                        );
                      }),
                      const SizedBox(width: 12), // Reduced spacing
                      _buildAnimatedButton('Hire Me', Icons.work, () async {
                        final url = Uri.parse('https://wa.me/917907831095');
                        if (await canLaunchUrl(url)) {
                          await launchUrl(
                            url,
                            mode: LaunchMode.externalApplication,
                          );
                        }
                      }),
                    ],
                  ),
                );
              } else {
                // Desktop layout - side by side buttons
                return Row(
                  children: [
                    _buildAnimatedButton('View CV', Icons.description, () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PdfViews()),
                      );
                    }),
                    const SizedBox(width: 12), // Reduced spacing
                    _buildAnimatedButton('Hire Me', Icons.work, () async {
                      final url = Uri.parse('https://wa.me/917907831095');
                      if (await canLaunchUrl(url)) {
                        await launchUrl(
                          url,
                          mode: LaunchMode.externalApplication,
                        );
                      }
                    }),
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedButton(
    String text,
    IconData icon,
    VoidCallback onPressed,
  ) {
    return AnimatedBuilder(
      animation: _bounceController,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _bounceController.value * 2),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.white.withOpacity(0.1),
                  Colors.white.withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(25),
              border: Border.all(color: Colors.white.withOpacity(0.3)),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(25),
                onTap: onPressed,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: Colors.white, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildAboutSection() {
    return FadeTransition(
      opacity: _fadeController,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSectionTitle('About Me', Icons.person),
                const SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.white.withOpacity(0.2)),
                  ),
                  child: const MyDescription(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkillCard(Map<String, String> skill) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(skill['icon']!, width: 32, height: 32),
          ),
          const SizedBox(width: 12),
          Text(
            skill['name']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceSection() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ), // Reduced padding
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Work Experience', Icons.work),
              const SizedBox(height: 15), // Reduced spacing
              ...companies
                  .map((company) => _buildExperienceCard(company))
                  .toList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExperienceCard(Map<String, String> company) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15), // Reduced margin
      padding: const EdgeInsets.all(16), // Reduced padding
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12), // Smaller radius
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8, // Reduced blur
            offset: const Offset(0, 3), // Reduced offset
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50, // Smaller size
            height: 50, // Smaller size
            decoration: BoxDecoration(
              color: company['name']!.contains('Proaims')
                  ? Colors.white
                  : Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10), // Smaller radius
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Image.asset(
                company['logo']!,
                width: 35,
                height: 35,
              ), // Smaller image
            ),
          ),
          const SizedBox(width: 15), // Reduced spacing
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  company['name']!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18, // Slightly smaller
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4), // Reduced spacing
                Text(
                  company['position']!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 15, // Slightly smaller
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4), // Reduced spacing
                Text(
                  company['duration']!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 13, // Slightly smaller
                  ),
                ),
                const SizedBox(height: 8), // Reduced spacing
                Text(
                  company['description']!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 13, // Slightly smaller
                    height: 1.4, // Reduced line height
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectCard(Map<String, String> project) {
    return Container(
      height: 450, // Fixed height for all screen sizes
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.15),
            Colors.white.withOpacity(0.08),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Project Image Header
          Container(
            height: 140,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.purple.withOpacity(0.3),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
            ),
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Image.asset(project['image']!, width: 80, height: 80),
              ),
            ),
          ),

          // Project Info
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Project Type Badge
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.3),
                          Colors.blue.withOpacity(0.1),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.blue.withOpacity(0.3)),
                    ),
                    child: Text(
                      project['type']!,
                      style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Project Name
                  Text(
                    project['name']!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 10),

                  // Project Description
                  Expanded(
                    child: Text(
                      project['description']!,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.9),
                        fontSize: 15,
                        height: 1.5,
                      ),
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Project Links
                  Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: [
                      if (project['android_link'] != null)
                        _buildProjectLink(
                          'Android',
                          Icons.android,
                          project['android_link']!,
                        ),
                      if (project['ios_link'] != null)
                        _buildProjectLink(
                          'iOS',
                          Icons.apple,
                          project['ios_link']!,
                        ),
                      if (project['web_link'] != null)
                        _buildProjectLink(
                          'Web',
                          Icons.web,
                          project['web_link']!,
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectLink(String label, IconData icon, String url) {
    return InkWell(
      onTap: () async {
        final uri = Uri.parse(url);
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.2),
              Colors.white.withOpacity(0.1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(25),
          border: Border.all(color: Colors.white.withOpacity(0.3)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ), // Reduced padding
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Get In Touch', Icons.contact_mail),
              const SizedBox(height: 15), // Reduced spacing
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 700) {
                    // Mobile layout - wrap layout for better responsiveness
                    return Wrap(
                      spacing: 10, // Reduced spacing
                      runSpacing: 10, // Reduced spacing
                      alignment: WrapAlignment.center,
                      children: [
                        _buildContactCard(
                          'Email',
                          'karthiq.clt@gmail.com',
                          Icons.email,
                          () async {
                            final url = Uri.parse(
                              'mailto:karthiq.clt@gmail.com',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                        ),
                        _buildContactCard(
                          'GitHub',
                          'github.com/Kar44475',
                          Icons.code,
                          () async {
                            final url = Uri.parse(
                              'https://github.com/Kar44475/',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                        _buildContactCard(
                          'LinkedIn',
                          'linkedin.com/in/karthik-m-496444202',
                          Icons.work,
                          () async {
                            final url = Uri.parse(
                              'https://www.linkedin.com/in/karthik-m-496444202',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                        _buildContactCard(
                          'WhatsApp',
                          '+91 7907831095',
                          Icons.message,
                          () async {
                            final url = Uri.parse('https://wa.me/917907831095');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else if (constraints.maxWidth < 1200) {
                    // Tablet layout - wrap layout to prevent overflow
                    return Wrap(
                      spacing: 12, // Reduced spacing
                      runSpacing: 12, // Reduced spacing
                      alignment: WrapAlignment.center,
                      children: [
                        _buildContactCard(
                          'Email',
                          'karthiq.clt@gmail.com',
                          Icons.email,
                          () async {
                            final url = Uri.parse(
                              'mailto:karthiq.clt@gmail.com',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(url);
                            }
                          },
                        ),
                        _buildContactCard(
                          'GitHub',
                          'github.com/Kar44475',
                          Icons.code,
                          () async {
                            final url = Uri.parse(
                              'https://github.com/Kar44475/',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                        _buildContactCard(
                          'LinkedIn',
                          'linkedin.com/in/karthik-m-496444202',
                          Icons.work,
                          () async {
                            final url = Uri.parse(
                              'https://www.linkedin.com/in/karthik-m-496444202',
                            );
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                        _buildContactCard(
                          'WhatsApp',
                          '+91 7907831095',
                          Icons.message,
                          () async {
                            final url = Uri.parse('https://wa.me/917907831095');
                            if (await canLaunchUrl(url)) {
                              await launchUrl(
                                url,
                                mode: LaunchMode.externalApplication,
                              );
                            }
                          },
                        ),
                      ],
                    );
                  } else {
                    // Desktop layout - centered with max width
                    return Center(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 1000),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _buildContactCard(
                              'Email',
                              'karthiq.clt@gmail.com',
                              Icons.email,
                              () async {
                                final url = Uri.parse(
                                  'mailto:karthiq.clt@gmail.com',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                            ),
                            _buildContactCard(
                              'GitHub',
                              'github.com/Kar44475',
                              Icons.code,
                              () async {
                                final url = Uri.parse(
                                  'https://github.com/Kar44475/',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                            ),
                            _buildContactCard(
                              'LinkedIn',
                              'linkedin.com/in/karthik-m-496444202',
                              Icons.work,
                              () async {
                                final url = Uri.parse(
                                  'https://www.linkedin.com/in/karthik-m-496444202',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                            ),
                            _buildContactCard(
                              'WhatsApp',
                              '+91 7907831095',
                              Icons.message,
                              () async {
                                final url = Uri.parse(
                                  'https://wa.me/917907831095',
                                );
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(
                                    url,
                                    mode: LaunchMode.externalApplication,
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactCard(
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 130, // Slightly smaller
        padding: const EdgeInsets.all(12), // Reduced padding
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.1),
              Colors.white.withOpacity(0.05),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12), // Smaller radius
          border: Border.all(color: Colors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6, // Reduced blur
              offset: const Offset(0, 2), // Reduced offset
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(8), // Reduced padding
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8), // Smaller radius
              ),
              child: Icon(icon, color: Colors.white, size: 20), // Smaller icon
            ),
            const SizedBox(height: 6), // Reduced spacing
            Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 13, // Smaller font
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 2), // Reduced spacing
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.white.withOpacity(0.8),
                fontSize: 9, // Smaller font
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 15,
      ), // Reduced padding
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(15), // Reduced padding
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(12), // Smaller radius
                  border: Border.all(color: Colors.white.withOpacity(0.1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/Flutter.png',
                      width: 25,
                      height: 25,
                    ), // Smaller image
                    const SizedBox(width: 8), // Reduced spacing
                    const Text(
                      'Made with Flutter',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14, // Smaller font
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15), // Reduced spacing
              Text(
                '© 2024 Karthik. All rights reserved.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12, // Smaller font
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.1),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blue.withOpacity(0.3),
                  Colors.purple.withOpacity(0.3),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.white, size: 28),
          ),
          const SizedBox(width: 15),
          Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Skills & Technologies', Icons.code),
              const SizedBox(height: 15),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: skills.map((skill) {
                  return _buildSkillCard(skill);
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectsSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1400),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Featured Projects', Icons.rocket_launch),
              const SizedBox(height: 30),
              LayoutBuilder(
                builder: (context, constraints) {
                  if (constraints.maxWidth < 768) {
                    // Mobile layout - single column
                    return Column(
                      children: projects
                          .map(
                            (project) => Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              child: _buildProjectCard(project),
                            ),
                          )
                          .toList(),
                    );
                  } else if (constraints.maxWidth < 1200) {
                    // Tablet layout - 2 columns
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20,
                          ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return _buildProjectCard(projects[index]);
                      },
                    );
                  } else {
                    // Desktop layout - 3 columns
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 25,
                            mainAxisSpacing: 25,
                          ),
                      itemCount: projects.length,
                      itemBuilder: (context, index) {
                        return _buildProjectCard(projects[index]);
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
