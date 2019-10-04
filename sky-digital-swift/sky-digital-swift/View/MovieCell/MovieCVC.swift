//
//  MovieCVC.swift
//  sky-digital-swift
//
//  Created by joao.vitor.f.naves on 04/10/19.
//  Copyright © 2019 vitor.neves. All rights reserved.
//

import UIKit

class MovieCVC: UICollectionViewCell {

    //MARK: - Outlets
    @IBOutlet weak var movieIV: ImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    //MARK: - CicleLife
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    //MARK: - Actions
    func setCell(movie: Movie){
        self.movieIV.loadAndCacheImage(from: movie.coverURL ?? "")
        self.titleLbl.text = movie.title ?? "Desconhecido"
    }

}
