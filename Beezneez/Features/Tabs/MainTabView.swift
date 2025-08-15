import SwiftUI

//struct MainTabView: View {
//    @StateObject var userManager = UserManager.shared
//    @State private var selectedTab = 0
//    
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            // Always visible for everyone
//            DiscoverTab()
//                .tabItem {
//                    Label("Discover", systemImage: "magnifyingglass")
//                }
//                .tag(0)
//            
//            // Visible if user has any appointments (as client)
//            if userManager.hasClientProfile {
//                MyBookingsTab()
//                    .tabItem {
//                        Label("My Bookings", systemImage: "calendar")
//                    }
//                    .tag(1)
//            }
//            
//            // Visible if user owns any businesses
//            if userManager.hasBusinesses {
//                BusinessTab()
//                    .tabItem {
//                        Label("Business", systemImage: "briefcase")
//                    }
//                    .tag(2)
//            }
//            
//            // Always visible
//            ProfileTab()
//                .tabItem {
//                    Label("Profile", systemImage: "person.circle")
//                }
//                .tag(3)
//        }
//    }
//}

struct MainTabView: View {
    @EnvironmentObject var supabaseManager: SupabaseManager
    
    var body: some View {
        TabView {
            Text("Discover")
                .tabItem {
                    Label("Discover", systemImage: "magnifyingglass")
                }
            
            Text("Bookings")
                .tabItem {
                    Label("Bookings", systemImage: "calendar")
                }
            
            Text("Profile")
                .tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
        }
        .overlay(alignment: .topTrailing) {
            // Temporary sign out button for testing
            Button("Sign Out") {
                Task {
                    try? await supabaseManager.signOut()
                }
            }
            .padding()
        }
    }
}
