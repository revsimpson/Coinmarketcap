//
//  MVPCoin.swift
//  CoinmarketCap
//
//  Created by RichardSimpson on 23/02/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation
import Alamofire
import UnboxedAlamofire

protocol CoinInteractor {
    func getData(limit:Int,completion:  @escaping (_ data:[Coin]?,_ errorcode:UnboxedAlamofireError?)-> Void)-> Void
}

protocol CoinPresenter {
    func viewDidLoad()
    func getCoinData()->[Coin]
    func addFilter(filter:filterEnum)
    func removeFilters()
    func removeFilet(filter:filterEnum)
    func RefreshData()
}

protocol CoinView {
    func setSpinner(on:Bool)
    func dataLoaded()
}

protocol CoinCellProtocol {
    func setData(coin:Coin)
}
