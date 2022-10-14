//
//  DetailsView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 09/10/2022.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    
    var imgeFileName : String
    var imgePath : String
    var personName : String
    var locations : [personData]
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30, longitude: 35), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    
    var body: some View {
        NavigationView(){
            VStack{
                Text("Image File Name: \(imgeFileName)")

                Text("Image Full Path: \(imgePath)")
                
                Map(coordinateRegion: $mapRegion, annotationItems: locations) { location in
                    MapAnnotation(coordinate: location.coordinate){
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                }
                .clipped()
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
