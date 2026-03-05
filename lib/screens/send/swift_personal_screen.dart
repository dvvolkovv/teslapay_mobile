import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SwiftPersonalScreen extends StatefulWidget {
  const SwiftPersonalScreen({super.key});

  @override
  State<SwiftPersonalScreen> createState() => _SwiftPersonalScreenState();
}

class _SwiftPersonalScreenState extends State<SwiftPersonalScreen> {
  final _recipientNameCtrl = TextEditingController();
  final _ibanCtrl = TextEditingController();
  final _swiftCtrl = TextEditingController();
  final _bankNameCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  final _purposeCtrl = TextEditingController();
  String _selectedCurrency = 'EUR';
  String? _selectedCountry;

  final List<String> _currencies = ['EUR', 'USD', 'GBP', 'CHF'];
  final List<String> _countries = [
    'Germany', 'France', 'Italy', 'Spain', 'Netherlands',
    'Austria', 'Switzerland', 'United States', 'United Kingdom',
    'Russia', 'China', 'Japan', 'Australia',
  ];

  bool get _canContinue =>
      _recipientNameCtrl.text.isNotEmpty &&
      _ibanCtrl.text.isNotEmpty &&
      _swiftCtrl.text.isNotEmpty &&
      _amountCtrl.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    _recipientNameCtrl.addListener(() => setState(() {}));
    _ibanCtrl.addListener(() => setState(() {}));
    _swiftCtrl.addListener(() => setState(() {}));
    _bankNameCtrl.addListener(() => setState(() {}));
    _amountCtrl.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _recipientNameCtrl.dispose();
    _ibanCtrl.dispose();
    _swiftCtrl.dispose();
    _bankNameCtrl.dispose();
    _amountCtrl.dispose();
    _purposeCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'SWIFT Transfer',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              '1/6',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF858585),
              ),
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(2),
          child: Stack(
            children: [
              Container(height: 2, color: const Color(0xFFDEE5F2)),
              FractionallySizedBox(
                widthFactor: 1 / 6,
                child: Container(height: 2, color: const Color(0xFFFFBA08)),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const SizedBox(height: 8),
            // Currency selector row
            Container(
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(
                    'Currency',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF858585),
                    ),
                  ),
                  const Spacer(),
                  ..._currencies.map((c) {
                    final selected = c == _selectedCurrency;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedCurrency = c),
                      child: Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected
                              ? const Color(0xFFFFBA08)
                              : const Color(0xFFEBEFF2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          c,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: const Color(0xFF151515),
                          ),
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _recipientNameCtrl,
              label: 'Recipient Name',
              hint: 'John Doe',
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _ibanCtrl,
              label: 'IBAN / Account Number',
              hint: 'DE89 3704 0044 0532 0130 00',
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _swiftCtrl,
              label: 'SWIFT / BIC',
              hint: 'DEUTDEDB',
              textCapitalization: TextCapitalization.characters,
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _bankNameCtrl,
              label: 'Bank Name',
              hint: 'Deutsche Bank',
            ),
            const SizedBox(height: 12),
            // Country dropdown
            GestureDetector(
              onTap: () async {
                final result = await showModalBottomSheet<String>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => _CountryPickerSheet(
                    countries: _countries,
                    selected: _selectedCountry,
                  ),
                );
                if (result != null) {
                  setState(() => _selectedCountry = result);
                }
              },
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedCountry ?? 'Country',
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: _selectedCountry != null
                              ? const Color(0xFF151515)
                              : const Color(0xFF858585),
                        ),
                      ),
                    ),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF858585),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _amountCtrl,
              label: 'Amount',
              hint: '0.00',
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              prefix: _selectedCurrency == 'EUR'
                  ? '€ '
                  : _selectedCurrency == 'USD'
                      ? '\$ '
                      : '$_selectedCurrency ',
            ),
            const SizedBox(height: 12),
            _buildInput(
              controller: _purposeCtrl,
              label: 'Purpose of payment',
              hint: 'Optional',
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'The transaction chain may occur several banks.\nThe time of a transaction may take up to 3 working days.',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: const Color(0xFF858585),
                  height: 1.4,
                ),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: _canContinue
                  ? () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Proceeding to account details...',
                            style: GoogleFonts.poppins(fontSize: 14),
                          ),
                          backgroundColor: const Color(0xFF151515),
                        ),
                      );
                    }
                  : null,
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: _canContinue
                      ? const Color(0xFFFFBA08)
                      : const Color(0xFFFFBA08).withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'PROCEED TO ACCOUNT DETAILS',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _canContinue
                          ? const Color(0xFF151515)
                          : const Color(0xFFD68803),
                      letterSpacing: 0.32,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildInput({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? prefix,
  }) {
    return Container(
      height: 58,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (controller.text.isNotEmpty)
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: const Color(0xFF858585),
                letterSpacing: 0.25,
              ),
            ),
          Row(
            children: [
              if (prefix != null && controller.text.isNotEmpty)
                Text(
                  prefix,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF151515),
                  ),
                ),
              Expanded(
                child: TextField(
                  controller: controller,
                  keyboardType: keyboardType,
                  textCapitalization: textCapitalization,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF151515),
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    isCollapsed: true,
                    hintText: controller.text.isEmpty ? label : hint,
                    hintStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color(0xFF858585),
                    ),
                  ),
                  cursorColor: const Color(0xFFFFBA08),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CountryPickerSheet extends StatefulWidget {
  final List<String> countries;
  final String? selected;

  const _CountryPickerSheet({
    required this.countries,
    this.selected,
  });

  @override
  State<_CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<_CountryPickerSheet> {
  final _searchCtrl = TextEditingController();
  late List<String> _filtered;

  @override
  void initState() {
    super.initState();
    _filtered = widget.countries;
    _searchCtrl.addListener(() {
      final q = _searchCtrl.text.toLowerCase();
      setState(() {
        _filtered = q.isEmpty
            ? widget.countries
            : widget.countries
                .where((c) => c.toLowerCase().contains(q))
                .toList();
      });
    });
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Color(0xFFF2F5F7),
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: const Color(0xFFA5B1BC),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Select Country',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF151515),
            ),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Color(0xFFA5B1BC), size: 20),
                  const SizedBox(width: 8),
                  Expanded(
                    child: TextField(
                      controller: _searchCtrl,
                      style: GoogleFonts.poppins(
                          fontSize: 14, color: const Color(0xFF151515)),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        isCollapsed: true,
                        hintText: 'Search',
                        hintStyle: GoogleFonts.poppins(
                            fontSize: 14, color: const Color(0xFFA5B1BC)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _filtered.length,
              itemBuilder: (ctx, i) {
                final country = _filtered[i];
                final isSelected = country == widget.selected;
                return ListTile(
                  onTap: () => Navigator.of(context).pop(country),
                  title: Text(
                    country,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      color: const Color(0xFF151515),
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check_rounded,
                          color: Color(0xFFFFBA08))
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
