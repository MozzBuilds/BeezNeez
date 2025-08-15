import SwiftUI

struct ContentView: View {
    
    init() {
//        UINavigationBar.appearance().backgroundColor = UIColor(Colors.appBackground)
//        UINavigationBar.appearance().barTintColor = UIColor(Colors.appBackground)
    }
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}

