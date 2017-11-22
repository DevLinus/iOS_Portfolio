import Foundation
import UIKit

let memeTextAttributes:[String:Any] = [
    NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
    NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
    NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSAttributedStringKey.strokeWidth.rawValue: -4.0,
    ]

struct memeStorage {
    var oldImage : UIImage
    var newImage : UIImage
    var textTopTextField : String
    var textBottomTextField : String
    
}

