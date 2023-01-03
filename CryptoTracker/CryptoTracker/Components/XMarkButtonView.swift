//
//  XMarkButtonView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 03/01/2023.
//

import SwiftUI

struct XMarkButtonView: View {
    
    
    var body: some View {
        Image(systemName: "xmark.app")
            .foregroundColor(Color.theme.accent)
            .bold()
        
    }
}

//struct XMarkButton_Previews: PreviewProvider {
//    static var previews: some View {
//        XMarkButton()
//            .previewLayout(.sizeThatFits)
//    }
//}
