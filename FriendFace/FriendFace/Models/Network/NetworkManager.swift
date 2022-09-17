//
//  NetworkManager.swift
//  FriendFace
//
//  Created by Omar Khattab on 14/09/2022.
//

import Foundation

struct NetworkManager {
    var apiUrl = "https://www.omarkhattab.tk/json/friendface.json"
    
    func getUsers() async -> [User]? {
        let url = URL(string: "\(apiUrl)")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringCacheData
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let decodedData = try decoder.decode([User].self, from: data)
            return decodedData
        } catch {
            print(error)
        }
        return nil
    }
}
