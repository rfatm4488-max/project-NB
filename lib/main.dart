import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'l10n/app_localizations.dart';
import 'providers/journal_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => JournalProvider(),
      child: Consumer<JournalProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            locale: provider.locale,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            title: 'مفكرتي',
            themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
            theme: ThemeData(
              brightness: Brightness.light,
              primaryColor: const Color(0xFF1E3A8A), // Dark blue
              scaffoldBackgroundColor: Colors.white,
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF1E3A8A),
                brightness: Brightness.light,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Color(0xFF1E3A8A),
                foregroundColor: Colors.white,
                elevation: 0,
              ),
              cardTheme: const CardThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                color: Colors.white,
                elevation: 4,
              ),
              textTheme: GoogleFonts.tajawalTextTheme(
                ThemeData.light().textTheme,
              ).apply(
                fontFamilyFallback: const [
                  'NotoColorEmoji',
                  'Segoe UI Emoji',
                  'Apple Color Emoji',
                ],
              ).copyWith(
                bodyLarge: GoogleFonts.tajawal(color: Colors.black87),
                bodyMedium: GoogleFonts.tajawal(color: Colors.black87),
                titleLarge: GoogleFonts.tajawal(color: Colors.black87),
                titleMedium: GoogleFonts.tajawal(color: Colors.black87),
                headlineMedium: GoogleFonts.tajawal(color: Colors.black87),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            darkTheme: ThemeData(
              brightness: Brightness.dark,
              primaryColor: const Color(0xFF4F46E5),
              scaffoldBackgroundColor: const Color(0xFF121212),
              cardTheme: const CardThemeData(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                color: const Color(0xFF1E1E1E),
                elevation: 4,
              ),
              textTheme: GoogleFonts.tajawalTextTheme(
                ThemeData.dark().textTheme,
              ).apply(
                fontFamilyFallback: const [
                  'NotoColorEmoji',
                  'Segoe UI Emoji',
                  'Apple Color Emoji',
                ],
              ).copyWith(
                bodyLarge: GoogleFonts.tajawal(color: Colors.white),
                bodyMedium: GoogleFonts.tajawal(color: Colors.white70),
                titleLarge: GoogleFonts.tajawal(color: Colors.white),
                titleMedium: GoogleFonts.tajawal(color: Colors.white),
                headlineMedium: GoogleFonts.tajawal(color: Colors.white),
              ),
              inputDecorationTheme: InputDecorationTheme(
                filled: true,
                fillColor: const Color(0xFF1F1F1F),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            home: const HomeScreen(),
          );
        },
      ),
    );
  }
}
