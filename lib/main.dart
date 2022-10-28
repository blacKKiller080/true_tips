import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:true_tips_mobile/core/components/web_view_screen.dart';
import 'package:true_tips_mobile/core/providers/auth_provider.dart';
import 'package:true_tips_mobile/core/providers/profile_provider.dart';
import 'package:true_tips_mobile/core/providers/transaction_provider.dart';
import 'package:true_tips_mobile/core/repositories/auth_repository.dart';
import 'package:true_tips_mobile/core/repositories/profile_repository.dart';
import 'package:true_tips_mobile/core/repositories/transaction_repository.dart';
import 'package:true_tips_mobile/modules/auth/screens/login/auth_screen.dart';
import 'package:true_tips_mobile/modules/auth/screens/login/login_screen.dart';
import 'package:true_tips_mobile/modules/auth/screens/password/change_password.dart';
import 'package:true_tips_mobile/modules/auth/screens/password/restore_password_first.dart';
import 'package:true_tips_mobile/modules/auth/screens/password/restore_password_second.dart';
import 'package:true_tips_mobile/modules/auth/screens/password/restore_password_third.dart';
import 'package:true_tips_mobile/modules/auth/screens/register/register_final_screen.dart';
import 'package:true_tips_mobile/modules/auth/screens/register/register_third_screen.dart';
import 'package:true_tips_mobile/modules/auth/screens/register/register_first_screen.dart';
import 'package:true_tips_mobile/modules/auth/screens/register/register_second_screen.dart';
import 'package:true_tips_mobile/modules/auth/screens/splash/splash_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/edit_profile_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_qr_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_wallet_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/profile/profile_transaction_screen.dart';
import 'package:true_tips_mobile/modules/system/screens/system_screen.dart';
import 'core/constants/styles.dart';
import 'core/helper/navigateable.dart';
import 'core/http/api_provider.dart';
import 'core/providers/app_provider.dart';
import 'core/routes/routes.dart';
import 'modules/auth/screens/register/register_first_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(App());
  });
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    var apiProvider = ApiClient();
    var authRepository = AuthRepository(apiProvider);
    var profileRepository = ProfileRepository(apiProvider);
    var transactionRepository = TransactionRepository(apiProvider);

    var authProvider = AuthProvider(authRepository);
    var profileProvider = ProfileProvider(profileRepository);
    var transactionProvider = TransactionProvider(transactionRepository);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AppProvider>(
          create: (_) => AppProvider(),
        ),
        ChangeNotifierProvider<AuthProvider>(
          create: (_) => authProvider,
        ),
        ChangeNotifierProvider<ProfileProvider>(
          create: (_) => profileProvider,
        ),
        ChangeNotifierProvider<TransactionProvider>(
          create: (_) => transactionProvider,
        ),
      ],
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: Colors.black,
        ),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.initial,
          theme: ThemeData(
            toggleButtonsTheme: ToggleButtonsThemeData(
              borderColor: Styles.k_brand_primary_color,
              selectedBorderColor: Styles.k_brand_primary_color,
            ),
            toggleableActiveColor: Styles.k_brand_primary_color,
            fontFamily: 'Inter',
            primaryColor: Styles.k_white_color,
            disabledColor: Styles.k_disabled,
            backgroundColor: Styles.k_black_color,
            scaffoldBackgroundColor: Styles.k_black_color,
            textSelectionTheme: TextSelectionThemeData(
              cursorColor: Colors.black,
            ),
            textTheme: TextTheme(
              bodyText1: TextStyle(
                color: Colors.white,
              ),
              bodyText2: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          routes: routes(),
        ),
      ),
    );
  }
}

routes() {
  List<Navigateable> screens = generateRoutes();
  Map<String, Widget Function(BuildContext)> routes = {};
  screens.forEach((element) {
    routes[element.getName()] = (context) => element;
  });
  return routes;
}

List<Navigateable> generateRoutes() {
  return [
    SplashScreen(),
    LoginScreen(),
    ChangePasswordScreen(),
    RegisterFirstScreen(),
    RegisterSecondScreen(),
    RegisterThirdScreen(),
    RegisterFinalScreen(),
    AuthScreen(),
    RestorePasswordFirstScreen(),
    RestorePasswordSecondScreen(),
    RestorePasswordThirdScreen(),
    ProfileScreen(),
    ProfileWalletScreen(),
    ProfileTransactionScreen(),
    ProfileQrScreen(),
    SystemScreen(),
    EditProfileScreen(),
    WebViewScreen(),
  ];
}
