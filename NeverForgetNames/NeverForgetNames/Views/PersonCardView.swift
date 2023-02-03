//
//  PersonCardView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 03/02/2023.
//

import SwiftUI

struct PersonCardView: View {
    
    var personImage : UIImage
    var personName : String
    var job : String
    
    var body: some View {
        ZStack{
            HStack{
                    Image(uiImage: personImage)
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(10)
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.gray)
                        .padding(5)
                        .foregroundColor(.accentColor)
                VStack{
                    Text(personName)
                        .font(.title)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    
                    Text(job)
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .minimumScaleFactor(0.5)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                    Spacer()
                }
            .padding(5)
            }
        .background(.ultraThinMaterial.opacity(0.5))
        .shadow(radius: 10)
        .cornerRadius(10)
        .padding()
        
        }
    }


//struct PersonCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        PersonCardView( personName: "xas", job: "asa")
//            .previewLayout(.sizeThatFits)
//    }
//}
