# project

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

https://github.com/user-attachments/assets/7d18e367-6daf-42d0-97d3-269864e076b5

## API Choice
**API Name:** Studio Ghibli API
**Base URL:** https://ghibliapi.vercel.app/
**Documentation:** https://ghibliapi.vercel.app
**Auth Required:** None 
**Response Format:** JSON

The Studio Ghibli API provides rich, structured JSON data about the world of Studio Ghibli — including people, species, locations, and films. It is a RESTful web service that requires no authentication and supports HTTPS, making it ideal for multi-endpoint Flutter integration and dynamic data display in mobile applications.

---

## Endpoints Integrated

| # | Method | Path | Feature |
|---|--------|------|---------|
| 1 | GET | `/people` | List all characters |
| 2 | GET | `/films` | List all films |
| 3 | GET | `/locations` | List all location |
| 4 | GET | `/species` | List all species |

All four endpoints are accessible through distinct screens within the application, which are organized using a bottom navigation bar.

---

## App Structure

```
lib/
├── model/
|     └── animi.dart   # Dart model — parses all JSON fields
├── screen/
|      └── signin.dart  # Sign in
├── server/
|      ├── anime.dart   # Design
|      ├── api_anime.dart  #Endpoint 1 - List all film
|      ├── detail.dart  # Details of film
|      ├── Species.dart # Endpoint 2 - List all Species
|      └── tile.dart   # Design
├── tab/
|    ├── home.dart   # Home page
|    ├── profile.dart  # Endpoint 3 - List all characters
|    └── settings.dart  # Endpoint 4 - List all Locations
├── dashboard.dart
├── main.dart
```

### Navigation

A `BottomNavigationBar` provides access to three top-level sections:

-**Anime** — Show All Film
-**People** — Show All Character
-**Location** — Show All Location

---

## Implementation Details

### HTTP Client
Uses the http
 package, manually combining a base URL with endpoints and applying a timeout for requests. This approach provides a lightweight way to consume RESTful APIs in Flutter applications.



