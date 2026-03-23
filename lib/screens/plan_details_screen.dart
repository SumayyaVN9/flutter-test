import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_constants.dart';

class PlanDetailsScreen extends StatelessWidget {
  final Map<String, String> plan;

  const PlanDetailsScreen({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          _buildTopSection(context),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _buildPlanDetailsSection(),
                  _buildActivationNote(),
                  _buildCountryNetworkSection(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
          _buildCheckoutButton(context),
        ],
      ),
    );
  }

  Widget _buildTopSection(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Top nav bar
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 10, 24, 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_back_ios_new,
                          size: 16, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plan['name'] ?? 'Plan Details',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const Text(
                          'Active',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[200]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.account_balance_wallet_outlined,
                            size: 16, color: Colors.black87),
                        const SizedBox(width: 4),
                        const Text('INR', style: TextStyle(fontSize: 13)),
                        const SizedBox(width: 2),
                        const Icon(Icons.keyboard_arrow_down,
                            size: 16, color: Colors.black54),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),
            // Plan summary
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            _statBox(plan['data'] ?? '5GB', 'Data'),
                            const SizedBox(width: 20),
                            _statBox(plan['days'] ?? '60', 'Days'),
                            const SizedBox(width: 20),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.wifi,
                                    size: 20, color: Colors.black87),
                                Text('Network',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black
                                            .withValues(alpha: 0.5))),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            _flagChip(AppAssets.flagUS),
                            const SizedBox(width: 2),
                            _flagChip(AppAssets.flagCA),
                            const SizedBox(width: 2),
                            _flagChip(AppAssets.flagDE),
                            const SizedBox(width: 6),
                            Text('+40 other',
                                style: TextStyle(
                                    fontSize: 12,
                                    color:
                                        Colors.black.withValues(alpha: 0.5))),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        plan['price'] ?? '\$3.99',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Change Plan',
                          style: TextStyle(
                            fontSize: 14,
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
            // Congrats banner
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              color: const Color(0xFFF0FFF0),
              child: Row(
                children: [
                  const Icon(Icons.check_circle,
                      color: AppColors.green, size: 16),
                  const SizedBox(width: 8),
                  const Text(
                    'Congrats! No extra fees on this activation',
                    style: TextStyle(fontSize: 13, color: AppColors.green),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanDetailsSection() {
    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 12),
            child: Text(
              'Plan Details',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: Column(
              children: [
                _detailRow(
                  Icons.wifi,
                  'Available',
                  'Hotspot',
                  Icons.signal_cellular_alt,
                  '5G/4G/LTE',
                  'Network',
                ),
                const Divider(height: 24),
                _detailRow(
                  Icons.add_circle_outline,
                  'Plus',
                  'APN',
                  Icons.bar_chart,
                  'Realtime, in-app',
                  'Usage Tracking',
                ),
                const Divider(height: 24),
                Row(
                  children: [
                    const Icon(Icons.flash_on, size: 20, color: Colors.amber),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Package activates upon first data usage',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Activation Policy',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black.withValues(alpha: 0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _detailRow(
    IconData icon1,
    String val1,
    String label1,
    IconData icon2,
    String val2,
    String label2,
  ) {
    return Row(
      children: [
        Expanded(child: _detailItem(icon1, val1, label1)),
        Expanded(child: _detailItem(icon2, val2, label2)),
      ],
    );
  }

  Widget _detailItem(IconData icon, String value, String label) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.black87),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style:
                    const TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            Text(label,
                style: TextStyle(
                    fontSize: 12, color: Colors.black.withValues(alpha: 0.5))),
          ],
        ),
      ],
    );
  }

  Widget _buildActivationNote() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.2)),
      ),
      child: const Text(
        'Your plan activated when you arrive at your destination. If you don\'t travel by 03/14/2026, it\'ll auto activate on that date and stay active for 30 days.',
        style: TextStyle(fontSize: 12, color: Colors.black87, height: 1.5),
      ),
    );
  }

  Widget _buildCountryNetworkSection() {
    final countries = [
      {
        'country': 'Canada',
        'flag': AppAssets.flagCA,
        'carriers': [
          'Bell Mobility',
          'Rogers Wireless',
          'SaskTel',
          'Telus',
          'Ice Wireless Inc'
        ],
      },
      {
        'country': 'Chad',
        'flag': AppAssets.flagUS,
        'carriers': ['Airtel Chad'],
      },
      {
        'country': 'Turkey',
        'flag': AppAssets.flagTR,
        'carriers': ['SIMBA', 'Starhub'],
      },
      {
        'country': 'United Kingdom',
        'flag': AppAssets.flagUS,
        'carriers': ['O2 (UK)', 'EE', 'Vodafone UK'],
      },
      {
        'country': 'United States of America',
        'flag': AppAssets.flagUS,
        'carriers': ['Verizon Wireless', 'AT&T'],
      },
      {
        'country': 'Vietnam',
        'flag': AppAssets.flagUS,
        'carriers': ['Celcom', 'Digi'],
      },
    ];

    return Container(
      margin: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(24, 16, 24, 8),
            child: Text(
              'Country and Network',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
            child: Text(
              'Note: The operator may switch to alternative networks in covered countries without notice',
              style: TextStyle(
                  fontSize: 12, color: Colors.black.withValues(alpha: 0.6)),
            ),
          ),
          ...countries.asMap().entries.map((entry) {
            final int i = entry.key;
            final Map<String, dynamic> c = entry.value as Map<String, dynamic>;
            return Column(
              children: [
                if (i != 0) const Divider(height: 1, indent: 16, endIndent: 16),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipOval(
                            child: Image.network(
                              c['flag'] as String,
                              width: 24,
                              height: 24,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.flag, size: 20),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            c['country'] as String,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: (c['carriers'] as List<String>)
                            .map((carrier) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    carrier,
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black87),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCheckoutButton(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 28),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
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
          padding: const EdgeInsets.symmetric(vertical: 18),
          shape: const StadiumBorder(),
          elevation: 0,
        ),
        child: const Text(
          'Continue Checkout',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _statBox(String value, String label) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(value,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black)),
        Text(label,
            style: TextStyle(
                fontSize: 12, color: Colors.black.withValues(alpha: 0.5))),
      ],
    );
  }

  Widget _flagChip(String url) {
    return ClipOval(
      child: Image.network(
        url,
        width: 18,
        height: 18,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) =>
            Container(width: 18, height: 18, color: Colors.grey[300]),
      ),
    );
  }
}
