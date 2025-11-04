// main.dart

// -----------------------------------------------------------------------------
// DOKUMENTASI & DEPENDENSI PENTING
// -----------------------------------------------------------------------------

/*
Aplikasi Flutter satu file: Personal Biodata / Portofolio Responsif.
Nama: Fahry Aditya Setiawaan
Pekerjaan: Photographer & Full Stack Developer

DEPENDENSI (Tambahkan ke pubspec.yaml):
- google_fonts: ^6.1.0 (Untuk font kustom)
- url_launcher: ^6.2.2 (Untuk membuka tautan)
- flutter_staggered_grid_view: ^0.7.0 (Untuk tata letak galeri, TIDAK DIGUNAKAN KARENA BATASAN SATU FILE)
- animations: ^2.0.8 (Untuk transisi halus)

CATATAN: Logika fallback sudah diimplementasikan jika paket opsional tidak ditambahkan.
*/

import 'dart:math' as math;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

// Penanda ketersediaan paket (asumsi dengan fallback)
const bool _hasUrlLauncher = true; 
const bool _hasAnimations = true; 

// -----------------------------------------------------------------------------
// WIDGET UTAMA APLIKASI
// -----------------------------------------------------------------------------

void main() {
  runApp(const MyApp());
}

/// Widget utama yang menangani MaterialApp dan pengaturan tema.
class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode _themeMode = ThemeMode.light;

  /// Mengganti tema antara Light dan Dark.
  void _toggleTheme(bool isDark) {
    setState(() {
      _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata — Fahry Aditya Setiawaan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        colorSchemeSeed: AppData.primaryColor,
        useMaterial3: true,
        fontFamily: 'Roboto', // Fallback font
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorSchemeSeed: AppData.primaryColor,
        useMaterial3: true,
        fontFamily: 'Roboto', // Fallback font
      ),
      themeMode: _themeMode,
      home: MainScreen(
        onThemeToggle: _toggleTheme,
        currentThemeMode: _themeMode,
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MODEL DATA APLIKASI (Area untuk mengubah data user)
// -----------------------------------------------------------------------------

/// Data statis untuk seluruh aplikasi.
class AppData {
  static const Color primaryColor = Colors.teal;

  // --- Informasi User ---
  static const String name = 'Fahry Aditya Setiawaan';
  static const String jobTitle = 'Photographer & Full Stack Developer';
  static const String tiktokHandle = '@cloverotaku';

  // --- About Me ---
  static const String bioParagraph =
      'Halo! Saya Fahry, seorang profesional yang bersemangat dalam dunia Full Stack Development '
      'dan Fotografi. Saya percaya bahwa perpaduan antara logika pemrograman yang terstruktur '
      'dan kepekaan visual fotografi dapat menghasilkan solusi digital yang tidak hanya fungsional '
      'tetapi juga estetis. Saya selalu mencari tantangan baru untuk mengasah kemampuan teknis '
      'serta kreativitas saya. Mari kita wujudkan ide Anda!';

  // --- Detail Biodata ---
  static const Map<String, String> biodataDetails = {
    'Tempat/Tgl Lahir': 'Jakarta, 17 Agustus 1998',
    'Hobi': 'Coding, Fotografi, Anime',
    'Bahasa': 'Indonesia, Inggris, Jepang (dasar)',
    'Email': 'fahry.aditya.dev@example.com',
    'Telepon': '+62 812-3456-7890',
  };

  // --- Data Education ---
  static final List<Education> educationList = [
    Education(
      institution: 'Universitas Teknologi Jakarta (UTJ)',
      degree: 'S.Kom. - Teknik Informatika',
      year: '2016 - 2020',
      description: 'Lulus dengan predikat Cum Laude. Fokus pada Pengembangan Aplikasi Mobile dan AI.',
    ),
    Education(
      institution: 'SMA Negeri 1 Jakarta',
      degree: 'IPA',
      year: '2013 - 2016',
      description: 'Juara 1 Lomba Sains Tingkat Provinsi. Aktif di klub fotografi.',
    ),
    Education(
      institution: 'SMP Negeri 1 Jakarta',
      degree: 'Lulusan Terbaik',
      year: '2010 - 2013',
      description: 'Mengikuti Olimpiade Matematika dan meraih medali perunggu.',
    ),
  ];

  // --- Data Skills ---
  static final List<Skill> skillList = [
    Skill(name: 'Flutter & Dart', level: 0.95),
    Skill(name: 'React & Vue.js', level: 0.85),
    Skill(name: 'Node.js & Express', level: 0.90),
    Skill(name: 'SQL & NoSQL', level: 0.80),
    Skill(name: 'Adobe Lightroom & PS', level: 0.92),
    Skill(name: 'Komposisi Fotografi', level: 0.88),
    Skill(name: 'Manajemen Proyek', level: 0.75),
    Skill(name: 'Komunikasi Publik', level: 0.82),
  ];

  // --- Data Projects ---
  static final List<Project> projectList = [
    Project(
      title: 'E-Commerce Mobile App',
      description: 'Aplikasi belanja online berbasis Flutter dengan integrasi REST API.',
      tags: ['Flutter', 'Dart', 'API', 'UI/UX'],
      imageUrl: 'https://picsum.photos/id/10/300/200',
      isPhotography: false,
    ),
    Project(
      title: 'Portfolio Website V2',
      description: 'Website portofolio pribadi yang responsif menggunakan React dan Tailwind CSS.',
      tags: ['React', 'Web', 'Responsive', 'Tailwind'],
      imageUrl: 'https://picsum.photos/id/15/300/200',
      isPhotography: false,
    ),
    Project(
      title: 'Urban Street Photography',
      description: 'Koleksi foto jalanan perkotaan dengan fokus pada human interest dan momen candid.',
      tags: ['Fotografi', 'Street', 'Lightroom', 'Human Interest'],
      imageUrl: 'https://picsum.photos/id/1018/300/200',
      isPhotography: true,
    ),
    Project(
      title: 'Backend Service Microservices',
      description: 'Implementasi microservices untuk autentikasi dan pembayaran menggunakan Node.js dan RabbitMQ.',
      tags: ['Node.js', 'Microservices', 'MongoDB', 'API'],
      imageUrl: 'https://picsum.photos/id/20/300/200',
      isPhotography: false,
    ),
  ];

  // --- Data Gallery ---
  static final List<String> galleryUrls = List.generate(
    20,
    (index) => 'https://picsum.photos/id/${100 + index * 5}/'
        '${(300 + math.Random().nextInt(200))}'
        '/'
        '${(300 + math.Random().nextInt(200))}',
  );

  // --- Data Sosial Media ---
  static final List<SocialLink> socialLinks = [
    SocialLink(
      icon: Icons.tiktok,
      label: 'TikTok: ${AppData.tiktokHandle}',
      url: 'https://www.tiktok.com/${AppData.tiktokHandle}',
    ),
    SocialLink(
      icon: Icons.photo_camera,
      label: 'Instagram: /fahry_photo',
      url: 'https://www.instagram.com/fahry_photo',
    ),
    SocialLink(
      icon: Icons.code,
      label: 'GitHub: /fahrydev',
      url: 'https://github.com/fahrydev',
    ),
    SocialLink(
      icon: Icons.work,
      label: 'LinkedIn: /in/fahryaditya',
      url: 'https://www.linkedin.com/in/fahryaditya',
    ),
  ];
}

class Education {
  final String institution;
  final String degree;
  final String year;
  final String description;

  Education({
    required this.institution,
    required this.degree,
    required this.year,
    required this.description,
  });
}

class Skill {
  final String name;
  final double level; // 0.0 sampai 1.0

  Skill({
    required this.name,
    required this.level,
  });
}

class Project {
  final String title;
  final String description;
  final List<String> tags;
  final String imageUrl;
  final bool isPhotography;

  Project({
    required this.title,
    required this.description,
    required this.tags,
    required this.imageUrl,
    required this.isPhotography,
  });
}

class SocialLink {
  final IconData icon;
  final String label;
  final String url;

  SocialLink({
    required this.icon,
    required this.label,
    required this.url,
  });
}

// -----------------------------------------------------------------------------
// FUNGSI HELPER
// -----------------------------------------------------------------------------

enum Section {
  home,
  about,
  education,
  skills,
  projects,
  gallery,
  contact,
}

extension SectionExtension on Section {
  String get label {
    switch (this) {
      case Section.home:
        return 'Home';
      case Section.about:
        return 'About';
      case Section.education:
        return 'Education';
      case Section.skills:
        return 'Skills';
      case Section.projects:
        return 'Projects';
      case Section.gallery:
        return 'Gallery';
      case Section.contact:
        return 'Contact';
    }
  }
}

class UrlLauncherHelper {
  static Future<void> launchInBrowser(BuildContext context, String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        // Fallback SnackBar jika gagal diluncurkan
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Tidak dapat membuka tautan: $urlString'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  static Future<void> sendEmail(BuildContext context, String recipient, String subject) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: recipient,
      query: 'subject=$subject',
    );
    await launchInBrowser(context, emailLaunchUri.toString());
  }
}

// -----------------------------------------------------------------------------
// LAYOUT UTAMA: MAIN SCREEN & SCROLL LOGIC
// -----------------------------------------------------------------------------

/// Screen utama yang menampung semua bagian dan logika navigasi.
class MainScreen extends StatefulWidget {
  final Function(bool) onThemeToggle;
  final ThemeMode currentThemeMode;

  const MainScreen({
    super.key,
    required this.onThemeToggle,
    required this.currentThemeMode,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  // GlobalKey untuk setiap bagian agar dapat digulir ke sana (Anchor Navigation).
  final Map<Section, GlobalKey> _sectionKeys = {
    for (var section in Section.values) section: GlobalKey(),
  };

  final ScrollController _scrollController = ScrollController();
  Section _currentActiveSection = Section.home;

  double _getSectionOffset(Section section) {
    final RenderBox? renderBox =
        _sectionKeys[section]?.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return 0.0;
    return renderBox.localToGlobal(Offset.zero).dy + _scrollController.offset;
  }

  /// Menggulir ke bagian yang dipilih dengan animasi halus.
  void _scrollToSection(Section section) {
    final double offset = _getSectionOffset(section);
    _scrollController.animateTo(
      offset - (kToolbarHeight + 16.0), // Kompensasi AppBar
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOutCubic,
    );
    setState(() {
      _currentActiveSection = section;
    });
  }

  /// Listener guliran untuk mendeteksi bagian mana yang sedang aktif.
  void _scrollListener() {
    final scrollOffset = _scrollController.offset + kToolbarHeight * 1.5;
    Section? newActiveSection;

    // Iterasi mundur untuk prioritas bagian bawah
    for (var section in Section.values.reversed) {
      final offset = _getSectionOffset(section);
      if (scrollOffset >= offset) {
        newActiveSection = section;
        break;
      }
    }

    if (newActiveSection != null && newActiveSection != _currentActiveSection) {
      setState(() {
        _currentActiveSection = newActiveSection!;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLargeScreen = MediaQuery.of(context).size.width > 900;

    return Scaffold(
      appBar: ResponsiveAppBar(
        onSectionTap: _scrollToSection,
        currentActiveSection: _currentActiveSection,
        isLargeScreen: isLargeScreen,
        onThemeToggle: widget.onThemeToggle,
        currentThemeMode: widget.currentThemeMode,
      ),
      // Drawer hanya untuk layar sempit
      drawer: isLargeScreen
          ? null
          : AppDrawer(
              onSectionTap: (section) {
                _scrollToSection(section);
                Navigator.of(context).pop();
              },
              currentActiveSection: _currentActiveSection,
              onThemeToggle: widget.onThemeToggle,
              currentThemeMode: widget.currentThemeMode,
            ),
      body: Scrollbar(
        controller: _scrollController,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              // Home Section
              SectionWrapper(
                key: _sectionKeys[Section.home],
                title: Section.home.label,
                child: HeroSection(isLargeScreen: isLargeScreen),
              ),
              // About Me Section
              SectionWrapper(
                key: _sectionKeys[Section.about],
                title: Section.about.label,
                child: AboutSection(isLargeScreen: isLargeScreen),
              ),
              // Education Section
              SectionWrapper(
                key: _sectionKeys[Section.education],
                title: Section.education.label,
                child: EducationSection(isLargeScreen: isLargeScreen),
              ),
              // Skills / Experience Section
              SectionWrapper(
                key: _sectionKeys[Section.skills],
                title: Section.skills.label,
                child: SkillSection(scrollController: _scrollController),
              ),
              // Projects / Portfolio Section
              SectionWrapper(
                key: _sectionKeys[Section.projects],
                title: Section.projects.label,
                child: ProjectsSection(isLargeScreen: isLargeScreen),
              ),
              // Gallery / Hobby Section
              SectionWrapper(
                key: _sectionKeys[Section.gallery],
                title: Section.gallery.label,
                child: GallerySection(isLargeScreen: isLargeScreen),
              ),
              // Contact Section
              SectionWrapper(
                key: _sectionKeys[Section.contact],
                title: Section.contact.label,
                child: ContactSection(isLargeScreen: isLargeScreen),
              ),
              // Footer
              const AppFooter(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeInOut,
          );
        },
        tooltip: 'Scroll to Top',
        child: const Icon(Icons.arrow_upward),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET NAVIGASI
// -----------------------------------------------------------------------------

/// AppBar yang responsif.
class ResponsiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(Section) onSectionTap;
  final Section currentActiveSection;
  final bool isLargeScreen;
  final Function(bool) onThemeToggle;
  final ThemeMode currentThemeMode;

  const ResponsiveAppBar({
    super.key,
    required this.onSectionTap,
    required this.currentActiveSection,
    required this.isLargeScreen,
    required this.onThemeToggle,
    required this.currentThemeMode,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        '${AppData.name.split(' ')[0]} Portfolio',
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
      ),
      actions: [
        if (isLargeScreen)
          // Navigasi Baris untuk layar lebar
          ...Section.values.map((section) {
            return NavItem(
              section: section,
              onTap: () => onSectionTap(section),
              isActive: currentActiveSection == section,
            );
          }).toList(),
        // Tombol Download CV
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: isLargeScreen ? 16.0 : 8.0, vertical: 8.0),
          child: ElevatedButton.icon(
            onPressed: () => _handleDownloadCV(context),
            icon: const Icon(Icons.download),
            label: isLargeScreen ? const Text('Download CV') : const Text('CV'),
            style: ElevatedButton.styleFrom(
              padding: isLargeScreen
                  ? const EdgeInsets.symmetric(horizontal: 16, vertical: 8)
                  : const EdgeInsets.all(8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ),
        ),
        // Tombol Toggle Tema
        IconButton(
          onPressed: () =>
              onThemeToggle(currentThemeMode == ThemeMode.light),
          icon: Icon(currentThemeMode == ThemeMode.light
              ? Icons.dark_mode
              : Icons.light_mode),
          tooltip: 'Toggle Theme',
        ),
        if (!isLargeScreen)
          // Tombol Drawer untuk layar kecil
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
              tooltip: 'Open Navigation Menu',
            ),
          ),
      ],
      automaticallyImplyLeading: !isLargeScreen,
    );
  }

  void _handleDownloadCV(BuildContext context) {
    const String cvUrl = 'https://example.com/fahry_aditya_cv.pdf';
    if (_hasUrlLauncher) {
      UrlLauncherHelper.launchInBrowser(context, cvUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Simulasi: CV akan diunduh dari $cvUrl.'),
        ),
      );
    }
  }
}

class NavItem extends StatelessWidget {
  final Section section;
  final VoidCallback onTap;
  final bool isActive;

  const NavItem({
    super.key,
    required this.section,
    required this.onTap,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onTap,
      child: Text(
        section.label,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              color: isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).textTheme.bodyLarge?.color,
            ),
      ),
    );
  }
}

/// Drawer untuk navigasi di layar kecil.
class AppDrawer extends StatelessWidget {
  final Function(Section) onSectionTap;
  final Section currentActiveSection;
  final Function(bool) onThemeToggle;
  final ThemeMode currentThemeMode;

  const AppDrawer({
    super.key,
    required this.onSectionTap,
    required this.currentActiveSection,
    required this.onThemeToggle,
    required this.currentThemeMode,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Theme.of(context).colorScheme.onPrimary,
                  child: Text(
                    AppData.name.split(' ').map((e) => e[0]).join(),
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  AppData.name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer),
                ),
                Text(
                  AppData.jobTitle,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onPrimaryContainer
                          .withOpacity(0.8)),
                ),
              ],
            ),
          ),
          ...Section.values.map((section) {
            return ListTile(
              leading: Icon(_getSectionIcon(section)),
              title: Text(section.label),
              selected: currentActiveSection == section,
              onTap: () => onSectionTap(section),
            );
          }).toList(),
          const Divider(),
          ListTile(
            leading: Icon(currentThemeMode == ThemeMode.light
                ? Icons.dark_mode
                : Icons.light_mode),
            title: Text(
                'Theme: ${currentThemeMode == ThemeMode.light ? 'Light' : 'Dark'}'),
            trailing: Switch(
              value: currentThemeMode == ThemeMode.dark,
              onChanged: onThemeToggle,
            ),
            onTap: () =>
                onThemeToggle(currentThemeMode == ThemeMode.light),
          ),
          ListTile(
            leading: const Icon(Icons.download),
            title: const Text('Download CV'),
            onTap: () {
              Navigator.of(context).pop();
              _handleDownloadCV(context);
            },
          ),
        ],
      ),
    );
  }

  IconData _getSectionIcon(Section section) {
    switch (section) {
      case Section.home:
        return Icons.home;
      case Section.about:
        return Icons.person;
      case Section.education:
        return Icons.school;
      case Section.skills:
        return Icons.star;
      case Section.projects:
        return Icons.work;
      case Section.gallery:
        return Icons.photo_library;
      case Section.contact:
        return Icons.mail;
    }
  }

  void _handleDownloadCV(BuildContext context) {
    const String cvUrl = 'https://example.com/fahry_aditya_cv.pdf';
    if (_hasUrlLauncher) {
      UrlLauncherHelper.launchInBrowser(context, cvUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Simulasi: CV akan diunduh dari $cvUrl.'),
        ),
      );
    }
  }
}

// -----------------------------------------------------------------------------
// WIDGET STRUKTUR UMUM
// -----------------------------------------------------------------------------

/// Wrapper umum untuk setiap bagian utama aplikasi.
class SectionWrapper extends StatelessWidget {
  final Widget child;
  final String title;

  const SectionWrapper({
    super.key,
    required this.child,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1200),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (title != 'Home')
                SectionTitle(
                  title: title,
                ),
              const SizedBox(height: 24),
              child,
            ],
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;

  const SectionTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.w900,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 80,
          height: 4,
          color: Theme.of(context).colorScheme.primary,
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET: HERO SECTION (HOME)
// -----------------------------------------------------------------------------

/// Bagian pengantar/utama aplikasi.
class HeroSection extends StatefulWidget {
  final bool isLargeScreen;

  const HeroSection({super.key, required this.isLargeScreen});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection> {
  // Animasi entrance: opacity dan posisi Y
  double _opacity = 0.0;
  double _translateY = 50.0;

  @override
  void initState() {
    super.initState();
    // Animasi singkat setelah widget di-build
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
        _translateY = 0.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final content = [
      // Kolom Teks & CTA
      Flexible(
        child: AnimatedOpacity(
          opacity: _opacity,
          duration: const Duration(milliseconds: 800),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 800),
            transform: Matrix4.translationValues(0, _translateY, 0),
            child: Column(
              crossAxisAlignment: widget.isLargeScreen
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
              children: [
                Text(
                  'Halo, Saya',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  AppData.name,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                  textAlign: widget.isLargeScreen
                      ? TextAlign.start
                      : TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  AppData.jobTitle,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                  textAlign: widget.isLargeScreen
                      ? TextAlign.start
                      : TextAlign.center,
                ),
                const SizedBox(height: 24),
                // Tombol CTA
                Wrap(
                  spacing: 16.0,
                  runSpacing: 16.0,
                  alignment: widget.isLargeScreen
                      ? WrapAlignment.start
                      : WrapAlignment.center,
                  children: [
                    // Tombol Download CV
                    ElevatedButton.icon(
                      onPressed: () => _handleDownloadCV(context),
                      icon: const Icon(Icons.download),
                      label: const Text('Download CV'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.primary,
                        foregroundColor:
                            Theme.of(context).colorScheme.onPrimary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    // Tombol Contact
                    OutlinedButton.icon(
                      onPressed: () => _handleContact(context),
                      icon: const Icon(Icons.mail_outline),
                      label: const Text('Contact Me'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Theme.of(context).colorScheme.primary,
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.primary),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 16),
                        textStyle: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      // Kolom Foto Profil
      SizedBox(width: widget.isLargeScreen ? 48 : 0, height: 48),
      AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 800),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 800),
          transform: Matrix4.translationValues(0, _translateY, 0),
          child: ProfilePicture(
            imageUrl: 'https://picsum.photos/id/1005/500/500', 
            initials: AppData.name.split(' ').map((e) => e[0]).join(),
            size: widget.isLargeScreen ? 300 : 200,
          ),
        ),
      ),
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: widget.isLargeScreen ? 96.0 : 48.0),
      child: widget.isLargeScreen
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: content,
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: content.reversed.toList(), // Balik urutan untuk mobile
            ),
    );
  }

  void _handleDownloadCV(BuildContext context) {
    const String cvUrl = 'https://example.com/fahry_aditya_cv.pdf';
    if (_hasUrlLauncher) {
      UrlLauncherHelper.launchInBrowser(context, cvUrl);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Simulasi: CV akan diunduh dari $cvUrl.'),
        ),
      );
    }
  }

  void _handleContact(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Gulir ke bagian Contact...'),
      ),
    );
  }
}

/// Widget untuk menampilkan foto profil lingkaran.
class ProfilePicture extends StatelessWidget {
  final String imageUrl;
  final String initials;
  final double size;

  const ProfilePicture({
    super.key,
    required this.imageUrl,
    required this.initials,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            // Fallback: inisial jika gambar gagal dimuat
            return Container(
              color: Theme.of(context).colorScheme.secondaryContainer,
              child: Center(
                child: Text(
                  initials,
                  style: TextStyle(
                    fontSize: size / 3,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET: ABOUT ME SECTION
// -----------------------------------------------------------------------------

/// Bagian "Tentang Saya" (About Me)
class AboutSection extends StatelessWidget {
  final bool isLargeScreen;

  const AboutSection({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      Flexible(
        child: Text(
          AppData.bioParagraph,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.6),
        ),
      ),
      SizedBox(height: 32, width: isLargeScreen ? 64 : 0),
      Flexible(
        child: BiodataTable(details: AppData.biodataDetails),
      ),
    ];

    return isLargeScreen
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content,
          );
  }
}

/// Widget tabel untuk menampilkan detail biodata.
class BiodataTable extends StatelessWidget {
  final Map<String, String> details;

  const BiodataTable({super.key, required this.details});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: details.entries.map((entry) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 120, // Lebar label tetap
                child: Text(
                  '${entry.key}:',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  entry.value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET: EDUCATION SECTION
// -----------------------------------------------------------------------------

/// Bagian Pendidikan (Education)
class EducationSection extends StatelessWidget {
  final bool isLargeScreen;

  const EducationSection({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(), 
      itemCount: AppData.educationList.length,
      itemBuilder: (context, index) {
        final education = AppData.educationList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 24.0),
          child: EducationCard(
            education: education,
            isLargeScreen: isLargeScreen,
          ),
        );
      },
    );
  }
}

class EducationCard extends StatelessWidget {
  final Education education;
  final bool isLargeScreen;

  const EducationCard({
    super.key,
    required this.education,
    required this.isLargeScreen,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              education.year,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                    fontStyle: FontStyle.italic,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              education.institution,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            Text(
              education.degree,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Text(
              education.description,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET: SKILLS SECTION
// -----------------------------------------------------------------------------

/// Bagian Keahlian (Skills) dengan animasi pemicu guliran.
class SkillSection extends StatelessWidget {
  final ScrollController scrollController;

  const SkillSection({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: MediaQuery.of(context).size.width > 600 ? 2 : 1,
        childAspectRatio: 5,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 32.0,
      ),
      itemCount: AppData.skillList.length,
      itemBuilder: (context, index) {
        final skill = AppData.skillList[index];
        // Menggunakan SkillProgressIndicator yang memicu animasi saat terlihat
        return SkillProgressIndicator(
          skill: skill,
          scrollController: scrollController,
        );
      },
    );
  }
}

/// Widget progress bar yang dianimasikan saat terlihat di layar.
class SkillProgressIndicator extends StatefulWidget {
  final Skill skill;
  final ScrollController scrollController;

  const SkillProgressIndicator({
    super.key,
    required this.skill,
    required this.scrollController,
  });

  @override
  State<SkillProgressIndicator> createState() => _SkillProgressIndicatorState();
}

class _SkillProgressIndicatorState extends State<SkillProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isVisible = false;
  final GlobalKey _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation =
        Tween<double>(begin: 0.0, end: widget.skill.level).animate(_controller);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.scrollController.addListener(_checkVisibility);
    });
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_checkVisibility);
    _controller.dispose();
    super.dispose();
  }

  /// Memeriksa apakah widget berada dalam batas viewport.
  void _checkVisibility() {
    if (_isVisible) return;

    final RenderBox? renderBox =
        _key.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final position = renderBox.localToGlobal(Offset.zero);
    final size = MediaQuery.of(context).size;

    // Deteksi visibilitas
    if (position.dy < size.height - 100 && position.dy > 0) {
      if (!_isVisible) {
        setState(() {
          _isVisible = true;
          _controller.forward();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _checkVisibility();

    return Column(
      key: _key,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.skill.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Text(
                  '${(_animation.value * 100).toInt()}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: 8),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return LinearProgressIndicator(
              value: _animation.value,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              color: Theme.of(context).colorScheme.primary,
              minHeight: 10,
              borderRadius: BorderRadius.circular(5),
            );
          },
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET: PROJECTS SECTION
// -----------------------------------------------------------------------------

/// Bagian Proyek/Portofolio.
class ProjectsSection extends StatelessWidget {
  final bool isLargeScreen;

  const ProjectsSection({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    // Tata letak Grid responsif
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 3 : 1,
        childAspectRatio: 1.0, 
        mainAxisSpacing: 24.0,
        crossAxisSpacing: 24.0,
      ),
      itemCount: AppData.projectList.length,
      itemBuilder: (context, index) {
        final project = AppData.projectList[index];
        return ProjectCard(project: project);
      },
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Project project;

  const ProjectCard({super.key, required this.project});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      clipBehavior: ClipAntiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar Proyek
          Expanded(
            flex: 2,
            child: ImagePlaceholder(
              imageUrl: project.imageUrl,
              initials: project.title.substring(0, 1),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          // Konten Teks
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    project.description,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  // Tag/Chip
                  Wrap(
                    spacing: 6.0,
                    runSpacing: 6.0,
                    children: project.tags.map((tag) => Chip(label: Text(tag))).toList(),
                  ),
                  const Spacer(),
                  // Tombol Aksi
                  Align(
                    alignment: Alignment.bottomRight,
                    child: TextButton.icon(
                      onPressed: () => _showProjectDetail(context, project),
                      icon: const Icon(Icons.visibility),
                      label: const Text('View Detail'),
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

  /// Menampilkan modal/dialog detail proyek.
  void _showProjectDetail(BuildContext context, Project project) {
    final Widget dialog = SimpleDialog(
      title: Text(project.title),
      contentPadding: const EdgeInsets.all(24),
      children: [
        ImagePlaceholder(
          imageUrl: project.imageUrl,
          initials: project.title.substring(0, 1),
          fit: BoxFit.contain,
          height: 200,
          width: double.infinity,
        ),
        const SizedBox(height: 16),
        Text(
          project.description,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 6.0,
          runSpacing: 6.0,
          children: project.tags.map((tag) => Chip(label: Text(tag))).toList(),
        ),
        const SizedBox(height: 16),
        Align(
          alignment: Alignment.bottomRight,
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Close'),
          ),
        ),
      ],
    );

    if (_hasAnimations) {
      showGeneralDialog(
        context: context,
        pageBuilder: (context, a1, a2) {
          return dialog;
        },
        transitionBuilder: (context, a1, a2, child) {
          // Simulasi SharedAxisTransition
          return FadeTransition(
            opacity: a1,
            child: ScaleTransition(
              scale: a1,
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      );
    } else {
      showDialog(context: context, builder: (context) => dialog);
    }
  }
}

// -----------------------------------------------------------------------------
// WIDGET: GALLERY SECTION
// -----------------------------------------------------------------------------

/// Bagian Galeri/Hobi.
class GallerySection extends StatelessWidget {
  final bool isLargeScreen;

  const GallerySection({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isLargeScreen ? 4 : 2,
        mainAxisSpacing: 16.0,
        crossAxisSpacing: 16.0,
        childAspectRatio: 1.0,
      ),
      itemCount: AppData.galleryUrls.length,
      itemBuilder: (context, index) {
        final url = AppData.galleryUrls[index];
        return GalleryItem(
          imageUrl: url,
          index: index,
          initials: 'FA',
        );
      },
    );
  }
}

class GalleryItem extends StatelessWidget {
  final String imageUrl;
  final int index;
  final String initials;

  const GalleryItem({
    super.key,
    required this.imageUrl,
    required this.index,
    required this.initials,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _showFullGallery(context, index),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: Hero(
          tag: 'gallery_item_$index',
          child: ImagePlaceholder(
            imageUrl: imageUrl,
            initials: initials,
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
        ),
      ),
    );
  }

  void _showFullGallery(BuildContext context, int initialIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => FullScreenGalleryViewer(
          initialIndex: initialIndex,
          imageUrls: AppData.galleryUrls,
        ),
      ),
    );
  }
}

/// Viewer Galeri Layar Penuh dengan swipe.
class FullScreenGalleryViewer extends StatefulWidget {
  final int initialIndex;
  final List<String> imageUrls;

  const FullScreenGalleryViewer({
    super.key,
    required this.initialIndex,
    required this.imageUrls,
  });

  @override
  State<FullScreenGalleryViewer> createState() => _FullScreenGalleryViewerState();
}

class _FullScreenGalleryViewerState extends State<FullScreenGalleryViewer> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        elevation: 0,
        title: Text('${_currentIndex + 1} / ${widget.imageUrls.length}',
            style: const TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: widget.imageUrls.length,
        onPageChanged: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        itemBuilder: (context, index) {
          final imageUrl = widget.imageUrls[index];
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Hero(
                tag: 'gallery_item_$index',
                child: ImagePlaceholder(
                  imageUrl: imageUrl,
                  initials: 'FA',
                  fit: BoxFit.contain,
                  key: ValueKey('full_image_$index'),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET: CONTACT SECTION
// -----------------------------------------------------------------------------

/// Bagian Kontak (Contact) dengan formulir dan tautan sosial.
class ContactSection extends StatelessWidget {
  final bool isLargeScreen;

  const ContactSection({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    final content = <Widget>[
      Flexible(
        child: ContactForm(isLargeScreen: isLargeScreen),
      ),
      SizedBox(height: 48, width: isLargeScreen ? 64 : 0),
      Flexible(
        child: SocialLinksWidget(isLargeScreen: isLargeScreen),
      ),
    ];

    return isLargeScreen
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content,
          )
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: content,
          );
  }
}

/// Widget Form Kontak.
class ContactForm extends StatefulWidget {
  final bool isLargeScreen;

  const ContactForm({super.key, required this.isLargeScreen});

  @override
  State<ContactForm> createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _message = '';

  /// Handler pengiriman formulir.
  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final String subject =
          'Pesan dari $_name (Portfolio)';
      final String body = 'Nama: $_name\nEmail: $_email\n\nPesan:\n$_message';
      final String emailUrl =
          'mailto:${AppData.biodataDetails['Email']}?subject=${Uri.encodeComponent(subject)}&body=${Uri.encodeComponent(body)}';

      if (_hasUrlLauncher) {
        await UrlLauncherHelper.launchInBrowser(context, emailUrl);
      } else {
        // Fallback: Tunjukkan SnackBar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Simulasi kirim pesan:\nEmail: $_email\nSubject: $subject'),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
        );
      }
      _formKey.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            validator: (value) =>
                value == null || value.isEmpty ? 'Nama tidak boleh kosong.' : null,
            onSaved: (value) => _name = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Alamat Email',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Email tidak boleh kosong.';
              } else if (!value.contains('@') || !value.contains('.')) {
                return 'Email tidak valid.';
              }
              return null;
            },
            onSaved: (value) => _email = value!,
          ),
          const SizedBox(height: 16),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Pesan Anda',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.message),
              alignLabelWithHint: true,
            ),
            maxLines: 5,
            validator: (value) =>
                value == null || value.isEmpty ? 'Pesan tidak boleh kosong.' : null,
            onSaved: (value) => _message = value!,
          ),
          const SizedBox(height: 24),
          // Tombol Kirim
          SizedBox(
            width: widget.isLargeScreen ? 200 : double.infinity,
            child: ElevatedButton.icon(
              onPressed: _submitForm,
              icon: const Icon(Icons.send),
              label: const Text('Kirim Pesan'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Theme.of(context).colorScheme.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 16),
                textStyle: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Widget Tautan Sosial Media.
class SocialLinksWidget extends StatelessWidget {
  final bool isLargeScreen;

  const SocialLinksWidget({super.key, required this.isLargeScreen});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hubungi Saya',
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        const SizedBox(height: 16),
        ...AppData.socialLinks.map((link) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(
                link.icon,
                color: Theme.of(context).colorScheme.primary,
                size: 32,
              ),
              title: Text(
                link.label,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                link.url,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).textTheme.bodySmall?.color,
                    ),
              ),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => _handleLaunch(context, link.url),
            ),
          );
        }).toList(),
      ],
    );
  }

  void _handleLaunch(BuildContext context, String url) {
    if (_hasUrlLauncher) {
      UrlLauncherHelper.launchInBrowser(context, url);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Simulasi: Akan membuka tautan $url'),
        ),
      );
    }
  }
}

// -----------------------------------------------------------------------------
// WIDGET: FOOTER
// -----------------------------------------------------------------------------

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Center(
        child: Column(
          children: [
            // Kutipan
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                '"Estetika bertemu Fungsi. Itu adalah Kode yang Baik."',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontStyle: FontStyle.italic,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            // Copyright
            Text(
              '© ${DateTime.now().year} ${AppData.name}. All Rights Reserved.',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// WIDGET UTILITAS
// -----------------------------------------------------------------------------

/// Widget generik untuk menampilkan gambar jaringan dengan placeholder/fallback.
class ImagePlaceholder extends StatelessWidget {
  final String imageUrl;
  final String initials;
  final BoxFit fit;
  final double? height;
  final double? width;

  const ImagePlaceholder({
    super.key,
    required this.imageUrl,
    required this.initials,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Container(
          height: height,
          width: width,
          color: Theme.of(context).colorScheme.surfaceContainerHighest,
          child: Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      (loadingProgress.expectedTotalBytes ?? 1)
                  : null,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        );
      },
      errorBuilder: (context, error, stackTrace) {
        // Fallback: Placeholder dengan inisial
        return Container(
          height: height,
          width: width,
          color: Theme.of(context).colorScheme.errorContainer,
          child: Center(
            child: Text(
              initials,
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
            ),
          ),
        );
      },
    );
  }
}

// LINES: 1896
