import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:cmunity_app/main.dart';

void main() {
  testWidgets('app loads and shows startup screen', (tester) async {
    await tester.pumpWidget(const App());

    expect(find.text(AppBranding.name), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(milliseconds: 350));

    expect(find.text('Access Quality Learning Materials'), findsOneWidget);
  });

  testWidgets('materials screen shows all six colleges', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Materials()),
    );

    const colleges = [
      ('CCS', 'College of Computer Science'),
      ('CAS', 'College of Arts and Sciences'),
      ('CTE', 'College of Teacher Education'),
      ('CCJE', 'College of Criminal Justice Education'),
      ('CBA', 'College of Business Administration'),
      ('COA', 'College of Accountancy'),
    ];

    for (final college in colleges) {
      expect(find.text(college.$1), findsOneWidget);
      expect(find.text(college.$2), findsOneWidget);
      expect(mats.any((material) => material.collegeCode == college.$1), isTrue,
          reason: '${college.$1} should have at least one learning material');
    }
  });

  testWidgets('selecting a college filters its learning materials',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Materials()),
    );

    final collegeCard = find.byKey(const ValueKey('college-CTE'));
    await tester.ensureVisible(collegeCard);
    await tester.tap(collegeCard);
    await tester.pumpAndSettle();

    await tester.dragUntilVisible(
      find.text('Lesson Planning and Assessment'),
      find.byType(ListView).first,
      const Offset(0, -300),
    );
    await tester.pumpAndSettle();

    expect(find.text('Lesson Planning and Assessment'), findsOneWidget);
    expect(find.text('Data Structures'), findsNothing);
  });

  testWidgets('profile rating and settings actions respond', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Profile()));

    await tester.tap(find.text('Rate & Review'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('4 stars'));
    await tester.pump();
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);

    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Account'));
    await tester.pumpAndSettle();
    expect(find.text('Signed in as Juan Dela Cruz (Student).'), findsOneWidget);
  });
}
