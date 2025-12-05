# Learnify Client - Comprehensive System Design Document

**Project Name:** Learnify Client
**Version:** 1.0.0 (Production Release)
**Date:** December 2025
**Confidentiality:** Client Confidential

---

## 1. Executive Summary
**Learnify Client** is a premium, cross-platform educational application built with Flutter. It serves as a bridge between learners and mentors, providing a robust platform for course discovery, enrollment, and personalized learning. The application is designed with a focus on scalability, security, and a superior user experience, utilizing a Clean Architecture pattern to ensure long-term maintainability.

---

## 2. System Actors & Roles
*   **Student (Main User):** The primary end-user who registers, browses courses, manages their profile, and interacts with learning content.
*   **System Administrator:** (Backend Role) Manages course content, user accounts, and system configurations via the dashboard.
*   **API Server:** The external entity responsible for data processing, authentication verification, and storage.

---

## 3. Functional Requirements (FR)

### 3.1 Module: Authentication & Authorization
**FR-01: User Registration**
*   The system shall allow new users to create an account using: Name, Email Address, Valid Phone Number, and Password (min 6 chars).
*   The system must validate that the email is unique and the phone number is valid.
*   Upon success, the user is automatically logged in and their data is cached locally.

**FR-02: User Login**
*   The system shall allow existing users to log in using their registered Email and Password.
*   The system must authenticate credentials against the backend API.
*   The system must persist the session (using JWT tokens) so users remain logged in after closing the app.

**FR-03: Password Management**
*   The system shall provide a mechanism for users to validate their current password before making sensitive changes.
*   The system shall allow users to change their password securely.

**FR-04: Logout**
*   The system shall provide a secure Logout function that:
    1.  Invalidates the local session.
    2.  Clears sensitive user data (tokens) from the secure storage.
    3.  Redirects the user to the Sign-In screen.

### 3.2 Module: Onboarding & Navigation
**FR-05: Onboarding Flow**
*   The system shall present a multi-step Onboarding tutorial for first-time users, explaining key app features.
*   The system must record the completion of onboarding to prevent it from reappearing.

**FR-06: Bottom Navigation**
*   The system shall provide a persistent Bottom Navigation Bar accessible from core screens, linking to: Home, Courses, Favorites, and Profile.

### 3.3 Module: Home & Discovery
**FR-07: Course Categorization**
*   The system shall display courses organized by Categories (e.g., Coding, Design, Business).
*   The system shall allow users to filter courses by these categories.

**FR-08: Featured Courses**
*   The system shall highlight "Featured Courses" on the Home Screen for quick access.
*   Clicking a course must navigate to the Detailed Course View.

**FR-09: Search Functionality**
*   The system shall allow users to search for courses by title or keywords.
*   Search results shall update in real-time or upon submission.

### 3.4 Module: Course Management
**FR-10: Course Details**
*   The system shall display comprehensive details for each course: Title, Instructor Name, Description, Price, Rating, and Visual Assets (Images/Video).

**FR-11: Favorites / Wishlist**
*   The system shall allow users to toggle courses as "Favorite".
*   This list must be persisted locally so users can access saved items offline.

### 3.5 Module: User Profile & Settings
**FR-12: Profile Management**
*   The system shall display the user's Name, Email, and Avatar.
*   The system shall allow editing of profile details (Name, Phone).

**FR-13: Localization (Multi-language)**
*   The system shall support switching between **English** and **Arabic** languages dynamically.
*   The Layout direction (LTR/RTL) must automatically adjust based on the selected language.

**FR-14: Theme Customization**
*   The system shall support **Light** and **Dark** modes.
*   The user's preference must be saved and applied automatically on next launch.

---

## 4. Non-Functional Requirements (NFR)

### 4.1 Performance & Efficiency
**NFR-01: Startup Time**
*   The application shall load the Home Screen (for logged-in users) in under **2 seconds**.
*   *Implementation:* Achieved via local Hive caching of user sessions.

**NFR-02: Network Optimization**
*   The system shall minimize data usage by caching API responses where appropriate.
*   Lazy loading shall be used for images and list items to ensure smooth scrolling.

### 4.2 Local Storage & Offline Capability
**NFR-03: Offline Access**
*   The system shall allow users to access previously loaded content (Favorites, Basic Profile Info) even without an active internet connection.
*   *Implementation:* Hive NoSQL database is used for robust local persistence.

### 4.3 Security & Data Integrity
**NFR-04: Secure Token Storage**
*   Authentication tokens (JWT) shall be stored in encrypted local storage boxes, never in plain text shared preferences.

**NFR-05: Input Validation**
*   All user inputs (Forms) must be validated on the client side (Regex for Email, Length checks for Password) before reaching the server to prevent injection attacks and reduce server load.

### 4.4 Usability & Accessibility
**NFR-06: User Interface Feedback**
*   The system must provide immediate visual feedback for all actions (Loading spinners, Success Snackbars, Error Alerts).
*   Errors must be presented in human-readable language, not technical coding errors.

**NFR-07: Consistency**
*   The UI must maintain consistent typography (Poppins Font), Color Palette (Primary Blue `#056AFF`), and component styling across all screens.

### 4.5 Reliability & Robustness
**NFR-08: Error Handling Strategy**
*   The system shall implement global exception handling to catch network timeouts or server 500/404 errors gracefully without crashing the application.

---

## 5. Technical Architecture Specifications

### 5.1 Architecture Patterns
*   **Pattern:** MVVM (Model-View-ViewModel) adapted as **Bloc/Cubit Pattern**.
*   **Benefits:** Separetes Business Logic from UI Code, making the codebase testable and modular.

### 5.2 Technology Stack
*   **Framework:** Flutter SDK ^3.5.1
*   **Language:** Dart ^3.0.0
*   **State Management:** flutter_bloc ^8.1.6
*   **Networking:** dio ^5.6.0 (with Interceptors for Logging & Auth)
*   **Database:** hive ^2.2.3 (Key-Value Pair Storage)
*   **Localization:** flutter_localizations (ARB files)

### 5.3 Core Directories
*   `lib/cubit`: Contains Global Logic states (Login, Settings).
*   `lib/helpers`: Contains Data Providers (DioHelper, HiveHelper).
*   `lib/screens`: Contains UI Screens (Presentation Layer).
*   `lib/models`: Contains Data Transfer Objects (DTOs).

---

## 6. Future Roadmap
*   **Phase 2:** Implementation of live video streaming module.
*   **Phase 3:** Integration of real-time chat between mentors and students.
*   **Phase 4:** Payment Gateway Integration.

---
**Prepared For:** Client Delivery
**Learnify Development Team**
