# Game Challenge

A game application developed with Flutter.

## Project Architecture

This project is developed following Clean Architecture principles.

### Layered Architecture Structure

#### 1. Core Layer
Contains the fundamental building blocks of the application:
- Theme configurations
- Colors
- Base configurations
- Utilities and constants

#### 2. Data Layer
Handles data operations:
- Models
- Data sources (local/remote)
- Repositories
- DTOs (Data Transfer Objects)

#### 3. Domain Layer
Contains the business logic:
- Entities
- Use cases
- Repository interfaces
- Domain models

#### 4. Presentation Layer
Manages the UI and state:
- Views/Pages
- ViewModels (using Provider pattern for state management)
- Widgets
- UI Components

#### 5. Infrastructure
- Localization support (with English and Turkish languages)
- Platform-specific configurations
  - iOS
  - Android
  - Windows
  - macOS

#### 6. Application Layer
Main application setup and configuration:
- App initialization
- Dependency injection setup
- Route configuration
- Theme setup
- Localization configuration

### Key Architectural Features

1. **Dependency Injection**
   - Using GetIt for service location
   - Centralized dependency management

2. **State Management**
   - Provider pattern implementation
   - Centralized state handling

3. **Routing**
   - Centralized routing system
   - Named route navigation

4. **Internationalization**
   - Multi-language support
   - English and Turkish languages
   - Extensible language system

5. **Clean Architecture**
   - Separation of concerns with distinct layers
   - SOLID principles implementation
   - Clear dependency rules

6. **Platform Support**
   - Cross-platform implementation
   - Native configurations for each platform
   - Consistent user experience

### Architecture Benefits

This architecture ensures:
- **High maintainability**: Clear separation of concerns makes maintenance easier
- **Testability**: Independent layers can be tested in isolation
- **Scalability**: New features can be added without modifying existing code
- **Separation of concerns**: Each layer has its specific responsibility
- **Platform independence**: Core business logic is separated from platform-specific code
- **Code reusability**: Components can be reused across different parts of the application

The project strictly follows SOLID principles and maintains a clear separation between different layers of the application, making it easier to modify and extend functionality without affecting other parts of the system.
