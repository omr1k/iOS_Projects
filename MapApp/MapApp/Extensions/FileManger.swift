//
//  FileManger.swift
//  MapApp
//
//  Created by Omar Khattab on 16/02/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
