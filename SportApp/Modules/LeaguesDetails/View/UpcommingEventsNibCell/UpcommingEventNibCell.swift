//
//  UpcommingEventNibCell.swift
//  SportApp
//
//  Created by Menna Setait on 29/01/2024.
//

import UIKit
import Kingfisher

class UpcommingEventNibCell: UICollectionViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var firstLogo: UIImageView!
    @IBOutlet weak var firstTeamNameLabel: UILabel!
    @IBOutlet weak var secondLogo: UIImageView!
    @IBOutlet weak var secondTeamNameLabel: UILabel!
    @IBOutlet weak var statusOutlet: UILabel!
    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var timeOutlet: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.viewCell.layer.cornerRadius = 25
    }
    func configureupCommingEventCell(upCommingEvent:Event) {
        self.timeOutlet.text = upCommingEvent.event_time
        self.dateOutlet.text = upCommingEvent.event_date
        self.firstTeamNameLabel.text = upCommingEvent.event_home_team
        if let homeImage = upCommingEvent.home_team_logo,let awayImage =  upCommingEvent.away_team_logo{
            self.firstLogo.kf.setImage(with: URL(string: homeImage))
            self.secondLogo.kf.setImage(with:URL(string: awayImage))
        }
       
        self.secondTeamNameLabel.text = upCommingEvent.event_away_team
        
        }
}


//LatestEventNibCell
