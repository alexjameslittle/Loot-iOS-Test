//
//  LootAPI.swift
//  Loot-iOS-Test
//
//  Created by Alex Little on 06/11/2018.
//  Copyright © 2018 Alex Little. All rights reserved.
//

import Foundation

class LootAPI {
    class func send<T: Decodable>(to: String, method: String = "GET", completion: @escaping(T) -> Void) {
        let urlStr = Constants.shared.baseUrl + to
        guard let url = URL(string: urlStr) else {
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, res, error in
            guard error == nil else { return }
            guard let data = data else { return }
            do {
                let obj = try JSONDecoder().decode(T.self, from: data)
                completion(obj)
            } catch let err {
                print("Failed to decode json:", err)
            }
        }.resume()
    }
}
