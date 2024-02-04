//
//  AllLeague.swift
//  SportApp
//
//  Created by Menna Setait on 26/01/2024.
//

import Foundation
protocol AllLeagueProtocol{
    
    func getDataFromApiForLeagues()
    func getLeaguesArray()->[League]?
    func getNumberOfLeagues() -> Int?
    var  bindResultToViewController : (()->Void)?{get set}
}

class AllLeague:AllLeagueProtocol{
    
    var networkHandler : NetworkServiceDelegate?
    var bindResultToViewController : (()->(Void))?
    
    init(networkHandler: NetworkServiceDelegate?) {
        self.networkHandler = networkHandler
    }

    var leaguesArray : [League]?  {
        didSet{
            print("did set")
            if let validHander =  bindResultToViewController {
                validHander()
            }
        }
    }
    
    func getLeaguesArray()-> [League]?{
        return leaguesArray
    }

    //MARK: -CAll Request of Api
    func getDataFromApiForLeagues() {
        networkHandler?.fetchDataFromAPI(complitionHandler: { (data:Leagues?, error: Error?) in
            print("data:League]?, error: Error?")
            if let data = data{
                print(data.success)
                print("data=leaguesArray")
                self.leaguesArray = data.result
                //self.leaguesArray = data.result
                print("in view")
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
    }
    
    
    //MARK: -Getting Number of Leagues
    func getNumberOfLeagues() -> Int? {
        return leaguesArray?.count
        
    }
    

  
    
}
