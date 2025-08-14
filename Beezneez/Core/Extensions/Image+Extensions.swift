import UIKit

extension UIImage {
    
    static func coloredImage(color: UIColor, width: CGFloat, height: CGFloat) -> UIImage {
        
        let size = CGSize(width: width, height: height)
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return image
        // Used for placeholders whilst we're still waiting on assets. Allows us to use a colored bloc as an image and resize it as we need to, so when the asset is ready it's a simple swap over
        // Usage example:
            // let image = coloredImage(color: .cyan, width: 200, height: 200)
    }
}
