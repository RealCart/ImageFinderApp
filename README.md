# image_finder_app

# 🖼️ Image Finder App

🔍 Discover • ❤️ Favorite • 💾 Download • 📱 Offline

---

## ✨ Project Overview
**Image Finder App** is a Flutter application that lets users explore high-quality photos from Unsplash, save their favorites, and download shots directly to the device gallery.  
Built with **Clean Architecture + MVI**, it keeps business logic, data, and UI neatly separated for easy maintenance and testing.

---

## 🏗️ Architecture & Design Patterns

| Layer            | Patterns & Tools                                                                 |
|------------------|----------------------------------------------------------------------------------|
| **Presentation** | **BLoC** (`flutter_bloc`) · MVI cycle (Intent → BLoC → State → UI)               |
| **Domain**       | **Use-Case** pattern · Entities · Repository interfaces                          |
| **Data**         | **Repository** + data sources (remote + local) · **Either** functional errors    |
| **Core**         | **Service Locator** (`GetIt`) · **Singletons** (`DownloadService`, `SqfliteClient`) |

---

## 🛠️ Tech Stack

- **State Management:** `flutter_bloc`, `equatable`  
- **Networking:** `dio` + `pretty_dio_logger`  
- **Local Storage:** `sqflite`, `path_provider`  
- **Navigation & UI:** `auto_route`, `flutter_svg`, `cached_network_image`  
- **Gallery / Permissions:** `saver_gallery`, `permission_handler`, `device_info_plus`  
- **Utilities:** `get_it`, `json_serializable`, `bloc_concurrency`, `stream_transform`  

---

## 📂 Project Structure
```text
```lib/
┣ core/
┃ ┣ config/           → global themes, constants
┃ ┣ data/             → reusable clients (Dio, Sqflite, Download)
┃ ┣ domain/           → base entities, repositories, use-cases
┃ ┣ utils/            → debounce, error wrappers, enums
┃ ┗ presentation/     → global widgets, router
┣ features/
┃ ┣ home/             → photo feed + search
┃ ┣ favorites/        → saved photos
┃ ┗ photo/            → photo-detail screen
┗ main.dart```

🌟 Key Features
Random Discovery: one-tap fetch of fresh Unsplash photos

Smart Search: debounced text search with instant results

Favorites: add/remove & persist via SQLite

Full-Screen Detail: author info, palette-friendly UI

1-Click Download: save to gallery with permission flow + progress bar

Offline Access: cached random photos available without network

🗄️ Database Schema
```-- Cached random photos
CREATE TABLE cached_random_photo (
  id    INTEGER PRIMARY KEY AUTOINCREMENT,
  value TEXT NOT NULL
);

-- Favorite photos
CREATE TABLE favorites_photo (
  id    TEXT PRIMARY KEY,
  value TEXT NOT NULL
);```

🔄 State Flow (MVI)
```User Intent → Event → BLoC → New State → UI Render
```
Example — Download Button

DownloadPhotoEvent → BLoC

BLoC runs DownloadPhotoUseCase

Use-case calls repository → DownloadService + saver_gallery

Emits DownloadSuccess / DownloadFailure state

UI shows progress bar or snackbar

🧩 Dependency Injection (GetIt)

```// core/service_locator.dart
final sl = GetIt.instance;

void setupServiceLocator() {
  // 🔌 Remote
  sl.registerLazySingleton(() => DioClient(token: sl()));

  // 💽 Local
  sl.registerLazySingleton<SqfliteClient>(() => SqfliteClient());

  // 📦 Repositories
  sl.registerFactory<PhotoRepository>(
    () => PhotoRepositoryImpl(remote: sl(), local: sl()),
  );

  // 🚀 Use-cases
  sl.registerFactory(() => GetRandomPhotos(sl()));

  // 🧠 BLoCs
  sl.registerFactory(() => HomeBloc(getRandomPhotos: sl()));
}
```

⚡ Performance Optimizations
Images: cached_network_image + shimmer skeletons

Search: input debounce to cut API calls

DB: indexed queries & batched writes

Network: timeout / retry wrapper, response caching

🚀 Getting Started
```# Clone
git clone https://github.com/RealCart/ImageFinderApp
cd ImageFinderApp

# Install dependencies
flutter pub get

# Run
flutter run```

