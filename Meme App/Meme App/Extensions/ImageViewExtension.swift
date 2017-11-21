import Foundation
import UIKit

extension UIImage{
    
    class func scaleImageToSize(img: UIImage, size: CGSize) ->UIImage{
        UIGraphicsBeginImageContext(size)
        img.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImage!
    }
}
