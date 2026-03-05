import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QrScanScreen extends StatefulWidget {
  const QrScanScreen({super.key});

  @override
  State<QrScanScreen> createState() => _QrScanScreenState();
}

class _QrScanScreenState extends State<QrScanScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanLineController;
  late Animation<double> _scanLineAnimation;

  @override
  void initState() {
    super.initState();
    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _scanLineAnimation = CurvedAnimation(
      parent: _scanLineController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scanLineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF151515),
      body: SafeArea(
        child: Column(
          children: [
            // Top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    'Scan QR Code',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(width: 40),
                ],
              ),
            ),
            const SizedBox(height: 32),
            // Subtitle
            Text(
              'Point your camera at the QR code',
              style: GoogleFonts.poppins(
                fontSize: 15,
                color: Colors.white.withValues(alpha: 0.7),
              ),
            ),
            const SizedBox(height: 48),
            // Camera view area
            Center(
              child: SizedBox(
                width: 280,
                height: 280,
                child: Stack(
                  children: [
                    // Dark rounded box simulating camera
                    Container(
                      width: 280,
                      height: 280,
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    // Corner brackets
                    const Positioned(
                      top: 0,
                      left: 0,
                      child: _Corner(corner: _CornerType.topLeft),
                    ),
                    const Positioned(
                      top: 0,
                      right: 0,
                      child: _Corner(corner: _CornerType.topRight),
                    ),
                    const Positioned(
                      bottom: 0,
                      left: 0,
                      child: _Corner(corner: _CornerType.bottomLeft),
                    ),
                    const Positioned(
                      bottom: 0,
                      right: 0,
                      child: _Corner(corner: _CornerType.bottomRight),
                    ),
                    // Animated scan line
                    AnimatedBuilder(
                      animation: _scanLineAnimation,
                      builder: (_, child) {
                        return Positioned(
                          left: 20,
                          right: 20,
                          top: 20 + (_scanLineAnimation.value * (280 - 40)),
                          child: Container(
                            height: 2,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  const Color(0xFFFFBA08).withValues(alpha: 0.8),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    // Center QR icon placeholder
                    Center(
                      child: Icon(
                        Icons.qr_code_2_rounded,
                        size: 80,
                        color: Colors.white.withValues(alpha: 0.15),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            // Enter manually button
            GestureDetector(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => _ManualEntrySheet(),
                );
              },
              child: Text(
                'Enter manually',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: const Color(0xFFFFBA08),
                  decoration: TextDecoration.underline,
                  decorationColor: const Color(0xFFFFBA08),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}

enum _CornerType { topLeft, topRight, bottomLeft, bottomRight }

class _Corner extends StatelessWidget {
  final _CornerType corner;
  const _Corner({super.key, required this.corner}); // ignore: unused_element_parameter

  @override
  Widget build(BuildContext context) {
    const size = 40.0;
    const thickness = 4.0;
    const radius = 10.0;
    const color = Color(0xFFFFBA08);

    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: _CornerPainter(
          corner: corner,
          color: color,
          thickness: thickness,
          radius: radius,
        ),
      ),
    );
  }
}

class _CornerPainter extends CustomPainter {
  final _CornerType corner;
  final Color color;
  final double thickness;
  final double radius;

  const _CornerPainter({
    required this.corner,
    required this.color,
    required this.thickness,
    required this.radius,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();
    switch (corner) {
      case _CornerType.topLeft:
        path.moveTo(0, size.height);
        path.lineTo(0, radius);
        path.arcToPoint(Offset(radius, 0),
            radius: Radius.circular(radius), clockwise: true);
        path.lineTo(size.width, 0);
        break;
      case _CornerType.topRight:
        path.moveTo(0, 0);
        path.lineTo(size.width - radius, 0);
        path.arcToPoint(Offset(size.width, radius),
            radius: Radius.circular(radius), clockwise: true);
        path.lineTo(size.width, size.height);
        break;
      case _CornerType.bottomLeft:
        path.moveTo(0, 0);
        path.lineTo(0, size.height - radius);
        path.arcToPoint(Offset(radius, size.height),
            radius: Radius.circular(radius), clockwise: false);
        path.lineTo(size.width, size.height);
        break;
      case _CornerType.bottomRight:
        path.moveTo(size.width, 0);
        path.lineTo(size.width, size.height - radius);
        path.arcToPoint(Offset(size.width - radius, size.height),
            radius: Radius.circular(radius), clockwise: true);
        path.lineTo(0, size.height);
        break;
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(_CornerPainter old) => false;
}

class _ManualEntrySheet extends StatefulWidget {
  @override
  State<_ManualEntrySheet> createState() => _ManualEntrySheetState();
}

class _ManualEntrySheetState extends State<_ManualEntrySheet> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF2F5F7),
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter address manually',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF151515),
              ),
            ),
            const SizedBox(height: 16),
            Container(
              height: 58,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _ctrl,
                autofocus: true,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: const Color(0xFF151515),
                ),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  isCollapsed: true,
                  hintText: 'Phone, email or TeslaPay ID',
                  hintStyle: GoogleFonts.poppins(
                    fontSize: 16,
                    color: const Color(0xFF858585),
                  ),
                ),
                cursorColor: const Color(0xFFFFBA08),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                height: 58,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFBA08),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    'SEARCH',
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
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
