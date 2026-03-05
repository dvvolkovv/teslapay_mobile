import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrReceiveScreen extends StatefulWidget {
  const QrReceiveScreen({super.key});

  @override
  State<QrReceiveScreen> createState() => _QrReceiveScreenState();
}

class _QrReceiveScreenState extends State<QrReceiveScreen> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _saveQr() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'QR code saved to gallery',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF151515),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _shareQr() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Sharing QR code...',
          style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF151515),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F5F7),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F5F7),
        elevation: 0,
        leading: BackButton(color: const Color(0xFF151515)),
        title: Text(
          'Receive via QR',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF151515),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // QR Code card
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 24),
              child: Column(
                children: [
                  // QR code placeholder
                  Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: const Color(0xFFF2F5F7), width: 2),
                    ),
                    child: CustomPaint(
                      painter: _QrPatternPainter(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Alexander Smith',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF151515),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '+49 123 456 7890',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color(0xFF858585),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Amount field (optional)
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: TextField(
                controller: _amountController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF151515),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Enter amount to receive (optional)',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 14,
                    color: const Color(0xFF858585),
                  ),
                  prefixIcon: const Icon(Icons.euro_rounded,
                      color: Color(0xFF858585), size: 20),
                ),
                cursorColor: const Color(0xFFFFBA08),
              ),
            ),
            const SizedBox(height: 24),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: _QrActionButton(
                    icon: Icons.download_rounded,
                    label: 'Save QR',
                    onTap: _saveQr,
                    isPrimary: false,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _QrActionButton(
                    icon: Icons.share_rounded,
                    label: 'Share',
                    onTap: _shareQr,
                    isPrimary: true,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _QrPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF151515)
      ..style = PaintingStyle.fill;

    final cellSize = size.width / 25;
    // Simplified QR pattern — finder patterns in three corners
    final finderPositions = [
      const Offset(0, 0),
      const Offset(18, 0),
      const Offset(0, 18),
    ];
    for (final pos in finderPositions) {
      // Outer square (7x7)
      canvas.drawRect(
        Rect.fromLTWH(
            pos.dx * cellSize, pos.dy * cellSize, 7 * cellSize, 7 * cellSize),
        paint,
      );
      final innerPaint = Paint()
        ..color = Colors.white
        ..style = PaintingStyle.fill;
      canvas.drawRect(
        Rect.fromLTWH(
            (pos.dx + 1) * cellSize,
            (pos.dy + 1) * cellSize,
            5 * cellSize,
            5 * cellSize),
        innerPaint,
      );
      canvas.drawRect(
        Rect.fromLTWH(
            (pos.dx + 2) * cellSize,
            (pos.dy + 2) * cellSize,
            3 * cellSize,
            3 * cellSize),
        paint,
      );
    }

    // Random data modules for visual effect
    final dataCells = [
      [9, 0], [11, 0], [13, 0], [15, 0], [17, 0],
      [9, 2], [10, 2], [13, 2], [16, 2],
      [9, 4], [12, 4], [14, 4], [17, 4],
      [9, 6], [10, 6], [15, 6], [17, 6],
      [0, 9], [2, 9], [5, 9], [8, 9], [10, 9], [13, 9], [15, 9], [17, 9],
      [1, 10], [3, 10], [6, 10], [9, 10], [12, 10], [16, 10],
      [0, 11], [4, 11], [7, 11], [10, 11], [14, 11], [17, 11],
      [2, 12], [5, 12], [8, 12], [11, 12], [13, 12], [16, 12],
      [1, 13], [3, 13], [6, 13], [9, 13], [12, 13], [15, 13],
      [0, 14], [4, 14], [7, 14], [10, 14], [14, 14], [17, 14],
      [2, 15], [5, 15], [8, 15], [11, 15], [13, 15], [16, 15],
      [1, 16], [3, 16], [6, 16], [9, 16], [12, 16], [15, 16],
      [0, 17], [4, 17], [7, 17], [10, 17], [14, 17], [17, 17],
      [9, 18], [11, 18], [14, 18], [16, 18],
      [10, 19], [12, 19], [15, 19], [17, 19],
      [9, 20], [11, 20], [13, 20], [16, 20],
      [10, 21], [14, 21], [17, 21],
      [9, 22], [12, 22], [15, 22],
      [10, 23], [13, 23], [16, 23],
      [9, 24], [11, 24], [14, 24], [17, 24],
    ];

    for (final cell in dataCells) {
      if (cell[0] < 25 && cell[1] < 25) {
        canvas.drawRect(
          Rect.fromLTWH(
            cell[0] * cellSize,
            cell[1] * cellSize,
            cellSize,
            cellSize,
          ),
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _QrActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QrActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    required this.isPrimary,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isPrimary ? const Color(0xFFFFBA08) : Colors.white,
          borderRadius: BorderRadius.circular(50),
          border: isPrimary ? null : Border.all(color: const Color(0xFFA5B1BC)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 18, color: const Color(0xFF151515)),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
