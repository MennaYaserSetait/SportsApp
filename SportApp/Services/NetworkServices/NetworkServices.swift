//
//  NetworkServices.swift
//  SportApp
//
//  Created by Menna Setait on 25/01/2024.
//

import Foundation
import Alamofire

protocol NetworkServiceDelegate{
    var setUrl:ApiPreparationDelegate {get set}
    func fetchDataFromAPI<T:Codable>(complitionHandler:@escaping(T? , Error?)->Void)
}

class NetworkServices: NetworkServiceDelegate {
    var setUrl: ApiPreparationDelegate
    
    init(setUrl:ApiPreparationDelegate){
        self.setUrl = setUrl
    }
  //6a72f7cc98af4bc82040a7ce839453c5c7f2b2699718fc519d38df5bae9922e0
    
    
    //MARK: - Fetching Data From Api
    func fetchDataFromAPI<T:Codable>(complitionHandler: @escaping (T?,Error?) -> Void) {
        AF.request(setUrl.prepareAPIUrl()).response { data in
            if let myData = data.data {
                do{
                    print("fetching")
                    print(myData.count)
                    let retreivedData = try JSONDecoder().decode(T.self, from: myData)
                    complitionHandler(retreivedData,nil)
                }catch let error{
                    complitionHandler(nil,error)
                    print("error in casting data")
                }
            }
            else{
                print("error gdan")
            }
        }
    }
}
