//
//  DetailsView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 09/10/2022.
//

import SwiftUI
import MapKit

struct DetailsView: View {
    let person: [Person]
    var imgeFileName : String
    var imgePath : String
    var personName : String
    @State private var pickerTab = 0
    @State private var toggleView = false
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30, longitude: 35), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    var body: some View {
        NavigationView(){
            
            VStack{
                Picker("", selection: $pickerTab) {
                    Text("Photo").tag(0)
                    Text("location").tag(1)
                    
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                if pickerTab == 0 {
                    
//                    Text("(For Testing) Image File Name: \(imgeFileName)")
//                    
//                    Text("(For Testing) Image Full Path: \(imgePath)")
                    
                    if let image = ImageUtils().loadImageFromDiskWith(fileName: imgeFileName) {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .cornerRadius(25)
                        // for placeholders
                            .foregroundColor(Color.gray)
                    }
                }else{
                    
                    Map(coordinateRegion: $mapRegion, annotationItems: person) { person in
                        MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: person.wrappedlatitude, longitude: person.wrappedlongitude)){
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
                    .ignoresSafeArea()
                }
            }
            .transition(.identity)
            .animation(Animation.easeInOut)
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
//    var locations : [personData]
