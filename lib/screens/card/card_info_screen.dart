import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_pin_change_screen.dart';
import 'card_settings_screen.dart';
import 'card_reissue_virtual_screen.dart';

class CardInfoScreen extends StatefulWidget {
  const CardInfoScreen({super.key});

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      appBar: AppBar(
        backgroundColor: const Color(0xFF151515),
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Black Plastic',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFF0EFEC),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFFF0EFEC), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.close_rounded,
                color: Color(0xFFF0EFEC), size: 22),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card preview widget
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: _CardPreview(),
            ),
            const SizedBox(height: 20),
            // Action buttons row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ActionButtonsRow(context: context),
            ),
            const SizedBox(height: 24),
            // Activity section header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Activity in July',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFF0EFEC),
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        '45 417.24 EUR',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: const Color(0xFFFFBA08),
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFFFFBA08), size: 18),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            // Progress bar (colored)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _ActivityProgressBar(),
            ),
            const SizedBox(height: 20),
            // Transactions
            _TransactionGroup(
              date: 'Today',
              transactions: const [
                _TxItem(title: 'Incoming', subtitle: 'Premium Grey',
                    amount: '- 120.0 USD', isOut: true),
                _TxItem(title: 'Incoming', subtitle: 'Black Plastic',
                    amount: '+ 120.0 USD', isOut: false),
              ],
            ),
            _TransactionGroup(
              date: '27 July',
              transactions: const [
                _TxItem(title: 'Incoming', subtitle: 'Premium Grey',
                    amount: '- 120.0 USD', isOut: true),
                _TxItem(title: 'Incoming', subtitle: 'Black Plastic',
                    amount: '+ 120.0 USD', isOut: false),
              ],
            ),
            _TransactionGroup(
              date: '26 July',
              transactions: const [
                _TxItem(title: 'Incoming', subtitle: 'Premium Grey',
                    amount: '- 120.0 USD', isOut: true),
                _TxItem(title: 'Incoming', subtitle: 'Black Plastic',
                    amount: '+ 120.0 USD', isOut: false),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

class _CardPreview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2B2B),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top row: card name + balance + mastercard
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Black Plastic',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFFF0EFEC),
                    ),
                  ),
                  Text(
                    'Linked to EUR account',
                    style: GoogleFonts.poppins(
                      fontSize: 11,
                      color: const Color(0xFF858585),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Text(
                    '0 EUR',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFFF0EFEC),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 32,
                    height: 20,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: const _MastercardLogo(),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Card last 4 digits + card info link
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '• 1234',
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFFF0EFEC),
                  letterSpacing: 2,
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  'card info',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: const Color(0xFF858585),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MastercardLogo extends StatelessWidget {
  const _MastercardLogo();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
            Transform.translate(
              offset: const Offset(-4, 0),
              child: Container(
                width: 12,
                height: 12,
                decoration: const BoxDecoration(
                  color: Color(0xFFF79E1B),
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  final BuildContext context;
  const _ActionButtonsRow({required this.context});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionBtn(
          icon: Icons.pin_outlined,
          label: 'Pin-code',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CardPinChangeScreen())),
        ),
        const SizedBox(width: 8),
        _ActionBtn(
          icon: Icons.refresh_rounded,
          label: 'Reissue',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(
                  builder: (_) => const CardReissueVirtualScreen())),
        ),
        const SizedBox(width: 8),
        _ActionBtn(
          icon: Icons.ac_unit_rounded,
          label: 'Freeze',
          onTap: () => showDialog(
            context: context,
            builder: (_) => AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16)),
              backgroundColor: Colors.white,
              title: Text(
                'Freeze the card?',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF151515),
                ),
              ),
              content: Text(
                'It will not be available for using',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF858585),
                ),
              ),
              actionsAlignment: MainAxisAlignment.spaceEvenly,
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Freeze',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4E9AF1),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('Cancel',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF4E9AF1),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        _ActionBtn(
          icon: Icons.settings_outlined,
          label: 'Settings',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CardSettingsScreen())),
        ),
      ],
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _ActionBtn(
      {required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF2C2B2B),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFFF0EFEC), size: 22),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFFF0EFEC),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActivityProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        height: 4,
        child: Row(
          children: [
            Expanded(flex: 40, child: Container(color: const Color(0xFF4E9AF1))),
            Expanded(flex: 20, child: Container(color: const Color(0xFFFFBA08))),
            Expanded(flex: 15, child: Container(color: const Color(0xFF4CAF50))),
            Expanded(flex: 15, child: Container(color: const Color(0xFFFF5722))),
            Expanded(flex: 10, child: Container(color: const Color(0xFF9C27B0))),
          ],
        ),
      ),
    );
  }
}

class _TransactionGroup extends StatelessWidget {
  final String date;
  final List<_TxItem> transactions;

  const _TransactionGroup(
      {required this.date, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF0EFEC),
            ),
          ),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFF2C2B2B),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: transactions.asMap().entries.map((e) {
                final isLast = e.key == transactions.length - 1;
                return Column(
                  children: [
                    _buildTxRow(e.value),
                    if (!isLast)
                      Divider(
                        height: 1,
                        color: const Color(0xFF151515).withValues(alpha: 0.5),
                        indent: 48,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTxRow(_TxItem tx) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: const Color(0xFF151515),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              tx.isOut ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
              color: tx.isOut ? const Color(0xFFFF5722) : const Color(0xFF4CAF50),
              size: 16,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tx.title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFFF0EFEC),
                  ),
                ),
                Text(
                  tx.subtitle,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: const Color(0xFF858585),
                  ),
                ),
              ],
            ),
          ),
          Text(
            tx.amount,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: tx.isOut ? const Color(0xFFFF5722) : const Color(0xFF4CAF50),
            ),
          ),
        ],
      ),
    );
  }
}

class _TxItem {
  final String title;
  final String subtitle;
  final String amount;
  final bool isOut;

  const _TxItem({
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.isOut,
  });
}
