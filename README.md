# mobile_flickbuy_app

Flutter mobile project for purchase products.

# FlickBuy Project Structure

This project follows a **Feature-First** layered architecture to ensure the codebase is scalable, maintainable, and easy to navigate.

## Directory Tree

The core application logic is located within the `lib/src` directory.

```
lib/
└── src/
    |
    ├── common_widgets/
    |
    ├── constants/
    |
    ├── data/
    |
    ├── exceptions/
    |
    ├── features/
    │   ├── auth/
    │   ├── products/
    │   └── cart/
    |
    ├── routing/
    |
    └── utils/
    |
└── main.dart
```

### Top-Level Directory Explanations

* `main.dart`: The entry point of the application. Its main responsibility is to initialize the app and set up the root `ProviderScope` for Riverpod.

* `src/`: This directory contains all the core source code for the application, separated from the platform-specific code.

    * `common_widgets/`: Contains simple, reusable widgets that are not tied to any specific feature. Examples: `PrimaryButton`, `LoadingSpinner`, `EmptyDataWidget`.

    * `constants/`: Stores app-wide constants, such as API keys, default padding values, or static configuration details.

    * `data/`: Holds app-wide data sources and clients. This is the perfect place for initializing and providing the `Appwrite` client that will be used by various feature repositories.

    * `exceptions/`: Home for custom exception classes used throughout the application to handle specific error cases gracefully.

    * `features/`: **This is the heart of the app.** Each subdirectory within `features` represents a distinct feature (e.g., `auth`, `products`). Each feature folder is self-contained and follows a layered architecture:
        * `controllers/`: Contains the business logic and state management (Riverpod Notifiers).
        * `data/`: Implements the repositories for fetching data from sources like Appwrite.
        * `domain/`: Defines the core data models and business objects (e.g., `Product`, `User`).
        * `presentation/`: Holds the UI components (screens and widgets) for the feature.

    * `routing/`: Manages all navigation logic. This is where the `GoRouter` configuration and all the app routes are defined.

    * `utils/`: Contains utility classes and helper functions that don't fit anywhere else, such as date formatters or custom validators.
