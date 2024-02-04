//
//  LeagueDetailsViewModel.swift
//  SportApp
//
//  Created by Menna Setait on 03/02/2024.
//

import Foundation
class LeagueDetailsViewModel{
   
    
    // MARK: -
    var upcomingNetworkHandler : NetworkServiceDelegate?
    
    var bindResultToViewController : (()->(Void))?
    
    init(upcomingNetworkHandler: NetworkServiceDelegate? ) {
        self.upcomingNetworkHandler = upcomingNetworkHandler
    }
    
  
    
    // MARK: -
    var upcomingEventsArray : [Event]?  {
        didSet{
            print("did set")
            if let validHander =  bindResultToViewController {
                validHander()
            }
        }
    }
    
    func getUpcomingEventArray()-> [Event]?{
        return upcomingEventsArray
    }
    
    
    // MARK: -
    func getEventsFromApi() {
        
        upcomingNetworkHandler?.fetchDataFromAPI(complitionHandler: { (dataValue:Events?, error: Error?) in
            if let data = dataValue {
                self.upcomingEventsArray = data.result
                print((self.upcomingEventsArray?[0]))
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
        
    }
    
    
    
}
// MARK: -
//    init(sport:String, leagueId:Int)  {
//        print("url init")
//        self.upcomingNetworkHandler = NetworkServices(setUrl: HandelURL(sportType: sport, leagueIdWithUpcomiingEvent: leagueId))
//
////        self.latestNetworkHandler = NetworkServices(setUrl: HandelURL(sportType: sport, leagueIdWithLatestEvent: leagueId))
////
//    }
