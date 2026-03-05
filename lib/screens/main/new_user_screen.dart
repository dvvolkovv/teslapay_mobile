import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class NewUserScreen extends StatefulWidget {
  const NewUserScreen({super.key});

  @override
  State<NewUserScreen> createState() => _NewUserScreenState();
}

class _NewUserScreenState extends State<NewUserScreen> {
  int _currentNavIndex = 0;

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
                    _buildGetAccessCard(),
                    _buildRecentTransactionsHeader(),
                    _buildEmptyTransactions(),
                    const SizedBox(height: 32),
                    _buildGetCardButton(),
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
                balance: '0 EUR',
              ),
              Divider(height: 1, thickness: 1, color: AppColors.background),
              _buildAccountRow(
                currencyIcon: '\$',
                currencyName: 'Dollar',
                balance: '0 USD',
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
            // Background gradient
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
            // Decorative shapes
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

  Widget _buildEmptyTransactions() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 48),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.inputBg,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.receipt_long_outlined,
              color: AppColors.secondary,
              size: 40,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'You have no transactions',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your transaction history will appear here',
            style: GoogleFonts.poppins(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: AppColors.secondary.withValues(alpha: 0.7),
              letterSpacing: 0.25,
              height: 1.4,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildGetCardButton() {
    return GestureDetector(
      onTap: () {
        // Handle get card action
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 19),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Center(
          child: Text(
            'GET YOUR CARD',
            style: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
              letterSpacing: 0.32,
              height: 1.2,
            ),
          ),
        ),
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
        onTap: () => setState(() => _currentNavIndex = index),
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: isActive
              ? Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
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
