//
//  SportsCollectionViewCell.swift
//  SportApp
//
//  Created by Menna Setait on 25/01/2024.
//

import UIKit

class SportsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    @IBOutlet weak var imgView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = K.customCellOfCollectionViewCornerRadius
    }
    
    func configure(with imageName: String , titleText: String) {
        if let iconImage = imgView {iconImage.image = UIImage(named: imageName)}
        if let titleLabel = myLabel {
            titleLabel.text = titleText
        }
    }

}
