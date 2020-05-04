import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

import 'common/crash_reporting/crash_report.dart';
import 'common/crash_reporting/crash_report_app_runner.dart';
import 'data/models/language.dart';
import 'data/repo/book_repository.dart';
import 'data/repo/language_repository.dart';
import 'data/service/api_service.dart';
import 'features/main/main.dart';
import 'features/main_app/bloc/language_bloc.dart';
import 'features/main_app/bloc/language_state.dart';
import 'generated/l10n.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  init();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final LanguageRepository languageRepository = LanguageRepository();
  final Language initLanguage = await languageRepository.getCurrentLanguage();
  MyApp myApp =
      MyApp(languageBloc: LanguageBloc(initLanguage, languageRepository));
  CrashReportAppRunner().startApp(myApp);
}

void init() {
  Intl.defaultLocale = 'en_US';
}

class MyApp extends StatefulWidget {
  final LanguageBloc languageBloc;

  MyApp({@required this.languageBloc});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<LanguageBloc>.value(
      child: BlocBuilder<LanguageBloc, LanguageState>(
          builder: (BuildContext context, LanguageState state) {
        return RepositoryProvider(
          create: (BuildContext context) {
            return BookRepository(apiServiceInstance);
          },
          child: App(languageState: state),
        );
      }),
      value: widget.languageBloc,
    );
  }
}

class App extends StatefulWidget {
  final LanguageState languageState;

  const App({Key key, this.languageState}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      //TODO do something when resumed from background
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Book Library",
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      initialRoute: MainScreen.screenName,
      routes: {
        MainScreen.screenName: (context) => MainScreen(),
      },
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        S.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      locale: mapLocale(widget.languageState.language),
    );
  }

  Locale mapLocale(Language currentLanguage) {
    if (currentLanguage == Language.vietnamese) {
      return Locale("vi", "");
    } else {
      return Locale("en", "");
    }
  }
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('$error, $stacktrace');
    CrashReport.getInstance()
        .reportError(exception: error, stackTrace: stacktrace);
  }

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print(event);
    CrashReport.getInstance().addBlocEvent(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
    CrashReport.getInstance().addBlocTransaction(transition);
  }
}
