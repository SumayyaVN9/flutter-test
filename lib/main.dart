import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/plans_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/search_screen.dart';

void main() {
  runApp(const EsimApp());
}

final localeNotifier = ValueNotifier<Locale>(const Locale('en', ''));

class EsimApp extends StatelessWidget {
  const EsimApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Locale>(
      valueListenable: localeNotifier,
      builder: (context, locale, _) {
        return MaterialApp(
          builder: (context, child) {
            final double width = MediaQuery.of(context).size.width;
            if (width <= 600) return child!;
            return Material(
              color: const Color(
                  0xFFE5E5E7), // Slightly darker background for the web
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F7),
                      borderRadius: BorderRadius.circular(
                          24), // Highly rounded like modern phones
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 40,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: child!,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          onGenerateTitle: (context) => AppLocalizations.of(context)!.appTitle,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),
            Locale('ar', ''),
          ],
          locale: locale,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            fontFamily: 'Inter',
            scaffoldBackgroundColor: const Color(0xFFF5F5F7),
            colorScheme:
                ColorScheme.fromSeed(seedColor: const Color(0xFF502CF3)),
            useMaterial3: true,
          ),
          home: const SplashScreen(),
          routes: {
            '/home': (context) => const MainNavigation(),
            '/plans': (context) => const PlansScreen(),
            '/search': (context) => const SearchScreen(),
          },
        );
      },
    );
  }
}

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    PlansScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 6, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              constraints: const BoxConstraints(maxWidth: 280),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.96),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.white),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _navItem(0, Icons.home_outlined, Icons.home,
                      AppLocalizations.of(context)!.home),
                  _navItem(1, Icons.sim_card_outlined, Icons.sim_card,
                      AppLocalizations.of(context)!.myPlans),
                  _navItem(2, Icons.person_outline, Icons.person,
                      AppLocalizations.of(context)!.profile),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navItem(
    int index,
    IconData icon,
    IconData selectedIcon,
    String label,
  ) {
    final bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedIndex = index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFE9E9EC) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected
                  ? const Color(0xFF4E4EDD)
                  : const Color(0xFF232323),
              size: 18,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                fontSize: 10.5,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                color: isSelected
                    ? const Color(0xFF4E4EDD)
                    : const Color(0xFF232323),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
