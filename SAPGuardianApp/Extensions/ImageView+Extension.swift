//
//  ImageViewExtension.swift
//  SAPGuardianApp
//
//  Created by Tarang Kaneriya on 13/09/21.
//

import UIKit
import SDWebImage

//MARK:- Image Cache Store

class ImageStore: NSObject {
    static let imageCache = NSCache<NSString, UIImage>()
}

extension UIImageView {
    //MARK:- Fetch image based on url
    func imageFromURL(_ url: String?) {
        DispatchQueue.global().async { [weak self] in
            guard let stringURL = url, let url = URL(string: stringURL) else {
                return
            }
            func setImage(image:UIImage?) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
            let urlToString = url.absoluteString as NSString
            // If Image avilable in image Cache return from Cache
            if let cachedImage = ImageStore.imageCache.object(forKey: urlToString) {
                setImage(image: cachedImage)
            //Fetch image from url
            } else if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    ImageStore.imageCache.setObject(image, forKey: urlToString)
                    setImage(image: image)
                }
            }else {
                // Set default image if unable to get image from URL
                setImage(image: #imageLiteral(resourceName: "placeholderImage"))
            }
        }
    }
}

//MARK:- Used SDWebImage for Cache of image wich can load image in offline even in app relaunch and Batter Cache handling
extension UIImageView {
    
    func imageFromURLWithCache(_ stringUrl: String?) {
        self.sd_setImage(with: URL(string: stringUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholderImage"))
    }
}
