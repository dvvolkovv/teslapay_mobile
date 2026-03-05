import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../theme/app_colors.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  int _selectedFilter = 0;
  int _currentMonth = 1; // 0=January, 1=February, 2=March ...

  static const List<String> _filters = ['All', 'Send', 'Receive'];

  static const List<String> _months = [
    'January', 'February', 'March', 'April',
    'May', 'June', 'July', 'August',
    'September', 'October', 'November', 'December',
  ];

  static const List<Map<String, dynamic>> _allTransactions = [
    {
      'group': 'Today',
      'items': [
        {
          'title': 'SEPA Transfer',
          'subtitle': 'To: Max Mustermann',
          'amount': '-€ 250.00',
          'isOut': true,
          'time': '14:32',
        },
        {
          'title': 'Card payment',
          'subtitle': 'Coffee Shop',
          'amount': '-€ 4.50',
          'isOut': true,
          'time': '09:15',
        },
      ],
    },
    {
      'group': 'Yesterday',
      'items': [
        {
          'title': 'Salary',
          'subtitle': 'From: ACME Corp',
          'amount': '+€ 3,500.00',
          'isOut': false,
          'time': '08:00',
        },
        {
          'title': 'Freelance payment',
          'subtitle': 'From: Client XYZ',
          'amount': '+€ 800.00',
          'isOut': false,
          'time': '11:20',
        },
      ],
    },
    {
      'group': 'Mar 3',
      'items': [
        {
          'title': 'Amazon',
          'subtitle': 'Online purchase',
          'amount': '-€ 89.99',
          'isOut': true,
          'time': '16:45',
        },
        {
          'title': 'Netflix',
          'subtitle': 'Subscription',
          'amount': '-€ 15.99',
          'isOut': true,
          'time': '00:01',
        },
      ],
    },
    {
      'group': 'Mar 1',
      'items': [
        {
          'title': 'Bank transfer',
          'subtitle': 'From: Maria S.',
          'amount': '+€ 200.00',
          'isOut': false,
          'time': '13:10',
        },
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredTransactions {
    if (_selectedFilter == 0) return _allTransactions;

    final bool wantOut = _selectedFilter == 1;
    return _allTransactions
        .map((group) {
          final filteredItems = (group['items'] as List)
              .where((item) => (item['isOut'] as bool) == wantOut)
              .toList();
          if (filteredItems.isEmpty) return null;
          return {'group': group['group'], 'items': filteredItems};
        })
        .whereType<Map<String, dynamic>>()
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAppBar(context),
            _buildFilterChips(),
            _buildPeriodSelector(),
            Expanded(
              child: _buildTransactionList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: AppColors.darkText,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            'Activity',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.darkText,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChips() {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        separatorBuilder: (context2, index2) => const SizedBox(width: 8),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final bool isSelected = _selectedFilter == index;
          return GestureDetector(
            onTap: () => setState(() => _selectedFilter = index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Text(
                _filters[index],
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight:
                      isSelected ? FontWeight.w600 : FontWeight.w400,
                  color: isSelected
                      ? AppColors.darkText
                      : AppColors.secondary,
                  height: 1.2,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPeriodSelector() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                if (_currentMonth > 0) {
                  setState(() => _currentMonth--);
                }
              },
              child: const Icon(Icons.chevron_left,
                  color: AppColors.darkText, size: 24),
            ),
            Text(
              '${_months[_currentMonth]} 2026',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.darkText,
                height: 1.2,
              ),
            ),
            GestureDetector(
              onTap: () {
                if (_currentMonth < 11) {
                  setState(() => _currentMonth++);
                }
              },
              child: const Icon(Icons.chevron_right,
                  color: AppColors.darkText, size: 24),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList() {
    final groups = _filteredTransactions;

    if (groups.isEmpty) {
      return Center(
        child: Text(
          'No transactions',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: AppColors.secondary,
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      itemCount: groups.length,
      itemBuilder: (context, groupIndex) {
        final group = groups[groupIndex];
        final items = group['items'] as List;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                group['group'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                  letterSpacing: 0.25,
                  height: 1.2,
                ),
              ),
            ),
            ...items.map((item) => _buildTransactionItem(
                item as Map<String, dynamic>)),
          ],
        );
      },
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> item) {
    final bool isOut = item['isOut'] as bool;
    final Color iconBgColor = isOut
        ? AppColors.error.withValues(alpha: 0.12)
        : AppColors.success.withValues(alpha: 0.12);
    final Color iconColor = isOut ? AppColors.error : AppColors.success;
    final IconData icon =
        isOut ? Icons.arrow_upward : Icons.arrow_downward;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
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
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item['title'] as String,
                  style: GoogleFonts.poppins(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: AppColors.darkText,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  item['subtitle'] as String,
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
                item['amount'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isOut ? AppColors.error : AppColors.success,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                item['time'] as String,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: AppColors.secondary,
                  letterSpacing: 0.25,
                  height: 1.2,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
