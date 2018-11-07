//
//  Constants.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static var shared = Constants()

    let baseUrl = "http://private-710eeb-lootiosinterview.apiary-mock.com"

    enum urlEndpoints: String {
        case transactions = "/transactions"
    }
    enum errors: String, Error {
        case invalidUrl = "Invalid URL"
    }
}

extension Notification.Name {
    static let DidUpdateTransactions
        = NSNotification.Name("DidUpdateTransactions")
}

extension Array {
    public subscript(safe index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        return self[index]
    }
}

extension Date {
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }

    func readableDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, yyyy"
        return formatter.string(from: self)
    }

    func readableTime() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: self)
    }
}

extension Double {
    var currencyFormat: String? {
        let formatter = NumberFormatter()
        formatter.locale = Locale(identifier: "en_GB")
        formatter.numberStyle = .currency
        return formatter.string(from: self as NSNumber)
    }
}

extension Array where Element: Equatable {
    mutating func removeDuplicates() {
        var result = [Element]()
        for value in self {
            if !result.contains(value) {
                result.append(value)
            }
        }
        self = result
    }
}

extension UIView {
    func popIn(fromScale: CGFloat = 0.5, duration: TimeInterval = 0.5, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
        isHidden = false
        alpha = 0
        transform = CGAffineTransform(scaleX: fromScale, y: fromScale)
        UIView.animate(
            withDuration: duration, delay: delay, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.transform = .identity
                self.alpha = 1
        }, completion: completion)
    }
}
