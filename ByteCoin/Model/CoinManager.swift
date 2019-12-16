//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Dwi Bonggo Pribadi on 12/13/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import Foundation

struct CoinManager {
    
    var delegate: ByteCoinDelegate?
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    func getCoinPrice(for currency: String) {
        
        let urlString = baseURL+currency
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url){ (data, response, error) in
                if error != nil {
                    return
                }
                
                if let safeData = data {
                    if let bitCoinPrice = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoint(data: bitCoinPrice)
                    }
                   
                }
            }
            
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> CoinData? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodeFile = try decoder.decode(CoinData.self, from: data)
            
            
            let lastPrice = CoinData(last: decodeFile.last)
            
            return lastPrice
        } catch {
            return nil
        }
    }
}

protocol ByteCoinDelegate {
    func didUpdateCoint (data: CoinData)
}
