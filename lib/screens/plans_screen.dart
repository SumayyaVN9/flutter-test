import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';
import '../widgets/app_image.dart';
import 'plan_details_screen.dart';

class PlansScreen extends StatelessWidget {
  const PlansScreen({super.key});

  List<Map<String, String>> _plans(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [
      {
        'name': l10n.redwoodUnlimited,
        'data': '10GB',
        'days': '30',
        'price': '\$3.99',
        'badge': l10n.bestChoice,
      },
      {
        'name': l10n.sierra3gb,
        'data': '5GB',
        'days': '60',
        'price': '\$3.99',
        'badge': '',
      },
      {
        'name': l10n.unlimited5gb,
        'data': '5GB',
        'days': '60',
        'price': '\$3.99',
        'badge': '',
      },
      {
        'name': l10n.guadalupe10gb,
        'data': '15GB',
        'days': '90',
        'price': '\$3.99',
        'badge': '',
      },
      {
        'name': l10n.sierra3gb,
        'data': '5GB',
        'days': '60',
        'price': '\$3.99',
        'badge': '',
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    final plans = _plans(context);
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final bool showTwoColumns = constraints.maxWidth >= 900;

                if (showTwoColumns) {
                  return GridView.builder(
                    padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                    itemCount: plans.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      mainAxisExtent: 220,
                    ),
                    itemBuilder: (context, index) =>
                        _buildPlanCard(context, plans[index]),
                  );
                }

                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(24, 12, 24, 20),
                  itemCount: plans.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 12),
                  itemBuilder: (context, index) =>
                      _buildPlanCard(context, plans[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          // padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
          padding: const EdgeInsets.fromLTRB(24, 40, 24, 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.selectPlanFor,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        letterSpacing: -0.2,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          AppLocalizations.of(context)!.usaAndOneMore,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            AppLocalizations.of(context)!.change,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  } else {
                    Navigator.of(context).pushReplacementNamed('/home');
                  }
                },
                child: Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE2E4EA),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Colors.black87,
                    size: 28,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context, Map<String, String> plan) {
    final bool isBestChoice =
        plan['badge'] == AppLocalizations.of(context)!.bestChoice;

    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PlanDetailsScreen(plan: plan),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isBestChoice
                ? AppColors.primary.withValues(alpha: 0.85)
                : AppColors.primary.withValues(alpha: 0.25),
            width: isBestChoice ? 1.8 : 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            if (isBestChoice)
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFF3B0B8E),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(14),
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star_rounded,
                        color: Colors.white, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      AppLocalizations.of(context)!.bestChoice,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        height: 1,
                      ),
                    ),
                  ],
                ),
              ),
            ClipRRect(
              borderRadius: BorderRadius.vertical(
                bottom: const Radius.circular(14),
                top: Radius.circular(isBestChoice ? 0 : 14),
              ),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 14, 16, 10),
                    child: Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                plan['name']!,
                                style: const TextStyle(
                                  fontSize: 25,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF1A2F54),
                                  letterSpacing: -0.2,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              plan['price']!,
                              style: const TextStyle(
                                fontSize: 37,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF1A2F54),
                                letterSpacing: -1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _planStat(context, plan['data']!,
                                AppLocalizations.of(context)!.data),
                            const SizedBox(width: 18),
                            _planStat(context, plan['days']!,
                                AppLocalizations.of(context)!.days),
                            const SizedBox(width: 18),
                            _planStat(
                              context,
                              '5G',
                              AppLocalizations.of(context)!.network,
                              valueColor: const Color(0xFF2AA84A),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            _flagChip(AppAssets.flagUS),
                            const SizedBox(width: 2),
                            _flagChip(AppAssets.flagCA),
                            const SizedBox(width: 2),
                            _flagChip(AppAssets.flagDE),
                            const SizedBox(width: 6),
                            Text(
                              AppLocalizations.of(context)!.other40Plus,
                              style: TextStyle(
                                fontSize: 11,
                                color: Colors.black.withValues(alpha: 0.55),
                              ),
                            ),
                            const Spacer(),
                            SizedBox(
                              height: 36,
                              child: ElevatedButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) =>
                                        PlanDetailsScreen(plan: plan),
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryLight,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 20,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  elevation: 0,
                                ),
                                child: Text(
                                  AppLocalizations.of(context)!.buy,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _planStat(BuildContext context, String value, String label,
      {Color? valueColor}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: valueColor ?? const Color(0xFF273754),
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.black.withValues(alpha: 0.35),
          ),
        ),
      ],
    );
  }

  Widget _flagChip(String url) {
    return ClipOval(
      child: AppImage(
        imageUrl: url,
        width: 18,
        height: 18,
        fit: BoxFit.cover,
        placeholder: (_, __) => Container(width: 18, height: 18, color: Colors.grey[200]),
        errorWidget: (_, __, ___) => Container(width: 18, height: 18, color: Colors.grey[300]),
      ),
    );
  }
}
