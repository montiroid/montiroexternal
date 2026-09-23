import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:montiro_external/page/page_dashboard.dart';
import 'package:montiro_external/page/page_emergency_detail.dart';
import 'package:montiro_external/page/page_handover.dart';
import 'package:montiro_external/page/page_qr.dart';
import 'package:montiro_external/page/page_survey_2.dart';
import 'package:montiro_external/provider/provider_dashboard.dart';
import 'package:montiro_external/provider/provider_emergency_detail.dart';
import 'package:montiro_external/provider/provider_handover.dart';
import 'package:montiro_external/provider/provider_survey_v2.dart';
import 'package:montiro_external/service/service_booking.dart';
import 'package:provider/provider.dart';
import 'package:url_strategy/url_strategy.dart';
import 'page/page_history_detail_hs.dart';
import 'page/page_pdf_attachment.dart';
import 'page/page_pdf_payment.dart';
import 'page/page_pdf_polish.dart';
import 'page/page_pdf_polish_pt.dart';
import 'provider/provider_history_detail_hs.dart';
import 'provider/provider_pdf_attachment.dart';
import 'provider/provider_pdf_payment.dart';
import 'provider/provider_pdf_polish.dart';
import 'provider/provider_pdf_polish_pt.dart';
import 'provider/provider_qr.dart';

// flutter run -d chrome
// flutter build web --release

void main() {
  setPathUrlStrategy();
  runApp(
    Phoenix(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //
    return MaterialApp.router(
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.stylus,
          PointerDeviceKind.unknown
        },
      ),
      title: 'Montiro.id',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        textTheme: GoogleFonts.openSansTextTheme(Theme.of(context).textTheme),
        scrollbarTheme: const ScrollbarThemeData().copyWith(
          thumbColor: WidgetStateProperty.all(Colors.grey[500]),
        ),
      ),
      routerConfig: GoRouter(
        routes: <RouteBase>[
          GoRoute(
            path: '/homeservice',
            name: 'homeservice',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderHomeServiceHistoryDetail(
                      int.tryParse(state.queryParams["id"] ?? "0") ?? 0,
                    ),
                  ),
                ],
                child: const PageUserHomeServiceDetail(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/handover',
            name: 'handover',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderHandover(),
                  ),
                ],
                child: PageHandover(
                  idEmergency:
                      int.tryParse(state.queryParams["id"] ?? "0") ?? 0,
                  type: int.tryParse(state.queryParams["receiver"] ?? "0") ?? 0,
                ),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/emergency',
            name: 'emergency',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderEmergencyDetail(
                      int.tryParse(state.queryParams["id"] ?? "0") ?? 0,
                    ),
                  ),
                ],
                child: const PageEmergencyDetail(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/new-survey/:uniqueId',
            name: 'newsurvey',
            pageBuilder: (context, state) {
              final uniqueId = state.params["uniqueId"] ?? "0";
              return CustomTransitionPage<void>(
                key: state.pageKey,
                transitionDuration: const Duration(seconds: 0),
                child: MultiProvider(
                  providers: [
                    ChangeNotifierProvider(
                      create: (context) =>
                          ProviderSurveyVersi2(uniqueId, apiDev),
                    ),
                  ],
                  child: const PageSurveyVersi2(),
                ),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) =>
                        FadeTransition(opacity: animation, child: child),
              );
            },
          ),
          GoRoute(
            path: '/qr-code',
            name: 'qr-code',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderQR(
                      state.queryParams["code"] ?? "",
                    ),
                  ),
                ],
                child: const PageQr(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/booking',
            name: 'booking-pdf',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderPdfAttachment(
                      state.queryParams["id"] ?? "",
                    ),
                  ),
                ],
                child: const PagePdfAttachment(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/membership/payment',
            name: 'membership-payment-pdf',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderPdfPayment(
                      state.queryParams["id"] ?? "",
                    ),
                  ),
                ],
                child: const PagePdfPayment(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/membership',
            name: 'membership-pdf',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderPdfPolish(
                      state.queryParams["id"] ?? "",
                    ),
                  ),
                ],
                child: const PagePdfPolish(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/membership-corporate',
            name: 'membership-corporate',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderPdfPolishPT(
                      state.queryParams["id"] ?? "",
                    ),
                  ),
                ],
                child: const PagePdfPolishPT(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
          GoRoute(
            path: '/dashboard',
            name: 'dashboard',
            pageBuilder: (context, state) => CustomTransitionPage<void>(
              key: state.pageKey,
              transitionDuration: const Duration(seconds: 0),
              child: MultiProvider(
                providers: [
                  ChangeNotifierProvider(
                    create: (context) => ProviderDashboard(),
                  ),
                ],
                child: const PageDashboard(),
              ),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) =>
                      FadeTransition(opacity: animation, child: child),
            ),
          ),
        ],
      ),
    );
  }
}
