import SwiftUI

@main
struct GitMindBloomApp: App {
    @StateObject private var authManager = AuthenticationManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if authManager.isAuthenticated {
                    HomeView()
                        .environmentObject(authManager)
                } else {
                    SignInView()
                        .environmentObject(authManager)
                }
            }
        }
    }
}
