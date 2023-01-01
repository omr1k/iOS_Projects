//
//  GlobalColor.swift
//  ToDoApp
//
//  Created by Omar Khattab on 06/12/2022.
//

import Foundation
import SwiftUI



struct CustomBackGroundColor: ViewModifier {
  
  func body(content: Content) -> some View {
    content
      .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
  }
}






//
//struct Color: ViewModifier {
//    func body(content: Content) -> some View {
//        content
//            .font(.largeTitle)
//            .foregroundColor(.white)
//            .padding()
//            .ignoresSafeArea()
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .background(Color(hue: 0.086, saturation: 0.141, brightness: 0.972))
//    }
//}
