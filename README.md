#  Laqeetak (لقيتك)

Laqeetak is a Flutter-based Lost & Found application designed to simplify the process of reporting and recovering lost belongings. The app provides a secure and organized platform where users can report lost or found items, upload images, specify locations, and search for matching reports.
Its primary goal is to reconnect people with their lost possessions while promoting community collaboration through an easy-to-use mobile application.

#  Problem Statement
Losing personal belongings is a common issue that often leads to wasted time, frustration, and financial loss. On the other hand, people who find lost items usually have no effective way to locate their rightful owners.
Traditional solutions such as social media posts or word of mouth are unorganized, difficult to search, and often fail to reach the right audience.
Laqeetak solves this problem by providing a centralized platform where users can:
. Report lost items.
. Report found items.
. Upload item images.
. Specify the item's location.
. Search and filter reports.
. Increase the chances of reconnecting owners with their belongings quickly and securely.

##  Architecture
The application follows the **MVVM (Model–View–ViewModel)** architecture to ensure clean code, maintainability, scalability, and separation of concerns.

##  Tech Stack
###  Frontend
. Flutter
. Dart
. Material Design
. Custom UI Components
. Fully Responsive UI
. MVVM Architecture
. BLoC State Management
. Cubit
. GPS & Location Services
. Google Maps Integration

###  Backend
. Firebase Authentication
. Cloud Firestore
. Firebase Storage

##  Technical Highlights
.  MVVM architecture for scalable and maintainable project structure.
.  BLoC & Cubit for predictable and efficient state management.
.  Fully customized and responsive user interface.
.  Secure authentication using Firebase Authentication.
.  Real-time cloud database powered by Cloud Firestore.
.  GPS integration for accurate item locations.
.  Google Maps integration for selecting and displaying item locations.
.  Image upload support for better item identification.
.  Clean, modular, and maintainable codebase.
.  Cross-platform support for Android and iOS.

##  Packages & Services
### State Management
. flutter_bloc
### Firebase
. firebase_core
. firebase_auth
. cloud_firestore
. firebase_storage

### Maps & Location
. google_maps_flutter
. geolocator
. geocoding

### Media & Utilities
. image_picker
. cached_network_image
