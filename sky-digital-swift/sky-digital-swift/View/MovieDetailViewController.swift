//
//  MovieDetailViewController.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import UIKit
import ImageSlideShowSwift

//MARK: - Protocol
protocol MovieDetailViewControllerProtocol {
    func setScreen()
}

class MovieDetailViewController: UIViewController, MovieDetailViewControllerProtocol {

    //MARK: - Outlets
    @IBOutlet weak var movieIV: ImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var durationLbl: UILabel!
    @IBOutlet weak var launchLbl: UILabel!
    @IBOutlet weak var overViewLbl: UILabel!
    
    //MARK: - Properties
    var images:[ImageShow] = []
    var movie: Movie!
    
    //MARK: - CicleLife
    override func viewDidLoad() {
        super.viewDidLoad()

        self.setScreen()
        self.generateImages()
    }
    
    //MARK: - Actions
    func setScreen(){
        self.movieIV.loadAndCacheImage(from: self.movie.coverURL ?? "")
        self.titleLbl.text = "Titulo: \(self.movie.title ?? "")"
        self.durationLbl.text = "Duração: \(self.movie.duration ?? "desconhecido")"
        self.launchLbl.text = "Lançamento: \(self.movie.releaseYear ?? "desconhecido" )"
        self.overViewLbl.text = "Sinopse: \(self.movie.overview ?? "")"
    }
    
    @IBAction func showBackdropsAction(_ sender: UIButton) {
        guard !(self.movie.backdropsURL?.isEmpty ?? true) else{
            return
        }
        
        ImageSlideShowViewController.presentFrom(self){ [weak self] controller in
            controller.dismissOnPanGesture = true
            controller.slides = self?.images
            controller.enableZoom = true
        }
    }
    
    private func generateImages(){
        guard !(self.movie.backdropsURL?.isEmpty ?? true) else{
            return
        }
        
        for urlImage in self.movie.backdropsURL ?? []{
            if !urlImage.isEmpty{
                images.append(ImageShow(url: URL(string: urlImage)!))
            }
        }
    }
    
}
