import Foundation
import UIKit

extension UIImage{
    
    class func scaleImageToSize(imgage: UIImage, size: CGSize) ->UIImage{
        UIGraphicsBeginImageContext(size)
        imgage.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImageByContext = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImageByContext!
    }
}
