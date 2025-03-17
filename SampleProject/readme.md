## Mini Project
> This project showcases how I usually structure and code nowadays any Xcode Project. Also using both SwiftUI and UIKit (if that's needed).
### Networking
* Fetching and displaying data. Used a mock JSON service to retrieve and display posts. With more time, proper error handling would be incorporated on the UI, but it's already tackled logic wise using `Result`.
* Networking is built with a `Router` and `NetworkingService` (protocols) allowing Dependency Injection in the ViewModel and make it flexible for future expansions of the api.
* ViewModel is shared between SwiftUI and UIKit, keeping the logic consistent.

### Project Structure
* The project is modularized for scalability maintainability. Everything is feature-based, keeping code organized and modular.
* This allows for the future to move modules into actual Swift Packages totally decoupled from the rest.

### Architecture and approaches
* Uses MVVM for clear separation of concerns and Dependency Injection that improves testability.
* Use of async/await instead of Combine or GCD as a preference (keeping th ecode simpler and cleaner).

### UI and Design
* Mini design system: Uses @Environment to manage app-wide theme, colors, fonts, measurements, etc. consistently.
* Showcases a simple implementation of Dynamic Type and Dark Mode.
* Demonstrates the boilerplate difference between SwiftUI and UIKit for the same exact feature.


### Unit Testing and best practices
* Some quick unit tests to showcase structure (ideally, all ViewModels and Models would be fully tested).
* Snapshot test could be added to verify UI consistency across different screens, text sizes or themes.

### Summary
* Scalable feature based architecture
* Reusable and testable networking layer
* Design System and UI Consistency
* Differences between SwiftUI and UIkit and how they can coexist.
* Structure, modern and testable approach that makes it clean and future proof.
