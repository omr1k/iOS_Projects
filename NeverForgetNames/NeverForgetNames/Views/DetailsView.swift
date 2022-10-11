//
//  DetailsView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 09/10/2022.
//

import SwiftUI

struct DetailsView: View {
    
    var imgeFileName : String
    var imgePath : String
    var personName : String
    
    var body: some View {
        NavigationView(){
            VStack{
                Text("Image File Name: \(imgeFileName)")
                
                Text("Image Full Path: \(imgePath)")
                if let image = ImageUtils().loadImageFromDiskWith(fileName: imgeFileName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipped()
                        .cornerRadius(25)
                        // for placeholders
                        .foregroundColor(Color.gray)
                }
                Spacer()
            }
            
        }
        .navigationTitle(personName)
        .navigationBarTitleDisplayMode(.inline)
    }
}



//struct DetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailsView()
//    }
//}
