//
//  ImageShow.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import ImageSlideShowSwift

class ImageShow: NSObject, ImageSlideShowProtocol
{
    var title: String?
    
    fileprivate let url:URL
    
    init(url:URL) {
        self.url = url
    }
    
    func slideIdentifier() -> String {
        return String(describing: url)
    }
    
    func image(completion: @escaping (_ image: UIImage?, _ error: Error?) -> Void) {
        
        let session = URLSession(configuration: URLSessionConfiguration.default)
        session.dataTask(with: self.url) { data, response, error in
            
            if let data = data, error == nil
            {
                let image = UIImage(data: data)
                completion(image, nil)
            }
            else
            {
                completion(nil, error)
            }
            
            }.resume()
        
    }
}
