//
//  FileManger.swift
//  HotProspects
//
//  Created by Omar Khattab on 19/10/2022.
//


import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
