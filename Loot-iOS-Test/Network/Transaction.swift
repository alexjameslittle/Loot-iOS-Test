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
    var amount: String
    var authorisationDate: String
    var description: String
    var location: TransactionLocation?
    var postTransactionBalance: String
    var settlementDate: String

    var authDate: Date? {
        let df = ISO8601DateFormatter()
        return df.date(from: authorisationDate)
    }

    var amountValue: Double? {
        return Double(amount)
    }

    enum CodingKeys: String, CodingKey {
        case amount, description, location
        case authorisationDate = "authorisation_date"
        case postTransactionBalance = "post_transaction_balance"
        case settlementDate = "settlement_date"
    }
}

struct TransactionLocation: Codable {
    var longitude: String
    var latitude: String
}
