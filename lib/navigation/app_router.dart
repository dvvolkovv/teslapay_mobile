import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/phone_screen.dart';
import '../screens/otp_screen.dart';
import '../screens/pin_screen.dart';
import '../screens/main/home_screen.dart';
import '../screens/main/activity_screen.dart';
import '../screens/send/send_menu_screen.dart';
import '../screens/receive/receive_menu_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/profile/personal_info_screen.dart';
import '../screens/profile/security_screen.dart';
import '../screens/profile/change_password_screen.dart';
import '../screens/profile/change_theme_screen.dart';
import '../screens/profile/change_name_screen.dart';
import '../screens/profile/change_birthday_screen.dart';
import '../screens/profile/change_address_screen.dart';
import '../screens/profile/change_email_screen.dart';
import '../screens/card/card_info_screen.dart';
import '../screens/card/card_freeze_screen.dart';
import '../screens/card/card_settings_screen.dart';
import '../screens/card/card_pin_change_screen.dart';
import '../screens/card/card_reissue_virtual_screen.dart';
import '../screens/card/card_reissue_physical_screen.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/password_recovery_screen.dart';
import '../widgets/slide_page_route.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String phone = '/phone';
  static const String otp = '/otp';
  static const String pin = '/pin';
  static const String home = '/home';
  static const String activity = '/activity';
  static const String send = '/send';
  static const String receive = '/receive';
  static const String profile = '/profile';

  // Card routes
  static const String cardInfo = '/card/info';
  static const String cardFreeze = '/card/freeze';
  static const String cardSettings = '/card/settings';
  static const String cardPinChange = '/card/pin-change';
  static const String cardReissueVirtual = '/card/reissue-virtual';
  static const String cardReissuePhysical = '/card/reissue-physical';

  // Auth routes
  static const String login = '/login';
  static const String passwordRecovery = '/password-recovery';

  // Profile routes
  static const String personalInfo = '/profile/personal-info';
  static const String security = '/profile/security';
  static const String changePassword = '/profile/change-password';
  static const String changeTheme = '/profile/theme';
  static const String changeName = '/profile/change-name';
  static const String changeBirthday = '/profile/change-birthday';
  static const String changeAddress = '/profile/change-address';
  static const String changeEmail = '/profile/change-email';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return SlidePageRoute(page: const SplashScreen());
      case phone:
        return SlidePageRoute(page: const PhoneScreen());
      case otp:
        final phone = settings.arguments as String? ?? '';
        return SlidePageRoute(page: OtpScreen(phone: phone));
      case pin:
        return SlidePageRoute(page: const PinScreen());
      case home:
        return SlidePageRoute(page: const HomeScreen());
      case activity:
        return SlidePageRoute(page: const ActivityScreen());
      case send:
        return SlidePageRoute(page: const SendMenuScreen());
      case receive:
        return SlidePageRoute(page: const ReceiveMenuScreen());
      case profile:
        return SlidePageRoute(page: const ProfileScreen());
      case personalInfo:
        return SlidePageRoute(page: const PersonalInfoScreen());
      case security:
        return SlidePageRoute(page: const SecurityScreen());
      case changePassword:
        return SlidePageRoute(page: const ChangePasswordScreen());
      case changeTheme:
        return SlidePageRoute(page: const ChangeThemeScreen());
      case changeName:
        return SlidePageRoute(page: const ChangeNameScreen());
      case changeBirthday:
        return SlidePageRoute(page: const ChangeBirthdayScreen());
      case changeAddress:
        return SlidePageRoute(page: const ChangeAddressScreen());
      case changeEmail:
        return SlidePageRoute(page: const ChangeEmailScreen());
      case cardInfo:
        return SlidePageRoute(page: const CardInfoScreen());
      case cardFreeze:
        return SlidePageRoute(page: const CardFreezeScreen());
      case cardSettings:
        return SlidePageRoute(page: const CardSettingsScreen());
      case cardPinChange:
        return SlidePageRoute(page: const CardPinChangeScreen());
      case cardReissueVirtual:
        return SlidePageRoute(page: const CardReissueVirtualScreen());
      case cardReissuePhysical:
        return SlidePageRoute(page: const CardReissuePhysicalScreen());
      case login:
        return SlidePageRoute(page: const LoginScreen());
      case passwordRecovery:
        return SlidePageRoute(page: const PasswordRecoveryScreen());

      default:
        return SlidePageRoute(
          page: Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
