//
//  File.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import Foundation

class BackendRequests {

    class func getTransactions(completion: @escaping([TransactionModel]) -> ()) {
        LootAPI.send(to: Constants.urlEndpoints.transactions.rawValue) { (transactions: [TransactionModel]) in
            completion(transactions)
        }
    }
}
