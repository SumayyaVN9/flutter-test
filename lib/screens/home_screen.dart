import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import 'plans_screen.dart';
import 'search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  _buildHeader(context),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: [
                        _buildEmptyPlansCard(context),
                        const SizedBox(height: 12),
                        _buildGlobalPlanCard(),
                        const SizedBox(height: 16),
                        _buildSectionTitle('Most Searched Locations'),
                        const SizedBox(height: 10),
                        _buildLocationChips(),
                        const SizedBox(height: 16),
                        _buildPopularHeader(context),
                        const SizedBox(height: 10),
                        _buildPopularGrid(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Floating chat button
            Positioned(
              bottom: 90,
              right: 14,
              child: Container(
                width: 56,
                height: 56,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.chat_bubble_outline,
                    color: Colors.white, size: 24),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
                letterSpacing: 0.12,
              ),
              children: [
                TextSpan(text: 'Hello, '),
                TextSpan(text: 'Mahima'),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const SearchScreen())),
            child: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF365CC3).withValues(alpha: 0.04),
                    blurRadius: 20,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: const Icon(Icons.search, color: Colors.black87, size: 22),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyPlansCard(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 32, 24, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(36),
      ),
      child: Column(
        children: [
          Image.network(
            AppAssets.simCard,
            height: 140,
            fit: BoxFit.contain,
            errorBuilder: (_, __, ___) => const Icon(Icons.sim_card, size: 80),
          ),
          const SizedBox(height: 20),
          const Text(
            'No active plans',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Purchase your first plan to get connected',
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withValues(alpha: 0.64),
              letterSpacing: 0.06,
            ),
          ),
          const SizedBox(height: 20),
          LayoutBuilder(
            builder: (context, constraints) {
              final isWeb = MediaQuery.of(context).size.width > 600;
              final buttonWidth = isWeb ? 240.0 : double.infinity;

              return SizedBox(
                width: buttonWidth,
                height: 44,
                child: isWeb
                    ? Center(
                        child: ElevatedButton(
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const PlansScreen()),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            shape: const StadiumBorder(),
                            elevation: 0,
                          ),
                          child: const Text(
                            'Browse Plans',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const PlansScreen()),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          shape: const StadiumBorder(),
                          elevation: 0,
                        ),
                        child: const Text(
                          'Browse Plans',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              );
            },
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: AppColors.green, size: 14),
              const SizedBox(width: 4),
              Text(
                'Your device supports eSIM',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.green.withValues(alpha: 0.8),
                  letterSpacing: -0.22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGlobalPlanCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1A1A2E),
            Color(0xFF2D2B55),
            Color(0xFF4E4EDD),
          ],
          stops: [0.0, 0.6, 1.0],
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: Colors.white.withValues(alpha: 0.2)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF365CC3).withValues(alpha: 0.04),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Global Plan',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: -0.3,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Unlimited data in 50+ countries',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '\$9.99',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        letterSpacing: -1,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '\$19.99',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.35),
                        decoration: TextDecoration.lineThrough,
                        decorationColor: Colors.white.withValues(alpha: 0.35),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '/ 7 days',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.white.withValues(alpha: 0.5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              AppAssets.earthGlobe,
              width: 90,
              height: 90,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.public, color: Colors.white, size: 60),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textDark,
        letterSpacing: -0.064,
      ),
    );
  }

  Widget _buildLocationChips() {
    final locations = [
      {'name': 'Canada', 'flag': AppAssets.flagCA},
      {'name': 'Germany', 'flag': AppAssets.flagDE},
      {'name': 'Mexico', 'flag': AppAssets.flagMX},
      {'name': 'Turkey', 'flag': AppAssets.flagTR},
      {'name': 'New Zealand', 'flag': AppAssets.flagNZ},
      {'name': 'Portugal', 'flag': AppAssets.flagPT},
      {'name': 'Spain', 'flag': AppAssets.flagES},
      {'name': 'Greece', 'flag': AppAssets.flagGR},
      {'name': 'China', 'flag': AppAssets.flagCN},
      {'name': 'Kazakhstan', 'flag': AppAssets.flagKZ},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: locations
            .map((loc) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(7, 1, 10, 1),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Colors.black.withValues(alpha: 0.04),
                          width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ClipOval(
                          child: Image.network(
                            loc['flag']!,
                            width: 28,
                            height: 28,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) => Container(
                              width: 28,
                              height: 28,
                              color: Colors.grey[200],
                              child: const Icon(Icons.flag, size: 14),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          loc['name']!,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }

  Widget _buildPopularHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Popular Destinations',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            letterSpacing: -0.064,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: const Text(
            'View All',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularGrid() {
    final leftCol = [
      {
        'name': 'Turkey',
        'price': '\$4.50',
        'img': AppAssets.destTurkey,
        'limited': false,
        'tall': false
      },
      {
        'name': 'Thailand',
        'price': '\$4.75',
        'img': AppAssets.destThailand,
        'limited': false,
        'tall': true
      },
      {
        'name': 'United Kingdom',
        'price': '\$4.80',
        'img': AppAssets.destUK,
        'limited': false,
        'tall': true
      },
    ];
    final rightCol = [
      {
        'name': 'Greece',
        'price': '\$4.20',
        'img': AppAssets.destGreece,
        'limited': true,
        'tall': true
      },
      {
        'name': 'Egypt',
        'price': '\$5.00',
        'img': AppAssets.destEgypt,
        'limited': false,
        'tall': true
      },
      {
        'name': 'Italy',
        'price': '\$5.25',
        'img': AppAssets.destItaly,
        'limited': false,
        'tall': false
      },
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: Column(children: leftCol.map(_buildDestCard).toList())),
        const SizedBox(width: 8),
        Expanded(
            child: Column(children: rightCol.map(_buildDestCard).toList())),
      ],
    );
  }

  Widget _buildDestCard(Map<String, dynamic> dest) {
    final bool isTall = dest['tall'] as bool;
    final bool isLimited = dest['limited'] as bool;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  dest['img'] as String,
                  width: double.infinity,
                  height: isTall ? 160.0 : 100.0,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: isTall ? 160.0 : 100.0,
                    color: Colors.grey[300],
                    child: const Icon(Icons.image, size: 40),
                  ),
                ),
              ),
              if (isLimited)
                Positioned(
                  bottom: 8,
                  left: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha: 0.38),
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(
                          color: Colors.white.withValues(alpha: 0.18)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 7,
                          height: 7,
                          decoration: BoxDecoration(
                            color: AppColors.limitedGreen,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.limitedGreen
                                    .withValues(alpha: 0.9),
                                blurRadius: 5,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          'Limited',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dest['name'] as String,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Starting From',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withValues(alpha: 0.5),
                    letterSpacing: -0.4,
                  ),
                ),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      dest['price'] as String,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const Icon(Icons.chevron_right,
                        size: 16, color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
