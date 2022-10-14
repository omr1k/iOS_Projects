//
//  FileManger.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 14/10/2022.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
