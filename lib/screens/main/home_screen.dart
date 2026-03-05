import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';
import '../../navigation/app_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;

  static const List<Map<String, dynamic>> _transactions = [
    {
      'icon': Icons.arrow_upward,
      'title': 'SEPA Transfer',
      'date': 'Today, 14:32',
      'amount': '-€ 250.00',
      'isOut': true,
    },
    {
      'icon': Icons.arrow_downward,
      'title': 'Salary',
      'date': 'Yesterday',
      'amount': '+€ 3,500.00',
      'isOut': false,
    },
    {
      'icon': Icons.arrow_upward,
      'title': 'Amazon',
      'date': 'Mar 3',
      'amount': '-€ 89.99',
      'isOut': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildAccountsSection(),
                    const SizedBox(height: 16),
                    _buildCardsSection(),
                    const SizedBox(height: 16),
                    _buildGetAccessCard(),
                    const SizedBox(height: 8),
                    _buildRecentTransactionsHeader(),
                    _buildTransactionsList(),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Text(
            'TeslaPay',
            style: GoogleFonts.poppins(
              fontSize: 28,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
              height: 1.2,
            ),
          ),
          const Spacer(),
          const Icon(Icons.notifications_outlined,
              color: AppColors.darkText, size: 24),
          const SizedBox(width: 16),
          const Icon(Icons.search_outlined,
              color: AppColors.darkText, size: 24),
          const SizedBox(width: 16),
          const Icon(Icons.qr_code_scanner_outlined,
              color: AppColors.darkText, size: 24),
        ],
      ),
    );
  }

  Widget _buildAccountsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Accounts',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
              height: 1.2,
            ),
          ),
        ),
        Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              _buildAccountRow(
                currencyIcon: '€',
                currencyName: 'Euro',
                balance: '12 677 EUR',
                isTop: true,
              ),
              Divider(
                  height: 1, thickness: 1, color: AppColors.background),
              _buildAccountRow(
                currencyIcon: '\$',
                currencyName: 'Dollar',
                balance: '0 USD',
                isTop: false,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAccountRow({
    required String currencyIcon,
    required String currencyName,
    required String balance,
    required bool isTop,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: AppColors.secondary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                currencyIcon,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.darkText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            currencyName,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.darkText,
              height: 1.2,
            ),
          ),
          const Spacer(),
          Text(
            balance,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: AppColors.darkText,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Cards',
              style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
                height: 1.2,
              ),
            ),
            const Icon(Icons.add, color: AppColors.darkText, size: 24),
          ],
        ),
        const SizedBox(height: 12),
        _buildCardRow(
          currencyIcon: '€',
          cardName: 'Black Plastic',
          subtitle: 'Linked to EUR account',
          balance: '12 677 EUR',
          isDark: true,
          cardBrand: 'mastercard',
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF39424D).withValues(alpha: 0.05),
                offset: const Offset(0, -10),
                blurRadius: 20,
              ),
            ],
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: _buildCardRow(
            currencyIcon: '\$',
            cardName: 'Premium Grey',
            subtitle: 'Linked to USD account',
            balance: '0 USD',
            isDark: false,
            cardBrand: 'visa',
          ),
        ),
      ],
    );
  }

  Widget _buildCardRow({
    required String currencyIcon,
    required String cardName,
    required String subtitle,
    required String balance,
    required bool isDark,
    required String cardBrand,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2B2B) : Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.secondary.withValues(alpha: 0.3)
                  : AppColors.secondary.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                currencyIcon,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.whiteText : AppColors.darkText,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cardName,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: isDark ? AppColors.whiteText : AppColors.darkText,
                    height: 1.2,
                  ),
                ),
                Text(
                  subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondary,
                    letterSpacing: 0.25,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                balance,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: isDark ? AppColors.whiteText : AppColors.darkText,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 4),
              _buildCardBrandLogo(cardBrand, isDark),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCardBrandLogo(String brand, bool isDark) {
    if (brand == 'mastercard') {
      return SizedBox(
        width: 22,
        height: 14,
        child: Stack(
          children: [
            Positioned(
              left: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: Color(0xFFEB001B),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 14,
                height: 14,
                decoration: const BoxDecoration(
                  color: Color(0xFFF79E1B),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          color: isDark ? Colors.white.withValues(alpha: 0.15) : Colors.white,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          'VISA',
          style: GoogleFonts.poppins(
            fontSize: 8,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1A1F71),
            letterSpacing: 0.5,
          ),
        ),
      );
    }
  }

  Widget _buildGetAccessCard() {
    return Container(
      width: double.infinity,
      height: 240,
      decoration: BoxDecoration(
        color: const Color(0xFF061016),
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // Background gradient overlay simulating building art
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFF061016),
                    Color(0xFF0D2030),
                    Color(0xFF1A3A50),
                  ],
                ),
              ),
            ),
            // Decorative circles for building silhouette feel
            Positioned(
              bottom: -20,
              left: -30,
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: const Color(0xFF0E3050).withValues(alpha: 0.6),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            Positioned(
              bottom: -40,
              right: -20,
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: const Color(0xFF0A2540).withValues(alpha: 0.5),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Content
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      'Get full access to TeslaPay',
                      style: GoogleFonts.poppins(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: AppColors.whiteText,
                        height: 1.4,
                      ),
                    ),
                  ),
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.whiteText.withValues(alpha: 0.6),
                          width: 1.5),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.arrow_forward,
                      color: AppColors.whiteText,
                      size: 14,
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

  Widget _buildRecentTransactionsHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Recent transactions',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
              height: 1.2,
            ),
          ),
          Row(
            children: const [
              Icon(Icons.calendar_today_outlined,
                  color: AppColors.darkText, size: 22),
              SizedBox(width: 12),
              Icon(Icons.tune_outlined, color: AppColors.darkText, size: 22),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionsList() {
    return Column(
      children: _transactions.map((tx) => _buildTransactionItem(tx)).toList(),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> tx) {
    final bool isOut = tx['isOut'] as bool;
    final Color iconBgColor = isOut
        ? AppColors.error.withValues(alpha: 0.12)
        : AppColors.success.withValues(alpha: 0.12);
    final Color iconColor = isOut ? AppColors.error : AppColors.success;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              tx['icon'] as IconData,
              color: iconColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  tx['date'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: AppColors.secondary,
                    letterSpacing: 0.25,
                    height: 1.2,
                  ),
                ),
              ],
            ),
          ),
          Text(
            tx['amount'] as String,
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: isOut ? AppColors.error : AppColors.success,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        color: Color(0xFF2C2B2B),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Row(
        children: [
          _buildNavItem(0, Icons.home_outlined, 'Home'),
          _buildNavItem(1, Icons.arrow_circle_down_outlined, null),
          _buildNavItem(2, Icons.arrow_circle_up_outlined, null),
          _buildNavItem(3, Icons.person_outline, null),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String? label) {
    final bool isActive = _currentNavIndex == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (index == _currentNavIndex) return;
          setState(() => _currentNavIndex = index);
          String? route;
          switch (index) {
            case 1:
              route = AppRouter.receive;
              break;
            case 2:
              route = AppRouter.send;
              break;
            case 3:
              route = AppRouter.profile;
              break;
          }
          if (route != null) {
            Navigator.of(context)
                .pushNamed(route)
                .then((_) => setState(() => _currentNavIndex = 0));
          }
        },
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: isActive
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(44),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(icon, color: AppColors.darkText, size: 24),
                      if (label != null) ...[
                        const SizedBox(width: 6),
                        Text(
                          label,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.darkText,
                            letterSpacing: 0.25,
                            height: 1.2,
                          ),
                        ),
                      ],
                    ],
                  ),
                )
              : Icon(icon, color: AppColors.whiteText, size: 24),
        ),
      ),
    );
  }
}
