//
//  TeamDetailsNibCell.swift
//  SportApp
//
//  Created by Menna Setait on 29/01/2024.
//

import UIKit

class TeamDetailsNibCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 25
    }
    func configure(team:TeamModel) {
        self.teamName.text = team.teamName
        if let teamLogo = team.teamLogo{
            self.teamLogo.kf.setImage(with: URL(string: teamLogo))
        }
    }

}
