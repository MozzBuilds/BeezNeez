import SwiftUI

struct ContentView: View {
    @EnvironmentObject var supabaseManager: SupabaseManager
    
    init() {
//        UINavigationBar.appearance().backgroundColor = UIColor(Colors.appBackground)
//        UINavigationBar.appearance().barTintColor = UIColor(Colors.appBackground)
    }
    
    var body: some View {
        Group {
            if supabaseManager.isAuthenticated {
                // Main app view
                MainTabView()
            } else {
                LoginView()
            }
        }
        .task {
            // Check for existing session on appear
            await supabaseManager.checkSession()
        }
    }
}

#Preview {
    ContentView()
}

