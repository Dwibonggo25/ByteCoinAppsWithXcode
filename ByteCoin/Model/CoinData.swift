//
//  CoinData.swift
//  ByteCoin
//
//  Created by Dwi Bonggo Pribadi on 12/15/19.
//  Copyright © 2019 Dwi Bonggo Pribadi. All rights reserved.
//

import Foundation

struct CoinData: Decodable {
    
    let last: Double
    
    var lastString : String {
        return String(format: "%.1f", last)
    }
}
