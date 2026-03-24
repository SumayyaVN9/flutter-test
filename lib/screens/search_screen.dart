import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../widgets/app_image.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int _selectedTab = 0; // 0 = Regional, 1 = Global
  final TextEditingController _controller = TextEditingController();
  final Set<String> _selectedCountries = {}; // Track selected countries

  List<Map<String, dynamic>> _getResults(BuildContext context) {
    return [
      {
        'country': AppLocalizations.of(context)!.turkey,
        'flag': AppAssets.flagTR,
        'price': AppLocalizations.of(context)!.startingFromUsd
      },
      {
        'country': AppLocalizations.of(context)!.unitedKingdom,
        'flag': AppAssets.flagGB,
        'price': AppLocalizations.of(context)!.startingFromUsd
      },
      {
        'country': AppLocalizations.of(context)!.vietnam,
        'flag': AppAssets.flagVN,
        'price': AppLocalizations.of(context)!.startingFromUsd
      },
      {
        'country': AppLocalizations.of(context)!.usa,
        'flag': AppAssets.flagUS,
        'price': AppLocalizations.of(context)!.startingFromUsd
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final results = _getResults(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopNav(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
              children: [
                 _buildResultSection(AppLocalizations.of(context)!.popular, results),
                const SizedBox(height: 16),
                _buildResultSection(AppLocalizations.of(context)!.recommended, results),
              ],
            ),
          ),
          _buildBottomButton(context),
        ],
      ),
    );
  }

  Widget _buildTopNav(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 12),
          child: Column(
            children: [
              // Title row
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(Icons.arrow_back_ios_new,
                        size: 20, color: Colors.black87),
                  ),
                  const SizedBox(width: 10),
                   Expanded(
                    child: Text(
                      AppLocalizations.of(context)!.searchLocations,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const Icon(Icons.tune_outlined,
                      size: 24, color: Colors.black87),
                ],
              ),
              const SizedBox(height: 12),
              // Search input
              Container(
                height: 54,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    const SizedBox(width: 14),
                    const Icon(Icons.search, color: Colors.black54, size: 22),
                    const SizedBox(width: 8),
                    Expanded(
                       child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: AppLocalizations.of(context)!.searchPlaceholder,
                          hintStyle: const TextStyle(
                            color: Colors.black38,
                            fontSize: 14,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // Tabs
              Row(
                children: [
                   _tabItem(AppLocalizations.of(context)!.regional, 0),
                  const SizedBox(width: 24),
                  _tabItem(AppLocalizations.of(context)!.globalPlan, 1),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tabItem(String label, int index) {
    final bool isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedTab = index),
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              color: isSelected ? AppColors.primary : Colors.black54,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            height: 2,
            width: 60,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultSection(String title, List<Map<String, dynamic>> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: items.asMap().entries.map((entry) {
              final int i = entry.key;
              final Map<String, dynamic> item = entry.value;
              final String country = item['country']!;
              final bool isSelected = _selectedCountries.contains(country);
              return Column(
                children: [
                  if (i != 0) const Divider(height: 1, indent: 64),
                  _resultTile(item, isSelected),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _resultTile(Map<String, dynamic> item, bool isSelected) {
    final String country = item['country']!;
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            _selectedCountries.remove(country);
          } else {
            _selectedCountries.add(country);
          }
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        child: Row(
          children: [
            ClipOval(
              child: AppImage(
                imageUrl: item['flag']!,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                placeholder: (_, __) => Container(
                  width: 36,
                  height: 36,
                  color: Colors.grey[200],
                ),
                errorWidget: (_, __, ___) => Container(
                  width: 36,
                  height: 36,
                  color: Colors.grey[200],
                  child: const Icon(Icons.flag, size: 18),
                ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['country']!,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    item['price']!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.black.withValues(alpha: 0.5),
                    ),
                  ),
                ],
              ),
            ),
            // Radio button instead of chevron
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : Colors.grey[300]!,
                  width: 2,
                ),
                color: isSelected ? AppColors.primary : Colors.transparent,
              ),
              child: isSelected
                  ? const Center(
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 14,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 0,
        ),
        child: Text(
          AppLocalizations.of(context)!.searchForCountries(_selectedCountries.length),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}


