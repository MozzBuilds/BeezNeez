import UIKit

extension UINavigationController {

  open override func viewWillLayoutSubviews() {
      /// Hides the "Back" text that appears on someView when the stack is NavigationView > TabVIew > someView
      /// Note it was only visible when opening someView, then a subView, then going back to someView
      super.viewWillLayoutSubviews()
      navigationBar.topItem?.backButtonDisplayMode = .minimal
  }
}
