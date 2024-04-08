import Firebase

/// Manager for configuring and launching external libraries
final class LibraryManager {
    /// Perform the configuration
    func setupAllLibrary() {
        setupFirebase()
    }
}

fileprivate extension LibraryManager {

    func setupFirebase() {
        // FIXME: add `GoogleService-Info.plist` for all configs to the `Firebase` folder
        // FirebaseApp.configure()
    }
}
