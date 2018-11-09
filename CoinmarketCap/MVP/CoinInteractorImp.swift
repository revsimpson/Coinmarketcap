//
//  CoinInteractorImp.swift
//  CoinmarketCap
//
//  Created by RichardSimpson on 23/02/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
import Alamofire
import UnboxedAlamofire

class CoinInteractorImp:CoinInteractor {
    
    func getData(limit:Int = 1000, completion:  @escaping (_ data:[Coin]?,_ errorcode:UnboxedAlamofireError?)-> Void)-> Void   {
        let url = URL(string:"https://api.coinmarketcap.com/v1/ticker/?convert=EUR&limit=\(limit)")
        Alamofire.request(url!,method: .get).validate().responseArray { (response: DataResponse<[Coin]>) in
            if let response = response.result.value {
                completion(response,nil)
            } else {
                let fout = response.result.error as? UnboxedAlamofireError
                print("Fout:\(fout.debugDescription)")
                if let error = response.result.error as? UnboxedAlamofireError{
                    completion(nil,error)
                } else{
                    print("Er gebeurde een fout die eigenlijk niet voor mag komen")
                }
            }
        }
    }
}
