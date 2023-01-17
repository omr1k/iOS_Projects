//
//  ContentViewViewModel.swift
//  UrlShorterner
//
//  Created by Omar Khattab on 16/01/2023.
//

import Foundation
import Combine

class ContentViewViewModel: ObservableObject{
    
    
    @Published var sortURL : String = ""
    let shortenApiBaseURl = "https://short-link-api.vercel.app/?query="
    var cancellables = Set<AnyCancellable>()
    @Published var  isLoading: Bool = false
    
    func getURL(inputURL: String){
        
        isLoading = true
        guard let url = URL(string: "\(shortenApiBaseURl)\(inputURL)") else {return}
        
        URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: DispatchQueue.main)
            .tryMap { (data, response) -> Data in
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300
                else { throw URLError(.badServerResponse) }
                return data
            }
            .decode(type: responseModel.self, decoder: JSONDecoder())
            .sink { (compe) in
                print("\(compe)")
            } receiveValue: { [weak self] (response) in
                print(response.url)
                self?.sortURL = response.url
                self?.isLoading = false
            }
            .store(in: &cancellables)
            
    }
}


// Combine discussion:
/*
// 1. sign up for monthly subscription for package to be delivered
// 2. the company would make the package behind the scene
// 3. recieve the package at your front door
// 4. make sure the box isn't damaged
// 5. open and make sure the item is correct
// 6. use the item!!!!
// 7. cancellable at any time!!
 
// 1. create the publisher
// 2. subscribe publisher on background thread
// 3. recieve on main thread
// 4. tryMap (check that the data is good)
// 5. decode (decode data into PostModels)
// 6. sink (put the item into our app)
// 7. store (cancel subscription if needed)
*/




//func xx(longURL: String) -> AnyPublisher<String, Never> {
//
//    guard let url = URL(string: "\(baseURl)\(longURL)") else { return.eraseToAnyPublisher() }
//
//    return URLSession.shared.dataTaskPublisher(for: url)
//        .map(\.data)
//        .decode(type: response.self, decoder: JSONDecoder())
//        .sink{
//            sortURl = $0.url
//        }
//        .replaceError(with: false)
//        .eraseToAnyPublisher()
//}
//
//
//func xx(longURL: String){
//    var cancellables = Set<AnyCancellable>()
//
//    let publisher: AnyPublisher<response, Error> = fetchURL(myURL)
//
//    publisher
//    .sink(receiveCompletion: { completion in
//    print(completion)
//    }, receiveValue: { (model: MyModel) in
//    print(model)
//}
