import Foundation
import Alamofire
import AlamofireImage

extension UIImageView {
    func loadImage(imageURL: String) {
        Alamofire.request(imageURL).responseImage { response in
            if let image = response.result.value {
                self.image = image
            } else {
                //TODO: Add failure block
            }
        }
    }
}
