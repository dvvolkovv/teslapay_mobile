import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeBirthdayScreen extends StatefulWidget {
  const ChangeBirthdayScreen({super.key});

  @override
  State<ChangeBirthdayScreen> createState() => _ChangeBirthdayScreenState();
}

class _ChangeBirthdayScreenState extends State<ChangeBirthdayScreen> {
  DateTime _selectedDate = DateTime(1990, 3, 15);

  static const List<String> _months = [
    'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December',
  ];

  int get _daysInMonth =>
      DateUtils.getDaysInMonth(_selectedDate.year, _selectedDate.month);

  void _save() {
    Navigator.of(context).pop();
  }

  String _formattedDate() {
    return '${_selectedDate.day} ${_months[_selectedDate.month - 1]} ${_selectedDate.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded,
              color: Color(0xFF151515), size: 20),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Date of Birth',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date of Birth',
              style: GoogleFonts.poppins(
                fontSize: 28,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              _formattedDate(),
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: const Color(0xFFFFBA08),
                height: 1.2,
              ),
            ),
            const SizedBox(height: 24),

            // Three-column dropdowns: Day / Month / Year
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Row(
                children: [
                  // Day
                  Expanded(
                    child: _PickerColumn(
                      label: 'Day',
                      items: List.generate(_daysInMonth, (i) => '${i + 1}'),
                      selectedIndex: _selectedDate.day - 1,
                      onChanged: (i) {
                        setState(() {
                          _selectedDate = DateTime(
                            _selectedDate.year,
                            _selectedDate.month,
                            i + 1,
                          );
                        });
                      },
                    ),
                  ),
                  Container(width: 1, height: 180, color: const Color(0xFFF2F5F7)),
                  // Month
                  Expanded(
                    flex: 2,
                    child: _PickerColumn(
                      label: 'Month',
                      items: _months,
                      selectedIndex: _selectedDate.month - 1,
                      onChanged: (i) {
                        final newDay = _selectedDate.day.clamp(
                            1, DateUtils.getDaysInMonth(_selectedDate.year, i + 1));
                        setState(() {
                          _selectedDate = DateTime(
                            _selectedDate.year,
                            i + 1,
                            newDay,
                          );
                        });
                      },
                    ),
                  ),
                  Container(width: 1, height: 180, color: const Color(0xFFF2F5F7)),
                  // Year
                  Expanded(
                    child: _PickerColumn(
                      label: 'Year',
                      items: List.generate(
                          100, (i) => '${DateTime.now().year - i}'),
                      selectedIndex:
                          (DateTime.now().year - _selectedDate.year).clamp(0, 99),
                      onChanged: (i) {
                        final year = DateTime.now().year - i;
                        final newDay = _selectedDate.day.clamp(
                            1, DateUtils.getDaysInMonth(year, _selectedDate.month));
                        setState(() {
                          _selectedDate = DateTime(
                            year,
                            _selectedDate.month,
                            newDay,
                          );
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            const Spacer(),
            GestureDetector(
              onTap: _save,
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBA08),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'SAVE',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF151515),
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
}

class _PickerColumn extends StatefulWidget {
  final String label;
  final List<String> items;
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const _PickerColumn({
    required this.label,
    required this.items,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  State<_PickerColumn> createState() => _PickerColumnState();
}

class _PickerColumnState extends State<_PickerColumn> {
  late FixedExtentScrollController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = FixedExtentScrollController(initialItem: widget.selectedIndex);
  }

  @override
  void didUpdateWidget(_PickerColumn old) {
    super.didUpdateWidget(old);
    if (old.selectedIndex != widget.selectedIndex) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_ctrl.hasClients) {
          _ctrl.animateToItem(
            widget.selectedIndex,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: CupertinoPicker(
        scrollController: _ctrl,
        itemExtent: 36,
        selectionOverlay: const CupertinoPickerDefaultSelectionOverlay(
          background: Color(0x1AFFBA08),
        ),
        onSelectedItemChanged: widget.onChanged,
        children: widget.items
            .map(
              (item) => Center(
                child: Text(
                  item,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF151515),
                  ),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
