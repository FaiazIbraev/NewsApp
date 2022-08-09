//
//  MainTableViewCell.swift
//  NewsApp
//
//  Created by Student on 2/8/22.
//

import UIKit

class MainTableViewCell: UITableViewCell {

    
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    let imageDownloader = ImageManager.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(article: Article){
        titleLabel.text = article.author
        subtitleLabel.text = article.title
        
        if let urlImage = article.urtToImage{
            imageDownloader.createRequest(urlString: urlImage) { [weak self] (data) in
                DispatchQueue.main.async {
                    self?.mainImageView.image = UIImage(data: data)
                }
            }
        }
    }
    
}
