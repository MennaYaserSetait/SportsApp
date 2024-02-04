//
//  HandelURL.swift
//  SportApp
//
//  Created by Menna Setait on 25/01/2024.
//

import Foundation
protocol ApiPreparationDelegate{
    func prepareAPIUrl() -> String
}
    // baseURL + sport + leaguesBlock + apiKey
    // baseURL + sport + league_Block,leagueID + Duration(from and to) + apiKey
    // baseURL + sport + team_Block,teamID + apiKey
    
struct HandelURL{
    
    
     private  let ApiKey = "6a72f7cc98af4bc82040a7ce839453c5c7f2b2699718fc519d38df5bae9922e0"
     private let mainSportsURl = "https://apiv2.allsportsapi.com/"
     private let sportType:String
     private let met:String
     private var leagueId:Int?
     private var teamId:Int?
     var sportChossen : sportTypeName?
    
    var URlApi: String {
        get{
            print("\(mainSportsURl)\(sportType)\(met)\(ApiKey)")
            return "\(mainSportsURl)\(sportType)\(met)\(ApiKey)"
        }
    }
    
    //init with to type of Sport
    init(sportType:String ){
        self.sportType = sportType
        self.met = Met.allLeagues.order
        self.sportChossen = sportTypeName(rawValue: sportType)
        
    }
    
    //init withupcomming Event for league Id
    init(sportType:String , leagueIdWithUpcomiingEvent:Int){
        self.sportType = sportType
        self.met = Met.getUpcomingEvents(leagueIdWithUpcomiingEvent).order
        self.leagueId = leagueIdWithUpcomiingEvent
        self.sportChossen = sportTypeName(rawValue: sportType)

    }
    
    
    //init with sport type and league ID updated event
    init(sportType:String , leagueIdWithLatestEvent:Int){
        self.sportType = sportType
        self.met = Met.getLatestResults(leagueIdWithLatestEvent).order
        self.leagueId = leagueIdWithLatestEvent
        self.sportChossen = sportTypeName(rawValue: sportType)
    }
    
    //init with sport type and league ID for latest Event
    init(sportType:String , teamId:Int){
        self.sportType = sportType
        self.met = Met.getTeamDetails(teamId).order
        self.teamId = teamId
        self.sportChossen = sportTypeName(rawValue: sportType)
    }
   
   
    // switch to choose the type of Getting Api
    enum Met {
        case allLeagues
        case getUpcomingEvents(Int)
        case getLatestResults(Int)
        case getTeamDetails(Int)
        
        var order:String{
            switch self {
            case .allLeagues: 
                return "/?met=Leagues&APIkey="
//            https://apiv2.allsportsapi.com/football/?met=Leagues&APIkey=
            case .getUpcomingEvents (let leagueID): return "?met=Fixtures&leagueId=\(leagueID)&from=\(Date.getCurrentDate())&to=\(Date.getNextYeatDate())&APIkey="
            case .getLatestResults (let leagueID): return "?met=Fixtures&leagueId=\(leagueID)&from=\(Date.getLastYearDate())&to=\(Date.getCurrentDate())&APIkey="
            case .getTeamDetails (let teamID): return "?&met=Teams&teamId=\(teamID)&APIkey="
            }
        }
    }
    
    
    enum sportTypeName:String{
        case football = "football"
        case basketball = "basketball"
        case tennis = "tennis"
        case cricket = "cricket"
    }
}


//MARK: - Applying protocol for get Url
extension HandelURL: ApiPreparationDelegate {
    func prepareAPIUrl() -> String {
        return URlApi
    }
}


// MARK: Adding extenision to The Date To Get Current ANd Next And Last Year
extension Date {
    static func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.string(from: Date())

        }
    
    static func getNextYeatDate() -> String {
            
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        return dateFormatter.string(from:calendar.date(byAdding: .year, value: 1, to: Date()) ?? Date())

        }
    
    static func getLastYearDate() -> String {
            
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var dateComponents = DateComponents()
        dateComponents.year = -1

        return dateFormatter.string(from:calendar.date(byAdding: dateComponents , to: Date()) ?? Date())

        }
    

}

