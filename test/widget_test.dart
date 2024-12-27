
import 'package:flutter_test/flutter_test.dart';

import 'package:doan/main.dart';

void main() {
  testWidgets('Bartender Guide app smoke test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(BartenderApp());

    // Verify that the Home screen is displayed.
    expect(find.text('Bartender Guide'), findsOneWidget);
    expect(find.text('Search Recipes'), findsNothing);

    // Tap the "Search Recipes" button/icon and navigate to Search screen.
    await tester.tap(find.byTooltip('Search')); // Assuming there is a search icon button with a tooltip.
    await tester.pumpAndSettle();

    // Verify that the Search screen is displayed.
    expect(find.text('Search Recipes'), findsOneWidget);
    expect(find.text('Favorites'), findsNothing);

    // Navigate back to Home screen.
    await tester.pageBack();
    await tester.pumpAndSettle();

    // Verify that the Home screen is displayed again.
    expect(find.text('Bartender Guide'), findsOneWidget);
  });

  testWidgets('Navigate to Recipe Details', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(BartenderApp());

    // Verify the Home screen is displayed.
    expect(find.text('Bartender Guide'), findsOneWidget);

    // Tap a recipe item to navigate to Recipe Details.
    await tester.tap(find.text('Featured Recipe 1')); // Assuming "Featured Recipe 1" is a recipe name.
    await tester.pumpAndSettle();

    // Verify the Recipe Details screen is displayed.
    expect(find.text('Recipe Details'), findsOneWidget);
    expect(find.text('Ingredients:'), findsOneWidget);
  });
}
