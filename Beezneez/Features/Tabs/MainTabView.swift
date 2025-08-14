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
