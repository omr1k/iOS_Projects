//
//  ResponseModel.swift
//  UrlShorterner
//
//  Created by Omar Khattab on 16/01/2023.
//

import Foundation

struct responseModel: Identifiable, Codable{
    
    var id = UUID()
    let url : String
    
    enum CodingKeys: String, CodingKey {
        case url = "chilp.it"
    }
    
    static let sampleData = responseModel(url: "https://omarkhattab.tk")
    
}
