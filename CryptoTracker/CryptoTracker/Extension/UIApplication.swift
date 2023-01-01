//
//  UIApplication.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 01/01/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    // Use objective-c method to dismiss any editing e.g hide keyboard in our case
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

