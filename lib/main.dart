import 'dart:async';
import 'dart:io';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _preloadSplashBackground();
  runApp(const App());
}

Future<void> _preloadSplashBackground() {
  final completer = Completer<void>();
  final stream = const AssetImage(AppBranding.splashBackgroundAsset)
      .resolve(const ImageConfiguration());
  late final ImageStreamListener listener;
  listener = ImageStreamListener(
    (_, __) {
      stream.removeListener(listener);
      completer.complete();
    },
    onError: (Object error, StackTrace? stackTrace) {
      stream.removeListener(listener);
      FlutterError.reportError(FlutterErrorDetails(
        exception: error,
        stack: stackTrace,
        library: 'splash background image preloading',
      ));
      completer.complete();
    },
  );
  stream.addListener(listener);
  return completer.future;
}

const blue = Color(0xFF0B4AA8),
    navy = Color(0xFF08306F),
    gold = Color(0xFFF5B81C);

class AppBranding {
  static const name = 'CMUnity';
  static const tagline = 'Connect · Share · Learn';
  static const String logoAsset = 'assets/images/cmuLogo.png';
  static const splashBackgroundAsset = 'assets/images/splash_bg.png';
}

class AppState {
  static final dark = ValueNotifier<bool>(false);
  static final notifications = ValueNotifier<bool>(true);
  static final bm = ValueNotifier<Set<String>>(
      {'Introduction to Psychology', 'Database Systems'});
  static void toggleBm(String t) {
    final s = {...bm.value};
    s.contains(t) ? s.remove(t) : s.add(t);
    bm.value = s;
  }
}

class Mat {
  final String t, m, cat, content;
  final String? collegeCode;
  const Mat(this.t, this.m, this.cat, this.content, {this.collegeCode});
}

const mats = [
  Mat(
    'Data Structures',
    'Study notes',
    'Computer Science',
    '''Data structures organize information so programs can access and update it efficiently.

Arrays store items in consecutive positions and provide fast access by index. Linked lists connect nodes using references; they support flexible insertion and deletion but require traversal to find an item.

Stacks follow last-in, first-out order. Common examples include undo history and function calls. Queues follow first-in, first-out order and are useful for task scheduling and breadth-first search.

Trees represent hierarchical relationships. A binary search tree keeps smaller values to the left and larger values to the right. Hash tables use a hash function to map keys to positions, usually providing fast average-case lookup.

When choosing a structure, consider the operations your program performs most often: lookup, insertion, deletion, ordering, or traversal.''',
    collegeCode: 'CCS',
  ),
  Mat(
    'Advanced Algorithms',
    'Study notes',
    'Computer Science',
    '''Algorithm analysis estimates how runtime and memory use grow as input size increases. Big O notation describes an upper bound on growth while ignoring constants and lower-order terms.

Binary search runs in O(log n) time on sorted data because each comparison removes about half of the remaining search space. Merge sort divides a collection, sorts each half, and merges the results in O(n log n) time.

Graph algorithms solve problems involving connected entities. Breadth-first search explores by distance from a starting node and can find shortest paths in unweighted graphs. Dijkstra's algorithm finds shortest paths with non-negative edge weights.

Dynamic programming applies when a problem has overlapping subproblems and optimal substructure. Store results of smaller subproblems to avoid recalculating them. Greedy algorithms make a locally best choice at each step and require a proof that those choices lead to a global optimum.

To compare approaches, identify input constraints, required output, time complexity, and memory limits.''',
    collegeCode: 'CCS',
  ),
  Mat(
    'Machine Learning Basics',
    'Study notes',
    'IT',
    '''Machine learning uses examples to build a model that makes predictions or decisions. In supervised learning, examples include known answers. Classification predicts a category, while regression predicts a numeric value.

Unsupervised learning looks for structure in data without supplied answers. Clustering groups similar examples, and dimensionality reduction summarizes data using fewer features.

A dataset is commonly divided into training, validation, and test sets. The model learns from training data; validation data helps select settings; test data estimates performance on unseen examples.

Overfitting happens when a model learns training examples too closely and performs poorly on new data. More representative data, simpler models, regularization, and cross-validation can help reduce it.

Before training, inspect data quality, handle missing values thoughtfully, and keep information from the test set out of the training process. Select evaluation metrics that match the task and its consequences.''',
    collegeCode: 'CCS',
  ),
  Mat(
    'Database Systems',
    'Study notes',
    'IT',
    '''A relational database stores data in tables made of rows and columns. A primary key uniquely identifies each row. A foreign key links a row to a related row in another table.

Normalization organizes tables to reduce duplicated data and update anomalies. First normal form requires atomic values and no repeating groups. Second normal form removes partial dependencies on part of a composite key. Third normal form removes dependencies on non-key attributes.

SQL retrieves and changes relational data. SELECT chooses columns, WHERE filters rows, JOIN combines related tables, and GROUP BY aggregates rows. Use parameterized queries in applications rather than constructing SQL from raw user input.

Transactions group related operations into a unit. ACID describes important transaction properties: atomicity, consistency, isolation, and durability.

Indexes can speed up lookups and sorting, but they consume storage and can slow writes. Add indexes based on query patterns and verify their impact with query plans.''',
    collegeCode: 'CCS',
  ),
  Mat(
      'Introduction to Psychology',
      'Study notes',
      'Health Sciences',
      '''Psychology is the scientific study of behavior and mental processes. Researchers use observation, experiments, surveys, and other methods to develop and evaluate explanations.

Learning describes relatively lasting changes in behavior or knowledge through experience. Classical conditioning links two stimuli; operant conditioning links behavior with its consequences. Reinforcement makes a behavior more likely, while punishment makes it less likely.

Memory includes encoding, storage, and retrieval. Attention and prior knowledge influence what is encoded. Retrieval practice and spaced study can support long-term retention more effectively than rereading alone.

Developmental psychology examines changes across the lifespan. Social psychology studies how people influence and are influenced by others. Cognitive psychology investigates processes such as perception, language, reasoning, and problem-solving.

Psychological findings describe patterns across groups and do not automatically predict an individual's behavior. Ethical research protects participants, obtains informed consent, and minimizes harm.''',
      collegeCode: 'CAS'),
  Mat('Human Anatomy', 'Study notes', 'Health Sciences',
      '''Human anatomy studies the structures of the body and how they relate to one another. The body is organized into levels: cells form tissues, tissues form organs, and organs work together in organ systems.

The skeletal system supports the body, protects organs, and works with muscles to produce movement. The muscular system includes skeletal muscles for voluntary movement, smooth muscle in many organs, and cardiac muscle in the heart.

The circulatory system moves blood through the heart and blood vessels. The respiratory system exchanges oxygen and carbon dioxide. The digestive system breaks food into nutrients that can be absorbed and used by cells.

The nervous and endocrine systems help coordinate body functions. The nervous system communicates rapidly using electrical signals and neurotransmitters. The endocrine system releases hormones that regulate processes over time.

Homeostasis is the maintenance of a relatively stable internal environment. Systems interact to regulate temperature, fluid balance, and other conditions. These notes are a study overview, not medical advice.'''),
  Mat(
    'Research Methods in Social Sciences',
    'Study notes',
    'Arts and Sciences',
    '''Social science research uses systematic methods to study people, groups, and communities. A research question should be focused, answerable with evidence, and appropriate to the time and resources available.

Quantitative methods collect numerical data, often through structured surveys or experiments. Qualitative methods use interviews, observations, or documents to understand experiences and context. Mixed-methods studies combine both approaches.

A sample is the group of people or cases included in a study. Researchers should describe how participants were selected and consider whether the sample represents the population they want to understand. Correlation shows that variables change together, but it does not by itself establish that one causes the other.

Ethical research requires informed consent, privacy protections, honest reporting, and care to minimize harm. Findings should be interpreted in light of the study design, limitations, and evidence.''',
    collegeCode: 'CAS',
  ),
  Mat(
    'Lesson Planning and Assessment',
    'Study notes',
    'Teacher Education',
    '''An effective lesson plan aligns learning objectives, teaching activities, and assessment. Objectives describe what learners should know or be able to do by the end of a lesson. Use observable verbs such as explain, compare, solve, or demonstrate.

Begin with learners' prior knowledge and provide clear examples before guided practice. Gradually shift responsibility to students through discussion, group tasks, and independent application. Check understanding during the lesson so instruction can be adjusted.

Formative assessment gives feedback while learning is in progress; examples include exit tickets, short quizzes, and questioning. Summative assessment evaluates learning after a unit or course. A useful assessment measures the stated objective and communicates expectations in advance.

After teaching, review student evidence and reflect on what to retain or change. Adapt materials and supports so learners with different needs can participate.''',
    collegeCode: 'CTE',
  ),
  Mat(
    'Introduction to Criminal Justice',
    'Study notes',
    'Criminal Justice',
    '''The criminal justice system includes law enforcement, courts, and corrections. These institutions have distinct responsibilities and interact as cases move from investigation through adjudication and, when applicable, sentencing.

Criminal law defines prohibited conduct and the penalties that may follow. Criminal procedure governs how authorities investigate and prosecute alleged offenses while protecting legal rights. The presumption of innocence places the burden of proving a charge on the prosecution.

Evidence must be collected and handled using lawful procedures. Courts assess admissibility and reliability, and the rules vary by jurisdiction. A fair process requires impartial decision-making, access to legal representation, and an opportunity to challenge evidence.

This overview is for study purposes. Specific laws and procedures differ by jurisdiction and may change over time.''',
    collegeCode: 'CCJE',
  ),
  Mat(
    'Principles of Management',
    'Study notes',
    'Business',
    '''Management coordinates people and resources to achieve organizational goals. Common management functions include planning, organizing, leading, and controlling.

Planning sets objectives and identifies actions, resources, and measures of progress. Organizing assigns responsibilities and establishes how work is coordinated. Leading involves communication, motivation, and supporting teams. Controlling compares results with objectives and guides corrective action.

Managers make decisions with incomplete information. A useful process is to define the problem, gather relevant evidence, compare alternatives, consider risks, and review the outcome. Clear goals and regular feedback help teams understand priorities.

Organizations operate within changing economic, legal, and social environments. Ethical management considers how decisions affect employees, customers, communities, and other stakeholders.''',
    collegeCode: 'CBA',
  ),
  Mat(
    'The Accounting Cycle',
    'Study notes',
    'Accountancy',
    '''The accounting cycle turns business transactions into financial statements. First, identify and analyze transactions using source documents such as invoices and receipts. Record each transaction in a journal using the double-entry system: total debits must equal total credits.

Post journal entries to ledger accounts and prepare an unadjusted trial balance. At period end, record adjusting entries for items such as accrued expenses, prepaid costs, and depreciation. The adjusted trial balance is then used to prepare the income statement, statement of changes in equity, and balance sheet.

Closing entries transfer temporary account balances, such as revenue and expense accounts, into retained earnings. A post-closing trial balance checks that permanent accounts remain balanced for the next period.

Accurate records support decision-making and accountability. Keep documentation for entries and apply the relevant accounting standards consistently.''',
    collegeCode: 'COA',
  ),
];

class OfflineStorage {
  static Future<Directory> _directory() async {
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(
        '${documents.path}${Platform.pathSeparator}offline_materials');
    await directory.create(recursive: true);
    return directory;
  }

  static String _fileName(Mat material) =>
      '${material.t.toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '_')}.txt';

  static Future<File> _fileFor(Mat material) async {
    final directory = await _directory();
    return File(
        '${directory.path}${Platform.pathSeparator}${_fileName(material)}');
  }

  static Future<File> save(Mat material) async {
    final file = await _fileFor(material);
    return file.writeAsString(material.content, flush: true);
  }

  static Future<String> read(Mat material) async =>
      (await _fileFor(material)).readAsString();

  static Future<List<Mat>> savedMaterials() async {
    final saved = <Mat>[];
    for (final material in mats) {
      if (await (await _fileFor(material)).exists()) saved.add(material);
    }
    return saved;
  }
}

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) => ValueListenableBuilder<bool>(
        valueListenable: AppState.dark,
        builder: (_, dark, __) => MaterialApp(
          title: AppBranding.name,
          debugShowCheckedModeBanner: false,
          themeMode: dark ? ThemeMode.dark : ThemeMode.light,
          theme: _theme(Brightness.light),
          darkTheme: _theme(Brightness.dark),
          home: const Splash(),
        ),
      );

  ThemeData _theme(Brightness b) => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: blue, brightness: b, secondary: gold),
        appBarTheme: const AppBarTheme(centerTitle: false),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      );
}

Route<T> slide<T>(Widget w) => PageRouteBuilder<T>(
      transitionDuration: const Duration(milliseconds: 350),
      pageBuilder: (_, __, ___) => w,
      transitionsBuilder: (_, a, __, c) => SlideTransition(
        position: Tween(begin: const Offset(.12, 0), end: Offset.zero)
            .animate(CurvedAnimation(parent: a, curve: Curves.easeOutCubic)),
        child: FadeTransition(opacity: a, child: c),
      ),
    );

void push(BuildContext c, Widget w) => Navigator.push(c, slide(w));
void reset(BuildContext c, Widget w) =>
    Navigator.pushAndRemoveUntil(c, slide(w), (_) => false);
void snack(BuildContext c, String s) => ScaffoldMessenger.of(c)
  ..hideCurrentSnackBar()
  ..showSnackBar(
      SnackBar(content: Text(s), behavior: SnackBarBehavior.floating));

class Appear extends StatelessWidget {
  final int i;
  final Widget child;
  const Appear(this.i, this.child, {super.key});
  @override
  Widget build(BuildContext context) => TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: 1),
        duration: Duration(milliseconds: 350 + i * 70),
        curve: Curves.easeOutCubic,
        builder: (_, v, c) => Opacity(
            opacity: v,
            child:
                Transform.translate(offset: Offset(0, 18 * (1 - v)), child: c)),
        child: child,
      );
}

class Floaty extends StatefulWidget {
  final Widget child;
  const Floaty(this.child, {super.key});
  @override
  State<Floaty> createState() => _FloatyState();
}

class _FloatyState extends State<Floaty> with SingleTickerProviderStateMixin {
  late final c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1800))
    ..repeat(reverse: true);
  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: c,
        builder: (_, ch) => Transform.translate(
            offset: Offset(0, -12 * Curves.easeInOut.transform(c.value)),
            child: ch),
        child: widget.child,
      );
}

class TypingDots extends StatefulWidget {
  const TypingDots({super.key});
  @override
  State<TypingDots> createState() => _TypingDotsState();
}

class _TypingDotsState extends State<TypingDots>
    with SingleTickerProviderStateMixin {
  late final c = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..repeat();
  @override
  void dispose() {
    c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
        animation: c,
        builder: (_, __) => Row(mainAxisSize: MainAxisSize.min, children: [
          for (var i = 0; i < 3; i++)
            Padding(
              padding: const EdgeInsets.all(2),
              child: Opacity(
                opacity: .3 +
                    .7 * ((math.sin(c.value * 2 * math.pi - i * .8) + 1) / 2),
                child: const CircleAvatar(radius: 3.5, backgroundColor: blue),
              ),
            ),
        ]),
      );
}

class Logo extends StatelessWidget {
  final double size;
  const Logo({super.key, this.size = 92});

  @override
  Widget build(BuildContext context) {
    const asset = AppBranding.logoAsset;
    if (asset.isNotEmpty) {
      return SizedBox(
        width: size,
        height: size,
        child: Image.asset(
          asset,
          fit: BoxFit.contain,
          errorBuilder: (_, __, ___) => _defaultMark(),
        ),
      );
    }
    return _defaultMark();
  }

  Widget _defaultMark() => Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: gold, width: 4),
          gradient: const RadialGradient(
              center: Alignment(-.3, -.4), colors: [Color(0xFF1C64D0), navy]),
        ),
        child: Text('CMU',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: size * .26)),
      );
}

Widget field(String l, {bool obscure = false, int lines = 1}) => Padding(
      padding: const EdgeInsets.only(top: 12),
      child: TextField(
          obscureText: obscure,
          maxLines: lines,
          decoration: InputDecoration(labelText: l)),
    );

Widget btn(String t, VoidCallback f,
        {bool gold_ = false, bool outline = false}) =>
    Padding(
      padding: const EdgeInsets.only(top: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: outline
            ? OutlinedButton(onPressed: f, child: Text(t))
            : FilledButton(
                onPressed: f,
                style: FilledButton.styleFrom(
                  backgroundColor: gold_ ? gold : blue,
                  foregroundColor:
                      gold_ ? const Color(0xFF3A2A00) : Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(t,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 15)),
              ),
      ),
    );

class MatRow extends StatelessWidget {
  final Mat m;
  final int i;
  const MatRow(this.m, this.i, {super.key});
  @override
  Widget build(BuildContext context) => Appear(
        i,
        Card(
          margin: const EdgeInsets.only(bottom: 8),
          child: ListTile(
            title: Text(m.t,
                style:
                    const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
            subtitle: Text(m.m, style: const TextStyle(fontSize: 12)),
            trailing: null,
            hoverColor: Colors.transparent,
            splashColor: Colors.transparent,
            onTap: () => push(context, Detail(m)),
          ),
        ),
      );
}

class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late final bg =
      AnimationController(vsync: this, duration: const Duration(seconds: 10))
        ..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 5), () {
      if (mounted) reset(context, const Onboarding());
    });
  }

  @override
  void dispose() {
    bg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Stack(fit: StackFit.expand, children: [
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [blue, navy]),
            ),
          ),
          Image.asset(AppBranding.splashBackgroundAsset,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox.shrink()),
          DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [blue.withAlpha(170), navy.withAlpha(220)],
              ),
            ),
          ),
          Positioned(
              top: -70,
              left: -70,
              child: Transform.rotate(
                  angle: .6,
                  child: Container(
                      width: 190, height: 190, color: gold.withAlpha(200)))),
          Positioned(
              bottom: -90,
              right: -90,
              child: Transform.rotate(
                  angle: .6,
                  child: Container(
                      width: 230, height: 230, color: gold.withAlpha(200)))),
          AnimatedBuilder(
              animation: bg,
              builder: (_, __) =>
                  CustomPaint(painter: _BubblesPainter(bg.value))),
          Center(
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: .6, end: 1),
              duration: const Duration(milliseconds: 900),
              curve: Curves.elasticOut,
              builder: (_, v, c) => Opacity(
                  opacity: v.clamp(0, 1),
                  child: Transform.scale(scale: v, child: c)),
              child: const Column(mainAxisSize: MainAxisSize.min, children: [
                Logo(size: 130),
                SizedBox(height: 22),
                Text(AppBranding.name,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.w700)),
                SizedBox(height: 6),
                Text(AppBranding.tagline,
                    style: TextStyle(color: Color(0xFFCFDCF5))),
              ]),
            ),
          ),
          Positioned(
            left: 60,
            right: 60,
            bottom: 70,
            child: TweenAnimationBuilder<double>(
              tween: Tween(begin: 0, end: 1),
              duration: const Duration(seconds: 5),
              builder: (_, v, __) => ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: LinearProgressIndicator(
                    value: v,
                    minHeight: 6,
                    backgroundColor: Colors.white24,
                    color: gold),
              ),
            ),
          ),
        ]),
      );
}

class _BubblesPainter extends CustomPainter {
  final double t;
  _BubblesPainter(this.t);

  @override
  void paint(Canvas canvas, Size s) {
    for (var i = 0; i < 14; i++) {
      final x = ((i * .137 + .08) % 1) * s.width +
          math.sin((t + i) * 2 * math.pi) * 14;
      final y = s.height - ((t + i / 14) % 1) * (s.height + 120) + 60;
      final r = 8.0 + (i % 4) * 8;
      canvas.drawCircle(
        Offset(x, y),
        r,
        Paint()
          ..color =
              (i.isEven ? gold : Colors.white).withAlpha(i.isEven ? 55 : 35),
      );
    }
  }

  @override
  bool shouldRepaint(_BubblesPainter old) => old.t != t;
}

class Onboarding extends StatefulWidget {
  const Onboarding({super.key});
  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final pc = PageController();
  int p = 0;
  static const pages = [
    [
      'Access Quality Learning Materials',
      'Find and explore educational resources anytime, anywhere.'
    ],
    [
      'Get AI-Assisted Learning Support',
      'Ask questions, get explanations, summaries, and practice questions in one place.'
    ],
  ];
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: Column(children: [
            Expanded(
              child: PageView(
                controller: pc,
                onPageChanged: (i) => setState(() => p = i),
                children: [
                  for (final d in pages)
                    Padding(
                      padding: const EdgeInsets.all(28),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 12),
                            Text(d[0],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 21, fontWeight: FontWeight.w700)),
                            const SizedBox(height: 10),
                            Text(d[1], textAlign: TextAlign.center),
                          ]),
                    ),
                ],
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              for (var i = 0; i < 2; i++)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.all(3),
                  width: i == p ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                      color: i == p ? blue : Colors.grey.shade400,
                      borderRadius: BorderRadius.circular(9)),
                ),
            ]),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: btn(p < 1 ? 'Next' : 'Get Started', () {
                if (p < 1) {
                  pc.nextPage(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeOut);
                } else {
                  reset(context, const Login());
                }
              }),
            ),
          ]),
        ),
      );
}

class Login extends StatelessWidget {
  const Login({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        body: SafeArea(
          child: ListView(padding: const EdgeInsets.all(24), children: [
            const SizedBox(height: 24),
            const Appear(0, Center(child: Logo())),
            const SizedBox(height: 12),
            const Appear(
                1,
                Center(
                    child: Text(AppBranding.name,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w700)))),
            const Appear(2, Center(child: Text('Welcome back!'))),
            const SizedBox(height: 12),
            Appear(
                3,
                Column(children: [
                  field('Email or Student ID'),
                  field('Password', obscure: true)
                ])),
            Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {}, child: const Text('Forgot password?'))),
            btn('Login', () => reset(context, const Shell())),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              const Text("Don't have an account?"),
              TextButton(
                  onPressed: () => push(context, const SignUp()),
                  child: const Text('Sign Up')),
            ]),
          ]),
        ),
      );
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Create Your Account')),
        body: ListView(padding: const EdgeInsets.all(24), children: [
          field('Full Name'),
          field('Email Address'),
          field('Password', obscure: true),
          field('Confirm Password', obscure: true),
          btn('Sign Up', () => reset(context, const Shell())),
          TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Already have an account? Login')),
        ]),
      );
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int i = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
        body: AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: KeyedSubtree(
              key: ValueKey(i),
              child: [
                const Home(),
                const Materials(),
                const AiPage(tab: true),
                const Profile()
              ][i]),
        ),
        bottomNavigationBar: NavigationBar(
          selectedIndex: i,
          onDestinationSelected: (v) => setState(() => i = v),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home),
                label: 'Home'),
            NavigationDestination(
                icon: Icon(Icons.menu_book_outlined),
                selectedIcon: Icon(Icons.menu_book),
                label: 'Materials'),
            NavigationDestination(
                icon: Icon(Icons.smart_toy_outlined),
                selectedIcon: Icon(Icons.smart_toy),
                label: 'AI'),
            NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person),
                label: 'Profile'),
          ],
        ),
      );
}

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String q = '';
  Widget tile(String l, VoidCallback f) => Card(
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: f,
          child: Center(
              child: Text(l,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontSize: 13, fontWeight: FontWeight.w500))),
        ),
      );

  @override
  Widget build(BuildContext context) {
    final res = mats
        .where((m) => m.t.toLowerCase().contains(q.toLowerCase()))
        .take(4)
        .toList();
    return ListView(padding: EdgeInsets.zero, children: [
      Container(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).padding.top + 20, 20, 28),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [blue, navy]),
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(26)),
        ),
        child: Row(children: [
          const CircleAvatar(backgroundColor: Colors.white24, child: Text('J')),
          const SizedBox(width: 12),
          const Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text('Hello, Juan!',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
                Text('Explore. Learn. Grow.',
                    style: TextStyle(color: Color(0xFFCFDCF5))),
              ])),
          IconButton(
              icon: const Icon(Icons.notifications_none, color: Colors.white),
              onPressed: () => push(context, const Notifs())),
        ]),
      ),
      Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          TextField(
            onChanged: (v) => setState(() => q = v),
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search learning materials...'),
          ),
          const SizedBox(height: 12),
          Appear(
            1,
            SizedBox(
              height: 88,
              child: Row(
                children: [
                  Expanded(
                      child: tile(
                          'Bookmarks', () => push(context, const Bookmarks()))),
                  const SizedBox(width: 10),
                  Expanded(
                      child: tile(
                          'AI Assistant', () => push(context, const AiPage()))),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('Recommended for You',
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
          ),
          for (var i = 0; i < res.length; i++) MatRow(res[i], i),
        ]),
      ),
    ]);
  }
}

class Materials extends StatefulWidget {
  const Materials({super.key});
  @override
  State<Materials> createState() => _MaterialsState();
}

class _MaterialsState extends State<Materials> {
  String q = '', cat = 'All';
  String? selectedCollege;
  static const colleges = [
    ('CCS', 'College of Computer Science'),
    ('CAS', 'College of Arts and Sciences'),
    ('CTE', 'College of Teacher Education'),
    ('CCJE', 'College of Criminal Justice Education'),
    ('CBA', 'College of Business Administration'),
    ('COA', 'College of Accountancy'),
  ];

  @override
  Widget build(BuildContext context) {
    final res = mats
        .where((m) =>
            (selectedCollege == null || m.collegeCode == selectedCollege) &&
            (cat == 'All' || m.cat == cat) &&
            m.t.toLowerCase().contains(q.toLowerCase()))
        .toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Learning Materials')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        TextField(
            onChanged: (v) => setState(() => q = v),
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search materials...')),
        const Padding(
          padding: EdgeInsets.only(top: 20, bottom: 10),
          child: Text('Colleges',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        ),
        GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 1.55,
          children: [
            for (final college in colleges)
              Card(
                key: ValueKey('college-${college.$1}'),
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    color: selectedCollege == college.$1
                        ? Theme.of(context).colorScheme.primary
                        : Colors.transparent,
                    width: 2,
                  ),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(12),
                  onTap: () => setState(() {
                    selectedCollege =
                        selectedCollege == college.$1 ? null : college.$1;
                    cat = 'All';
                  }),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(college.$1,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700)),
                        const SizedBox(height: 4),
                        Text(college.$2,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12)),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
        const Padding(
          padding: EdgeInsets.only(top: 18, bottom: 2),
          child: Text('Filter by topic',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700)),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            for (final c in [
              'All',
              'Computer Science',
              'IT',
              'Health Sciences',
              'Arts and Sciences',
              'Teacher Education',
              'Criminal Justice',
              'Business',
              'Accountancy',
            ])
              Padding(
                padding: const EdgeInsets.only(right: 8, top: 10, bottom: 10),
                child: ChoiceChip(
                    label: Text(c),
                    selected: cat == c,
                    onSelected: (_) => setState(() => cat = c)),
              ),
          ]),
        ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 250),
          child: Column(key: ValueKey('$selectedCollege$cat$q'), children: [
            if (res.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Text('No materials found for these filters.'),
              )
            else
              for (var i = 0; i < res.length; i++) MatRow(res[i], i)
          ]),
        ),
      ]),
    );
  }
}

class Detail extends StatefulWidget {
  final Mat m;
  const Detail(this.m, {super.key});
  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  int rating = 0;
  final commentController = TextEditingController();
  final comments = <String>[];

  @override
  void dispose() {
    commentController.dispose();
    super.dispose();
  }

  void addComment() {
    final comment = commentController.text.trim();
    if (comment.isEmpty) return;
    setState(() {
      comments.add(comment);
      commentController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final m = widget.m;
    return Scaffold(
      appBar: AppBar(title: const Text('Material Details')),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        Container(
          height: 12,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(18),
          ),
        ),
        const SizedBox(height: 14),
        Text(m.t,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
        Text(m.m),
        const SizedBox(height: 6),
        Text('${m.cat} · Prototype study content'),
        btn('Read Material', () => push(context, MaterialReader(material: m))),
        btn('Download for Offline', () => push(context, Download(m))),
        ValueListenableBuilder<Set<String>>(
          valueListenable: AppState.bm,
          builder: (_, s, __) =>
              btn(s.contains(m.t) ? 'Bookmarked' : 'Bookmark', () {
            AppState.toggleBm(m.t);
            snack(context, s.contains(m.t) ? 'Bookmark removed' : 'Bookmarked');
          }, outline: true),
        ),
        const SizedBox(height: 18),
        const Text('Rate this material',
            style: TextStyle(fontWeight: FontWeight.w600)),
        Row(children: [
          for (var i = 1; i <= 5; i++)
            GestureDetector(
              onTap: () => setState(() => rating = i),
              child: AnimatedScale(
                scale: i == rating ? 1.4 : 1,
                duration: const Duration(milliseconds: 250),
                curve: Curves.elasticOut,
                child: Icon(i <= rating ? Icons.star : Icons.star_border,
                    size: 34, color: gold),
              ),
            ),
        ]),
        const SizedBox(height: 18),
        const Text('Comments', style: TextStyle(fontWeight: FontWeight.w600)),
        if (comments.isEmpty)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Text('No comments yet. Start a study-focused discussion.'),
          )
        else
          for (final comment in comments)
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: Text(comment),
            ),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Expanded(
            child: TextField(
              controller: commentController,
              minLines: 1,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Add a comment'),
              onSubmitted: (_) => addComment(),
            ),
          ),
          IconButton(
            onPressed: addComment,
            tooltip: 'Send comment',
            icon: const Icon(Icons.send),
          ),
        ]),
      ]),
    );
  }
}

class MaterialReader extends StatelessWidget {
  final Mat material;
  final bool offline;
  const MaterialReader(
      {super.key, required this.material, this.offline = false});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Study Material')),
        body: FutureBuilder<String>(
          future: offline
              ? OfflineStorage.read(material)
              : Future.value(material.content),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child:
                      Text('Unable to open this material: ${snapshot.error}'),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Text(material.t,
                    style: Theme.of(context).textTheme.headlineSmall),
                const SizedBox(height: 6),
                Text(material.cat,
                    style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 20),
                SelectableText(
                  snapshot.data!,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(height: 1.6),
                ),
              ],
            );
          },
        ),
      );
}

class Download extends StatefulWidget {
  final Mat m;
  const Download(this.m, {super.key});
  @override
  State<Download> createState() => _DownloadState();
}

class _DownloadState extends State<Download> {
  bool saving = false;
  String? savedPath;
  String? error;

  @override
  void initState() {
    super.initState();
    saveOffline();
  }

  Future<void> saveOffline() async {
    setState(() {
      saving = true;
      error = null;
    });
    try {
      final file = await OfflineStorage.save(widget.m);
      if (!mounted) return;
      setState(() {
        savedPath = file.path;
        saving = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        error = e.toString();
        saving = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Offline Copy')),
      body: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (saving) const CircularProgressIndicator(),
          if (saving) const SizedBox(height: 20),
          Text(
            saving
                ? 'Saving ${widget.m.t} for offline use...'
                : savedPath != null
                    ? 'Offline copy saved in app storage.'
                    : 'Could not save the offline copy.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),
          if (error != null) ...[
            const SizedBox(height: 12),
            SelectableText(error!, textAlign: TextAlign.center),
          ],
          if (savedPath != null)
            btn(
              'Read Offline Copy',
              () => push(
                  context, MaterialReader(material: widget.m, offline: true)),
            ),
          if (!saving && savedPath == null)
            btn('Try Again', saveOffline, outline: true),
        ]),
      ),
    );
  }
}

class OfflineMaterials extends StatelessWidget {
  const OfflineMaterials({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Offline Materials')),
        body: FutureBuilder<List<Mat>>(
          future: OfflineStorage.savedMaterials(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(
                      'Unable to load offline materials: ${snapshot.error}'),
                ),
              );
            }
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final materials = snapshot.data!;
            if (materials.isEmpty) {
              return const Center(
                child: Text('No offline materials downloaded yet.'),
              );
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                for (final material in materials)
                  Card(
                    child: ListTile(
                      title: Text(material.t),
                      subtitle: Text('${material.cat} · Available offline'),
                      onTap: () => push(
                        context,
                        MaterialReader(material: material, offline: true),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      );
}

class Bookmarks extends StatelessWidget {
  const Bookmarks({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('My Bookmarks')),
        body: ValueListenableBuilder<Set<String>>(
          valueListenable: AppState.bm,
          builder: (_, s, __) {
            final l = mats.where((m) => s.contains(m.t)).toList();
            if (l.isEmpty) {
              return const Center(
                  child: Text(
                      'No bookmarks yet.\nOpen a material and tap Bookmark.',
                      textAlign: TextAlign.center));
            }
            return ListView(
                padding: const EdgeInsets.all(16),
                children: [for (var i = 0; i < l.length; i++) MatRow(l[i], i)]);
          },
        ),
      );
}

class AiPage extends StatefulWidget {
  final bool tab;
  const AiPage({super.key, this.tab = false});
  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final msgs = <(bool, String)>[
    (
      false,
      "Hi! I'm your learning assistant. Ask me anything about your courses."
    )
  ];
  final ctl = TextEditingController(), sc = ScrollController();
  bool typing = false;

  static final canned = <RegExp, String>{
    RegExp('normaliz', caseSensitive: false):
        'Database normalization organizes data to reduce redundancy and improve integrity. You split large tables into smaller related ones (1NF, 2NF, 3NF) and link them with keys.',
    RegExp('java|python', caseSensitive: false):
        'Python is dynamically typed with simple syntax, great for data science and AI. Java is statically typed and faster for large systems and Android apps.',
    RegExp(r'hello|\bhi\b', caseSensitive: false):
        'Hi! I can explain topics, summarize materials, or quiz you. What are you studying?',
  };

  void scroll() => WidgetsBinding.instance.addPostFrameCallback((_) {
        if (sc.hasClients) {
          sc.animateTo(sc.position.maxScrollExtent + 80,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut);
        }
      });

  void send() {
    final q = ctl.text.trim();
    if (q.isEmpty || typing) return;
    ctl.clear();
    setState(() {
      msgs.add((true, q));
      typing = true;
    });
    scroll();
    Timer(const Duration(milliseconds: 1100), () {
      if (!mounted) return;
      final a = canned.entries
              .where((e) => e.key.hasMatch(q))
              .map((e) => e.value)
              .firstOrNull ??
          'Good question! Try asking me to explain a topic, summarize a material, or give practice questions.';
      setState(() {
        msgs.add((false, a));
        typing = false;
      });
      scroll();
    });
  }

  Widget bubble(bool me, Widget child) => Appear(
        0,
        Align(
          alignment: me ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsets.all(12),
            constraints: const BoxConstraints(maxWidth: 290),
            decoration: BoxDecoration(
              color: me
                  ? const Color(0xFFD8E8FF)
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: DefaultTextStyle.merge(
                style: TextStyle(
                    color: me ? const Color(0xFF0A2A5C) : null, height: 1.4),
                child: child),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
            title: const Text('AI Assistant'),
            automaticallyImplyLeading: !widget.tab),
        body: Column(children: [
          Expanded(
            child: ListView(
                controller: sc,
                padding: const EdgeInsets.all(16),
                children: [
                  for (final m in msgs) bubble(m.$1, Text(m.$2)),
                  if (typing) bubble(false, const TypingDots()),
                ]),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 4, 12, 8),
              child: Row(children: [
                Expanded(
                    child: TextField(
                        controller: ctl,
                        onSubmitted: (_) => send(),
                        decoration: const InputDecoration(
                            hintText: 'Ask a question...'))),
                const SizedBox(width: 8),
                IconButton.filled(
                    onPressed: send,
                    style: IconButton.styleFrom(backgroundColor: blue),
                    icon: const Icon(Icons.send)),
              ]),
            ),
          ),
        ]),
      );
}

Widget item(IconData i, String t, String s,
        {VoidCallback? f, Widget? trailing}) =>
    ListTile(
      leading: CircleAvatar(
          backgroundColor: blue.withAlpha(25), child: Icon(i, color: blue)),
      title: Text(t, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: s.isEmpty ? null : Text(s),
      trailing: trailing ?? const Icon(Icons.chevron_right),
      onTap: f,
    );

void showInfoDialog(BuildContext context, String title, String message) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

class Profile extends StatelessWidget {
  const Profile({super.key});

  void showRatingDialog(BuildContext context) {
    var rating = 0;
    showDialog<void>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (_, setDialogState) => AlertDialog(
          title: const Text('Rate & Review'),
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              for (var star = 1; star <= 5; star++)
                IconButton(
                  tooltip: '$star star${star == 1 ? '' : 's'}',
                  onPressed: () => setDialogState(() => rating = star),
                  icon: Icon(
                    star <= rating ? Icons.star : Icons.star_border,
                    color: gold,
                  ),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: rating == 0
                  ? null
                  : () {
                      Navigator.pop(dialogContext);
                      snack(context, 'Thanks for your $rating-star rating!');
                    },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }

  void confirmLogout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Log Out'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              reset(context, const Login());
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Profile')),
        body: ListView(children: [
          const SizedBox(height: 16),
          const Center(child: Appear(0, Logo(size: 84))),
          const SizedBox(height: 10),
          const Center(
              child: Text('Juan Dela Cruz',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700))),
          const Center(child: Text('Student')),
          const SizedBox(height: 12),
          item(Icons.download_done_outlined, 'Offline Materials', '',
              f: () => push(context, const OfflineMaterials())),
          item(Icons.bookmark_border, 'My Bookmarks', '',
              f: () => push(context, const Bookmarks())),
          item(Icons.star_border, 'Rate & Review', '',
              f: () => showRatingDialog(context)),
          item(Icons.settings_outlined, 'Settings', '',
              f: () => push(context, const SettingsPage())),
          item(Icons.help_outline, 'Help & Support', '',
              f: () => push(context, const Help())),
          item(Icons.logout, 'Log Out', '', f: () => confirmLogout(context)),
        ]),
      );
}

class Notifs extends StatelessWidget {
  const Notifs({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Notifications')),
        body: ListView(children: [
          for (final (i, n) in [
            ('New material available', 'Web Development Basics · 2 hours ago'),
          ].indexed)
            Appear(i, ListTile(title: Text(n.$1), subtitle: Text(n.$2))),
        ]),
      );
}

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Settings')),
        body: ListView(children: [
          item(Icons.person_outline, 'Account', 'Profile information',
              f: () => showInfoDialog(context, 'Account',
                  'Signed in as Juan Dela Cruz (Student).')),
          item(Icons.key_outlined, 'Change Password', 'Update your password',
              f: () => showInfoDialog(context, 'Change Password',
                  'Password changes are not available in this demo.')),
          ValueListenableBuilder<bool>(
            valueListenable: AppState.notifications,
            builder: (_, enabled, __) => item(
              Icons.notifications_none,
              'Notifications',
              'Manage notifications',
              f: () => AppState.notifications.value = !enabled,
              trailing: Switch(
                value: enabled,
                onChanged: (value) => AppState.notifications.value = value,
              ),
            ),
          ),
          ValueListenableBuilder<bool>(
            valueListenable: AppState.dark,
            builder: (_, d, __) => item(
                Icons.dark_mode_outlined, 'Dark mode', 'App preferences',
                f: () => AppState.dark.value = !d,
                trailing: Switch(
                    value: d, onChanged: (v) => AppState.dark.value = v)),
          ),
          item(Icons.lock_outline, 'Privacy & Security',
              'Manage privacy settings',
              f: () => showInfoDialog(context, 'Privacy & Security',
                  'Your profile information stays on this device in this demo.')),
        ]),
      );
}

class Help extends StatelessWidget {
  const Help({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Help & Support')),
        body: ListView(children: [
          item(Icons.quiz_outlined, 'FAQs', 'Find answers to common questions',
              f: () => showInfoDialog(context, 'FAQs',
                  'Browse Learning Materials to find course notes. Use Bookmarks to keep materials handy.')),
          item(Icons.mail_outline, 'Contact Us',
              'Get in touch with our support team',
              f: () => showInfoDialog(context, 'Contact Us',
                  'Please contact your CMUnity administrator for support.')),
          item(Icons.bug_report_outlined, 'Report a Problem',
              'Send feedback or report an issue',
              f: () => showInfoDialog(context, 'Report a Problem',
                  'Please contact your CMUnity administrator to report an issue.')),
          item(Icons.info_outline, 'About', 'Version 1.0.0',
              f: () => push(context, const About())),
        ]),
      );
}

class About extends StatelessWidget {
  const About({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('About')),
        body: const Padding(
          padding: EdgeInsets.all(28),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Floaty(Logo()),
            SizedBox(height: 16),
            Text(AppBranding.name,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700)),
            Text('Version 1.0.0'),
            SizedBox(height: 14),
            Text(
                'A mobile-based educational content sharing platform with AI-assisted learning support for City of Malabon University.',
                textAlign: TextAlign.center),
            SizedBox(height: 14),
            Text('Powered by Google Gemini',
                style: TextStyle(color: blue, fontWeight: FontWeight.w600)),
          ]),
        ),
      );
}
