# image_finder_app

# 🖼️ Image Finder App

🔍 Discover • ❤️ Favorite • 💾 Download • 📱 Offline

---

## ✨ Project Overview
**Image Finder App** is a Flutter application that lets users explore high-quality photos from Unsplash, save their favorites, and download shots directly to the device gallery.  
Built with **Clean Architecture + MVI**, it keeps business logic, data, and UI neatly separated for easy maintenance and testing.

---

## 🏗️ Architecture & Design Patterns
| Layer | Patterns & Tools |
|-------|------------------|
| **Presentation** | **BLoC** (flutter_bloc) · MVI cycle (Intent → BLoC → State → UI) |
| **Domain** | **Use Case** pattern · Entities · Repository interfaces |
| **Data** | **Repository** + Data Sources (Remote + Local) · **Either** functional error handling |
| **Core** | **Service Locator** (GetIt) · **Singletons** (`DownloadService`, `SqfliteClient`) |

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
```lib/
┣ core/
┃ ┣ config/ → global themes, constants
┃ ┣ data/ → reusable clients (Dio, Sqflite, Download)
┃ ┣ domain/ → base entities, repositories, use-cases
┃ ┣ utils/ → debounce, error wrappers, enums
┃ ┗ presentation/ → global widgets, router
┣ features/
┃ ┣ home/ → photo feed + search
┃ ┣ favorites/ → saved photos
┃ ┗ photo/ → photo-detail screen
┗ main.dart````


---

## 🌟 Key Features
- **Random Discovery:** one-tap fetch of fresh Unsplash photos
- **Smart Search:** debounced text search with instant results
- **Favorites:** add/remove & persist via SQLite
- **Full-Screen Detail:** author info, palette-friendly UI
- **1-Click Download:** save to gallery with permission flow + progress bar
- **Offline Access:** cached random photos available without network

---

## 🗄️ Database Schema
```sql
-- Cached random photos
CREATE TABLE cached_random_photo (
  id     INTEGER PRIMARY KEY AUTOINCREMENT,
  value  TEXT NOT NULL
);

-- Favorite photos
CREATE TABLE favorites_photo (
  id     TEXT PRIMARY KEY,
  value  TEXT NOT NULL
);


User Intent → Event → BLoC → New State → UI Render
```User Intent → Event → BLoC → New State → UI Render```

```Example: Download Button

DownloadPhotoEvent → BLoC

BLoC executes DownloadPhotoUseCase

Use-case calls Repository ➜ DownloadService + saver_gallery

Emits DownloadSuccess / DownloadFailure state

UI shows progress or snackbar```

// core/service_locator.dart
final sl = GetIt.instance;

void setupServiceLocator() {
  // 🔌 Remote
  sl.registerLazySingleton(() => DioClient(token: sl()));
  // 💽 Local
  sl.registerLazySingleton<SqfliteClient>(() => SqfliteClient());
  // 📦 Repositories
  sl.registerFactory<PhotoRepository>(() => PhotoRepositoryImpl(
        remote: sl(), local: sl()));
  // 🚀 Use-cases
  sl.registerFactory(() => GetRandomPhotos(sl()));
  // 🧠 BLoCs
  sl.registerFactory(() => HomeBloc(getRandomPhotos: sl()));
}

⚡ Performance Optimizations
Images: cached_network_image + shimmer skeletons

Search: debounce to reduce API calls

DB: indexed queries & batched writes

Network: timeout / retry wrapper, response caching

🤝 Contributing
Fork 🍴 the repo

Create your feature branch: git checkout -b feat/my-awesome-feature

Commit your changes: git commit -m "Add awesome feature"

Push to the branch: git push origin feat/my-awesome-feature

Open a Pull Request 🎉



## Getting Started
Steps to run the project

1) git clone https://github.com/RealCart/ImageFinderApp
2) flutter pub get
3) flutter run
