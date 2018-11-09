//
//  CoinPresenter.swift
//  CoinmarketCap
//
//  Created by RichardSimpson on 23/02/2018.
//  Copyright © 2018 Richard Simpson. All rights reserved.
//

import Foundation

class CoinPresenterImp : CoinPresenter {

    private var coindata:[Coin]?
    private let interactor: CoinInteractor
    private let view : CoinView?
    private var filtersArray = [filterEnum]()
    
    init(interactor: CoinInteractor, view: CoinView) {
        self.interactor = interactor
        self.view = view
    }
    
    func viewDidLoad() {
        interactor.getData(limit:500,completion: { (data, error) in
            if error == nil {
                self.coindata = data
                self.view?.dataLoaded()
            }
            else
            {
                print("FOUT :\(error!.description)")
            }
        })
    }
    
    func  RefreshData() {
        interactor.getData(limit:500,completion: { (data, error) in
            if error == nil {
                self.coindata = data
                self.view?.dataLoaded()
            }
            else
            {
                print("FOUT :\(error!.description)")
            }
        })
    }
    
    func addFilter(filter:filterEnum) {
        if !filtersArray.contains(filter) {
            filtersArray.append(filter)
        } else
        {
            filtersArray.remove(at: filtersArray.index(of: filter)!)
        }
        view?.dataLoaded()
    }
    
    func removeFilet(filter:filterEnum){
        if filtersArray.contains(filter) {
            filtersArray.remove(at: filtersArray.index(of: filter)!)
        }
    }
    
    func removeFilters() {
        filtersArray.removeAll()
        view?.dataLoaded()
    }
    
    func getCoinData()->[Coin] {
        var filteredData = [Coin]()
        if let coindata = coindata {
            filteredData = coindata
            for filter in filtersArray {
                switch filter {
                case .biggestGains:
                    filteredData = filteredData.sorted(by: {$0.changed_24h > $1.changed_24h })
                case .biggestLoss:
                    filteredData = filteredData.sorted(by: {$0.changed_24h < $1.changed_24h})
                case .losers:
                    filteredData = filteredData.filter{ $0.changed_24h < 0 }
                case .winners:
                    filteredData = filteredData.filter{ $0.changed_24h >= 0 }
                case .nofilter:
                     filteredData = coindata
                }
            }
            return filteredData
        } else {
            return [Coin]()
        }
    }
}
