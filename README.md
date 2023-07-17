# Click2Cart (Simple Online Shop App)

Click2Cart is a sleek and user-friendly online shopping application that allows users to browse, search, and purchase products from various categories. With its intuitive design and seamless user experience, Click2Cart aims to provide a convenient and enjoyable shopping experience for its users.

## Design

The design of Click2Cart can be found [here](https://www.figma.com/community/file/979967194939443160).

## Tech Stack

Click2Cart is built using the following technologies:

- Flutter: Flutter is a cross-platform framework that enables developers to build beautiful and high-performance mobile applications for iOS and Android using a single codebase. It provides a rich set of pre-designed widgets, making it easier to create visually appealing user interfaces.

- BLoC (Business Logic Component): BLoC is an architectural pattern that helps separate business logic from the user interface in Flutter applications. It follows a unidirectional data flow, making the codebase more manageable and testable.

- get_it: get_it is a lightweight and easy-to-use service locator for Flutter applications. It helps with dependency injection, allowing the application to maintain loose coupling between different components and promoting code modularity and reusability.

- dio: dio is a powerful HTTP client for Dart and Flutter, providing a simple and elegant way to make API calls and handle network requests. It supports various features such as interceptors, cancellation tokens, and form data handling, making it an ideal choice for networking tasks in Click2Cart.

- firebase_auth: firebase_auth is a Flutter plugin that provides an interface to Firebase Authentication. It allows users to sign in or register using various authentication methods such as email/password, Google Sign-In, Facebook Login, and more. Firebase Authentication ensures secure user authentication and simplifies the implementation of user management in Click2Cart.

## Getting Started

To run Click2Cart on your local machine, follow these steps:

1. Clone the repository: `git clone https://github.com/vikoms/online_shop_app.git`
2. Install Flutter: [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
3. Set up your Firebase project and obtain the necessary configuration files.
4. Replace the Firebase configuration files in the appropriate locations within the project.
5. Install dependencies: `flutter pub get`
6. Run the app: `flutter run`

Please note that additional setup and configuration may be required, depending on your development environment and Firebase project settings.
