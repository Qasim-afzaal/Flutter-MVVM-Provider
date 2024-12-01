# Flutter-MVVM-Clean-Architecture-Provider

A Flutter project structured using **MVVM (Model-View-ViewModel)** architecture, enhanced by **Clean Architecture** principles and **Provider** for state management. This setup ensures clean code practices, modularity, scalability, and testability.

---

## Features

- **Clean Architecture**: Ensures separation of concerns with clearly defined layers.
- **MVVM Architecture**: Simplifies UI and state interaction.
- **State Management**: Powered by the Provider package for efficient and reactive state handling.
- **Scalability**: Modular codebase for adding features easily.
- **Testability**: Well-defined boundaries for independent testing of components.

---

## Project Structure

The project follows Clean Architecture principles combined with the MVVM pattern:

```
lib/
├── core/            # Core utilities (constants, error handling, etc.)
├── data/            # Data layer (models, data sources, and repositories)
│   ├── models/      # Data models
│   ├── datasources/ # Local and remote data sources
│   └── repositories/ # Implementation of repository interfaces
├── domain/          # Domain layer (entities and use cases)
│   ├── entities/    # Core business entities
│   └── usecases/    # Business logic or application-specific operations
├── presentation/    # Presentation layer (UI and ViewModels)
│   ├── viewmodels/  # Business logic and state management
│   └── views/       # UI screens and widgets
├── main.dart        # Entry point of the application
```

### Folder Details

1. **Core**  
   Contains reusable utilities, constants, error handling, and helper methods.  
   Example:  
   ```dart
   class AppConstants {
     static const String appName = 'Flutter Clean Architecture';
   }
   ```

2. **Data**  
   Handles all data operations (network, local storage, or other external services).  
   - **Models**: Define the structure of the application’s data.  
   - **Data Sources**: Manage API calls or database queries.  
   - **Repositories**: Implement interfaces to provide data to the domain layer.

3. **Domain**  
   Encapsulates the core business logic.  
   - **Entities**: Define the core business objects.  
   - **Use Cases**: Contain the application’s business rules and orchestrate workflows.

4. **Presentation**  
   Handles the UI and user interactions.  
   - **ViewModels**: Manage state and interact with the domain layer.  
   - **Views**: Define the visual representation of the application.

---

## Dependencies

This project uses the following dependencies:

- [Provider](https://pub.dev/packages/provider): State management.
- [Dio](https://pub.dev/packages/dio): For making API calls.
- [GetIt](https://pub.dev/packages/get_it): Dependency injection.
- [Flutter EasyLoading](https://pub.dev/packages/flutter_easyloading): For displaying loading indicators.
- [Freezed](https://pub.dev/packages/freezed): For immutability and data classes.

---

## Getting Started

### Prerequisites

Ensure you have the following installed:

- Flutter SDK (>=3.0.0)
- Dart (>=2.18.0)

### Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/your-username/flutter-mvvm-clean-provider.git
   cd flutter-mvvm-clean-provider
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Run the application:

   ```bash
   flutter run
   ```

---

## Examples

### ViewModel Example

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ExampleViewModel extends ChangeNotifier {
  String _title = 'Hello, Flutter!';
  String get title => _title;

  void updateTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }
}
```

### View Example

```dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/example_viewmodel.dart';

class ExampleView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<ExampleViewModel>();

    return Scaffold(
      appBar: AppBar(title: Text('Flutter MVVM')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(viewModel.title),
            ElevatedButton(
              onPressed: () => viewModel.updateTitle('Welcome to Clean Architecture!'),
              child: Text('Update Title'),
            ),
          ],
        ),
      ),
    );
  }
}
```

---

## Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository.
2. Create a feature branch: `git checkout -b feature-name`.
3. Commit your changes: `git commit -m 'Add some feature'`.
4. Push to the branch: `git push origin feature-name`.
5. Open a pull request.

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- [Flutter](https://flutter.dev/)
- [Provider](https://pub.dev/packages/provider)
- [Clean Architecture](https://github.com/ResoCoder/flutter-tdd-clean-architecture-course)
