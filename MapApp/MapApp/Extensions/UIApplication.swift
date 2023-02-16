//
//  UIApplication.swift
//  MapApp
//
//  Created by Omar Khattab on 16/02/2023.
//

import Foundation
import SwiftUI

extension UIApplication {
    
    // Use objective-c method to dismiss any editing e.g hide keyboard in our case
    func endEditing(){
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
