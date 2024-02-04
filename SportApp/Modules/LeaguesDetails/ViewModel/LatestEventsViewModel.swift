//
//  LatestEventsViewModel.swift
//  SportApp
//
//  Created by Menna Setait on 04/02/2024.
//

import Foundation
class LatestEventsViewModel{
    
    var latestNetworkHandler : NetworkServiceDelegate?
    var bindResultToViewController : (()->(Void))?
    init(latestNetworkHandler: NetworkServiceDelegate? = nil) {
        self.latestNetworkHandler = latestNetworkHandler
    }
    
    
    // MARK: -
    var latestEventsArray : [Event]?  {
        didSet{
            print("did set")
            if let validHander =  bindResultToViewController {
                validHander()
            }
        }
    }
    
    func getLatestEventsArray()-> [Event]?{
        return latestEventsArray
    }
    
    func getDataFromApi(){
        latestNetworkHandler?.fetchDataFromAPI(complitionHandler: { (dataValue:Events?, error: Error?) in
            if let data = dataValue {
                self.latestEventsArray = data.result
            }else {
                if let error = error{
                    print(error.localizedDescription)
                }
            }
        })
        }
    }

