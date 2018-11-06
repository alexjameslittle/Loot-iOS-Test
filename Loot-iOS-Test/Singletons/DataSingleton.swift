//
//  DataSingleton.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import Foundation

class DataSingleton {

    static var shared = DataSingleton()

    var transactions = [TransactionModel]()

    var transactionDates = [Date]()

    func updateTransactions() {
        BackendRequests.getTransactions { transactionArray in
            self.transactions = transactionArray
            self.setTransactionDates()
            NotificationCenter.default.post(name: .DidUpdateTransactions, object: nil)
        }
    }

    func setTransactionDates() {
        self.transactionDates = transactions.compactMap({ (model) -> Date? in
            return model.authDate?.startOfDay
        })
        self.transactionDates.removeDuplicates()
    }

    func transactionsForDate(date: Date) -> [TransactionModel] {
        return self.transactions.filter {$0.authDate?.startOfDay == date.startOfDay}
    }
}
