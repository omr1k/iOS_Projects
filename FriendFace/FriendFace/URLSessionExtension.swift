//
//  URLSessionExtension.swift
//  FriendFace
//
//  Created by Omar Khattab on 11/09/2022.
//

import Foundation

extension URLSession {
  func fetchData<T: Decodable>(for url: URL, completion: @escaping (Result<T, Error>) -> Void) {
    self.dataTask(with: url) { (data, response, error) in
      if let error = error {
        completion(.failure(error))
      }
      if let data = data {
        do {
          let object = try JSONDecoder().decode(T.self, from: data)
          completion(.success(object))
        } catch let decoderError {
          completion(.failure(decoderError))
        }
      }
    }.resume()
  }
}


// uasge

//func loadData() async {
//      let url = URL(string: "\(apiUrl)")!
//      URLSession.shared.fetchData(for: url) { (result: Result<[User], Error>) in
//        switch result {
//        case .success(let resultData):
//            users = resultData
//        case .failure(let error):
//            print(error)
//      }
//    }
//}
