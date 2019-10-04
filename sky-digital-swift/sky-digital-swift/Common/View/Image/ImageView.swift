//
//  ImageView.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import UIKit
import Cartography

//MARK: - Properties
let imageCache = NSCache<NSString, UIImage>()

//MARK: - Protocol
protocol ProgrammableUIProtocol {
    func initViews()
    func setupConstraints()
}

class ImageView: UIImageView, ProgrammableUIProtocol {
    
    //MARK: - Properties
    var activityIndicator = UIActivityIndicatorView()
    var imageUrlString: String?
    
    //MARK: - LifeCicle
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        initViews()
        setupConstraints()
    }
    
    func initViews() {
        self.activityIndicator.style = .large
        self.activityIndicator.hidesWhenStopped = true
        
        self.addSubview(self.activityIndicator)
    }
    
    //MARK: - Actions
    func setupConstraints() {
        constrain(activityIndicator, self) { indicator, view in
            indicator.center == view.center
        }
    }
    
    func loadAndCacheImage(from urlString: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else {
            return
        }
        imageUrlString = urlString
        
        image = nil
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache
            completion?()
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if let er = error {
                print(er)
                return
            }
            
            DispatchQueue.main.async {
                if let da = data, let imageToCache = UIImage(data: da) {
                    if self.imageUrlString == urlString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: urlString as NSString)
                    completion?()
                }
            }
        }).resume()
    }
    
}
