//
//  LeaguesTableViewCell.swift
//  SportApp
//
//  Created by Menna Setait on 27/01/2024.
//

import UIKit
import Kingfisher

class LeaguesTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellView: UIView!
    
    @IBOutlet weak var detalisLeagueLabel: UILabel!
    @IBOutlet weak var logoLeageuImage: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 15
        logoLeageuImage.layer.cornerRadius = 35
    }
    
    //MARK: - Congfigure The Detalis of Cell
    func configureCell(league:League){
        detalisLeagueLabel.text = league.league_name
        logoLeageuImage.kf.setImage(with: URL(string: league.league_logo ?? "https://th.bing.com/th/id/OIP.B409vow4BZaqCmxWu6XeIQHaHL?rs=1&pid=ImgDetMain" )) 
    }

}
