import Foundation
import UIKit

extension UIImage{
//https://www.youtube.com/watch?v=wXDkZqmXVBs the code comes from this video.
    class func scaleImageToSize(imgage: UIImage, size: CGSize) ->UIImage{
        UIGraphicsBeginImageContext(size)
        imgage.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let scaledImageByContext = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return scaledImageByContext!
    }
}
