import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
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
                        _buildGlobalPlanCard(context),
                        const SizedBox(height: 16),
                        _buildSectionTitle(
                            context,
                            AppLocalizations.of(context)!
                                .mostSearchedLocations),
                        const SizedBox(height: 10),
                        _buildLocationChips(context),
                        const SizedBox(height: 16),
                        _buildPopularHeader(context),
                        const SizedBox(height: 10),
                        _buildPopularGrid(context),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Floating chat button
            Builder(
              builder: (context) {
                final isWeb = MediaQuery.of(context).size.width > 600;
                return Positioned(
                  bottom: isWeb ? 24 : 86,
                  right: isWeb ? 24 : 16,
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
                );
              },
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
            text: TextSpan(
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.textBlack,
                letterSpacing: 0.12,
              ),
              children: [
                TextSpan(text: '${AppLocalizations.of(context)!.hello} '),
                TextSpan(text: AppLocalizations.of(context)!.userName),
              ],
            ),
          ),
          Row(
            children: [
              // Language Switch Button
              Theme(
                data: Theme.of(context).copyWith(
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                ),
                child: PopupMenuButton<String>(
                  tooltip: '',
                  splashRadius: 0,
                  onSelected: (_) {},
                  itemBuilder: (BuildContext context) =>
                      <PopupMenuEntry<String>>[
                    const PopupMenuItem<String>(
                      value: 'en',
                      child: Text('English'),
                    ),
                    const PopupMenuItem<String>(
                      value: 'ar',
                      child: Text('العربية'),
                    ),
                  ],
                  child: Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color:
                              const Color(0xFF365CC3).withValues(alpha: 0.04),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(width: 4),
                          Text(
                            Localizations.localeOf(context)
                                .languageCode
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                          const Icon(Icons.arrow_drop_down,
                              size: 16, color: AppColors.primary),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Search Button
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
                  child:
                      const Icon(Icons.search, color: Colors.black87, size: 22),
                ),
              ),
            ],
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
          CachedNetworkImage(
            imageUrl: AppAssets.simCard,
            height: 140,
            fit: BoxFit.contain,
            placeholder: (_, __) => const SizedBox(
              height: 140,
              child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
            ),
            errorWidget: (_, __, ___) => const Icon(Icons.sim_card, size: 80),
          ),
          const SizedBox(height: 20),
          Text(
            AppLocalizations.of(context)!.noActivePlans,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textBlack,
              letterSpacing: 0.1,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            AppLocalizations.of(context)!.purchaseFirstPlan,
            style: TextStyle(
              fontSize: 12,
              color: Colors.black.withValues(alpha: 0.64),
              letterSpacing: 0.06,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 54,
            child: ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PlansScreen()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                shape: const StadiumBorder(),
                elevation: 0,
              ),
              child: Text(
                AppLocalizations.of(context)!.browsePlans,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: AppColors.green, size: 14),
              const SizedBox(width: 4),
              Text(
                AppLocalizations.of(context)!.yourDeviceSupportsEsim,
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

  Widget _buildGlobalPlanCard(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(28),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isCompact = constraints.maxWidth < 360;
          final double globeSize = isCompact ? 156 : 190;
          final double textRightPadding = isCompact ? 116 : 140;
          final double globeRight = isCompact ? -24 : -34;
          final double globeBottom = isCompact ? -30 : -38;

          return Container(
            width: double.infinity,
            height: 138,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF1A1A2E),
                  Color(0xFF2F2E68),
                  Color(0xFF4D4BD2),
                ],
              ),
              borderRadius: BorderRadius.circular(28),
              border: Border.all(color: Colors.white.withValues(alpha: 0.16)),
            ),
            child: Stack(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(24, 18, textRightPadding, 14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.of(context)!.globalPlan,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 18,
                          height: 1.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          letterSpacing: -0.3,
                        ),
                      ),
                      const SizedBox(height: 3),
                      Text(
                        AppLocalizations.of(context)!.unlimitedDataCountries,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.white.withValues(alpha: 0.58),
                        ),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: double.infinity,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          alignment: Alignment.centerLeft,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Text(
                                '\$9.99',
                                style: TextStyle(
                                  fontSize: 40,
                                  height: 0.88,
                                  fontWeight: FontWeight.w800,
                                  color: Colors.white,
                                  letterSpacing: -1.1,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  '\$19.99',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withValues(alpha: 0.34),
                                    decoration: TextDecoration.lineThrough,
                                    decorationColor:
                                        Colors.white.withValues(alpha: 0.34),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 4),
                                child: Text(
                                  AppLocalizations.of(context)!.per7Days,
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white.withValues(alpha: 0.5),
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
                Positioned(
                  right: globeRight,
                  bottom: globeBottom,
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: AppAssets.earthGlobe,
                      width: globeSize,
                      height: globeSize,
                      fit: BoxFit.cover,
                      placeholder: (_, __) => Container(
                        width: globeSize,
                        height: globeSize,
                        color: const Color(0xFF3C3A9E),
                      ),
                      errorWidget: (_, __, ___) => Container(
                        width: globeSize,
                        height: globeSize,
                        color: const Color(0xFF3C3A9E),
                        alignment: Alignment.center,
                        child: const Icon(Icons.public,
                            color: Colors.white, size: 72),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
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

  Widget _buildLocationChips(BuildContext context) {
    final locations = [
      {'name': AppLocalizations.of(context)!.canada, 'flag': AppAssets.flagCA},
      {'name': AppLocalizations.of(context)!.germany, 'flag': AppAssets.flagDE},
      {'name': AppLocalizations.of(context)!.mexico, 'flag': AppAssets.flagMX},
      {'name': AppLocalizations.of(context)!.turkey, 'flag': AppAssets.flagTR},
      {
        'name': AppLocalizations.of(context)!.newZealand,
        'flag': AppAssets.flagNZ
      },
      {
        'name': AppLocalizations.of(context)!.portugal,
        'flag': AppAssets.flagPT
      },
      {'name': AppLocalizations.of(context)!.spain, 'flag': AppAssets.flagES},
      {'name': AppLocalizations.of(context)!.greece, 'flag': AppAssets.flagGR},
      {'name': AppLocalizations.of(context)!.china, 'flag': AppAssets.flagCN},
      {
        'name': AppLocalizations.of(context)!.kazakhstan,
        'flag': AppAssets.flagKZ
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: locations
            .map((loc) => Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(
                        10, 1, 10, 1), // Unified padding
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
                          child: CachedNetworkImage(
                            imageUrl: loc['flag']!,
                            width: 28,
                            height: 28,
                            fit: BoxFit.cover,
                            placeholder: (_, __) => Container(
                              width: 28,
                              height: 28,
                              color: Colors.grey[200],
                            ),
                            errorWidget: (_, __, ___) => Container(
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
        Text(
          AppLocalizations.of(context)!.popularDestinations,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textDark,
            letterSpacing: -0.064,
          ),
        ),
        GestureDetector(
          onTap: () {},
          child: Text(
            AppLocalizations.of(context)!.viewAll,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryLight,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPopularGrid(BuildContext context) {
    final leftCol = [
      {
        'name': AppLocalizations.of(context)!.turkey,
        'price': '\$4.50',
        'img': AppAssets.destTurkey,
        'limited': false,
        'tall': false
      },
      {
        'name': AppLocalizations.of(context)!.thailand,
        'price': '\$4.75',
        'img': AppAssets.destThailand,
        'limited': false,
        'tall': true
      },
      {
        'name': AppLocalizations.of(context)!.unitedKingdom,
        'price': '\$4.80',
        'img': AppAssets.destUK,
        'limited': false,
        'tall': true
      },
    ];
    final rightCol = [
      {
        'name': AppLocalizations.of(context)!.greece,
        'price': '\$4.20',
        'img': AppAssets.destGreece,
        'limited': true,
        'tall': true
      },
      {
        'name': AppLocalizations.of(context)!.egypt,
        'price': '\$5.00',
        'img': AppAssets.destEgypt,
        'limited': false,
        'tall': true
      },
      {
        'name': AppLocalizations.of(context)!.italy,
        'price': '\$5.25',
        'img': AppAssets.destItaly,
        'limited': false,
        'tall': false
      },
    ];

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children:
                leftCol.map((dest) => _buildDestCard(context, dest)).toList(),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            children:
                rightCol.map((dest) => _buildDestCard(context, dest)).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildDestCard(BuildContext context, Map<String, dynamic> dest) {
    final bool isTall = dest['tall'] as bool;
    final bool isLimited = dest['limited'] as bool;
    final bool isWeb = MediaQuery.of(context).size.width > 600;
    final double imageHeight =
        isWeb ? (isTall ? 220.0 : 150.0) : (isTall ? 160.0 : 100.0);

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
                child: CachedNetworkImage(
                  imageUrl: dest['img'] as String,
                  width: double.infinity,
                  height: imageHeight,
                  fit: BoxFit.cover,
                  placeholder: (_, __) => Container(
                    height: imageHeight,
                    color: Colors.grey[200],
                    child: const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  errorWidget: (_, __, ___) => Container(
                    height: imageHeight,
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
                        Text(
                          AppLocalizations.of(context)!.limited,
                          style: const TextStyle(
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
                  AppLocalizations.of(context)!.startingFrom,
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
