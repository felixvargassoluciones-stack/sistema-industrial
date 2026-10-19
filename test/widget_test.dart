import 'package:flutter_test/flutter_test.dart';
import 'package:sistema_gestion_industrial/main.dart';

void main() {
  testWidgets('Prueba inicial de carga de Login', (WidgetTester tester) async {
    // Carga la aplicación usando el nuevo nombre correcto
    await tester.pumpWidget(const MainApp());

    // Verifica que el título del sistema aparezca en pantalla
    expect(find.text('Gestión de Requerimientos'), findsOneWidget);
  });
}
