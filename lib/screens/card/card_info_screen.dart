import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'card_freeze_screen.dart';
import 'card_pin_change_screen.dart';
import 'card_settings_screen.dart';
import 'card_reissue_virtual_screen.dart';

class CardInfoScreen extends StatefulWidget {
  const CardInfoScreen({super.key});

  @override
  State<CardInfoScreen> createState() => _CardInfoScreenState();
}

class _CardInfoScreenState extends State<CardInfoScreen> {
  bool _cvvVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF151515), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text(
          'Card Info',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            // Large dark card widget
            _CardWidget(cvvVisible: _cvvVisible, onToggleCvv: () {
              setState(() => _cvvVisible = !_cvvVisible);
            }),
            const SizedBox(height: 16),
            // Info tiles
            _InfoSection(),
            const SizedBox(height: 16),
            // Action buttons row
            _ActionButtonsRow(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _CardWidget extends StatelessWidget {
  final bool cvvVisible;
  final VoidCallback onToggleCvv;

  const _CardWidget({required this.cvvVisible, required this.onToggleCvv});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 210,
      decoration: BoxDecoration(
        color: const Color(0xFF151515),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Top row: card name + balance + mastercard logo
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Black Plastic',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFFF0EFEC),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Linked to EUR account',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: const Color(0xFF858585),
                        letterSpacing: 0.25,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '€ 4,250.00',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFFF0EFEC),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    width: 36,
                    height: 22,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const _MastercardLogo(),
                  ),
                ],
              ),
            ],
          ),
          // Middle: card number
          Text(
            '4521 8734 9012 1234',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFFF0EFEC),
              letterSpacing: 2,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          // Bottom row: expiry, cvv, holder
          Row(
            children: [
              _CardDetail(label: 'EXPIRES', value: '08/28'),
              const SizedBox(width: 20),
              _CardDetail(
                label: 'CVV',
                value: cvvVisible ? '***' : '•••',
                trailing: GestureDetector(
                  onTap: onToggleCvv,
                  child: Icon(
                    cvvVisible ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    color: const Color(0xFF858585),
                    size: 16,
                  ),
                ),
              ),
              const Spacer(),
              Flexible(
                child: Text(
                  'JOHN DOE',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFF0EFEC),
                    letterSpacing: 1,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CardDetail extends StatelessWidget {
  final String label;
  final String value;
  final Widget? trailing;

  const _CardDetail({required this.label, required this.value, this.trailing});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 10,
            color: const Color(0xFF858585),
            letterSpacing: 0.5,
          ),
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFF0EFEC),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            if (trailing != null) ...[
              const SizedBox(width: 4),
              trailing!,
            ],
          ],
        ),
      ],
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
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFFEB001B),
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: -4),
            Container(
              width: 14,
              height: 14,
              decoration: const BoxDecoration(
                color: Color(0xFFF79E1B),
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _InfoSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final items = [
      {'label': 'Card Status', 'value': 'Active', 'badge': true},
      {'label': 'Card Type', 'value': 'Virtual Mastercard', 'badge': false},
      {'label': 'Currency', 'value': 'EUR', 'badge': false},
      {'label': 'Available Balance', 'value': '€ 4,250.00', 'badge': false},
      {'label': 'Card Limit', 'value': '€ 10,000/month', 'badge': false},
    ];

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF39424D).withValues(alpha: 0.06),
            offset: const Offset(0, 4),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((e) {
          final i = e.key;
          final item = e.value;
          final isLast = i == items.length - 1;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item['label'] as String,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: const Color(0xFF858585),
                      ),
                    ),
                    (item['badge'] as bool)
                        ? Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 3),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item['value'] as String,
                              style: GoogleFonts.poppins(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF4CAF50),
                              ),
                            ),
                          )
                        : Text(
                            item['value'] as String,
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF151515),
                            ),
                          ),
                  ],
                ),
              ),
              if (!isLast)
                const Divider(
                    height: 1,
                    indent: 16,
                    endIndent: 16,
                    color: Color(0xFFF2F5F7)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _ActionButtonsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ActionBtn(
          icon: Icons.ac_unit_rounded,
          label: 'Freeze',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CardFreezeScreen())),
        ),
        const SizedBox(width: 8),
        _ActionBtn(
          icon: Icons.pin_outlined,
          label: 'Change PIN',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CardPinChangeScreen())),
        ),
        const SizedBox(width: 8),
        _ActionBtn(
          icon: Icons.settings_outlined,
          label: 'Settings',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(builder: (_) => const CardSettingsScreen())),
        ),
        const SizedBox(width: 8),
        _ActionBtn(
          icon: Icons.refresh_rounded,
          label: 'Reissue',
          onTap: () => Navigator.push(context,
              MaterialPageRoute(
                  builder: (_) => const CardReissueVirtualScreen())),
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
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF39424D).withValues(alpha: 0.06),
                offset: const Offset(0, 4),
                blurRadius: 12,
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: const Color(0xFF151515), size: 22),
              const SizedBox(height: 6),
              Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 11,
                  color: const Color(0xFF151515),
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
