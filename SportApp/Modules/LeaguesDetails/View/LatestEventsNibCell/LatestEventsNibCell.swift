//
//  LatestEventsNibCell.swift
//  SportApp
//
//  Created by Menna Setait on 03/02/2024.
//

import UIKit

class LatestEventsNibCell: UICollectionViewCell {

    @IBOutlet weak var dateOutlet: UILabel!
    @IBOutlet weak var timeOutlet: UILabel!
    @IBOutlet weak var homeTeam: UILabel!
    @IBOutlet weak var homeLogo: UIImageView!
    @IBOutlet weak var awayLogo: UIImageView!
    @IBOutlet weak var awayTeam: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configurelatestEventCell(latestEvent:Event) {
        self.timeOutlet.text = latestEvent.event_time
        self.dateOutlet.text = latestEvent.event_date
        self.homeTeam.text = latestEvent.event_home_team
        if let homeImage = latestEvent.home_team_logo,let awayImage =  latestEvent.away_team_logo{
            self.homeLogo.kf.setImage(with: URL(string: homeImage))
            self.awayLogo.kf.setImage(with:URL(string: awayImage))
        }
       
        self.awayTeam.text = latestEvent.event_away_team
        
        }
}



