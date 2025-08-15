import SwiftUI

struct NavigationUtil {
    
    /// SwiftUI has no popToRoot functionality in iOS15, and is slightly improved in iOS16 with NavStack
    /// This struct uses popToRootView successfully
    
  static func popToRootView() {
      
      let viewController = UIApplication
          .shared
          .connectedScenes
          .compactMap { ($0 as? UIWindowScene)?.keyWindow }
          .first?.rootViewController
      
      guard let viewController else { return }
      
      if let navigationController = getNavigationController(viewController: viewController) {
          navigationController.popToRootViewController(animated: true)
      }
  }

  static func getNavigationController(viewController: UIViewController) -> UINavigationController? {

    if let navigationController = viewController as? UINavigationController {
      return navigationController
    }

    for childViewController in viewController.children {
      return getNavigationController(viewController: childViewController)
    }

    return nil
  }
}

public struct BackportNavigationStack<Root: View, Data: Hashable>: View {
    var data: Binding<[Data]>?
    var root: () -> Root
    
    public init(data: Binding<[Data]>? = nil, @ViewBuilder root: @escaping () -> Root) {
        self.data = data
        self.root = root
    }
    
    public var body: some View {
        NavigationStack(path: data ?? .constant([])) {
            root()
        }
    }
}

public struct BackportNavigationLink<P: Hashable, Label: View>: View {
    var value: P?
    var label: Label

    public init(value: P?, @ViewBuilder label: () -> Label) {
        self.value = value
        self.label = label()
    }
    
    public var body: some View {
        NavigationLink(value: value) {
            label
        }
    }
}

public extension BackportNavigationLink where Label == Text {
    init(_ titleKey: LocalizedStringKey, value: P?) {
        self.init(value: value) { Text(titleKey) }
    }

    init<S>(_ title: S, value: P?) where S: StringProtocol {
        self.init(value: value) { Text(title) }
    }
}

public extension View {
    func backportNavigationDestination<D: Hashable, C: View>(for pathElementType: D.Type, @ViewBuilder destination builder: @escaping (D) -> C) -> some View {
        navigationDestination(for: pathElementType, destination: builder)
    }
}
