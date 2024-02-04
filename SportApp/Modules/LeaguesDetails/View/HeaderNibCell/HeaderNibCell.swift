//
//  HeaderNibCell.swift
//  SportApp
//
//  Created by Menna Setait on 01/02/2024.
//

import UIKit

class HeaderNibCell: UICollectionViewCell {

    @IBOutlet weak var headerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    var title : String? {
        didSet{
            headerLabel.text = title
        }
    }

}
