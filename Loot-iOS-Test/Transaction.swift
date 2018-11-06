//
//  Transaction.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import Foundation
import CoreLocation

struct TransactionModel: Codable {
    var amount: Int
    var authorisationDate: String
    var description: String
    var location: TransactionLocation?
    var postTransactionBalance: Double
    var settlementDate: String
}

struct TransactionLocation: Codable {
    var longitude: Double
    var latitude: Double
}
