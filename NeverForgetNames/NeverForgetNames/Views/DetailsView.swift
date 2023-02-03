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
    
    var jobTitles = ["Manger", "HR", "iOS Developer", "Android Developer", "Accountant", ".Net Developer"]
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 30, longitude: 35), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25))
    var body: some View {
        NavigationView(){
            
            ZStack {
                LiveBackgroundView()
                VStack{
                    
                    VStack {
                        Picker("", selection: $pickerTab) {
                            Text("Photo").tag(0)
                            Text("location").tag(1)
                            
                        }
                        .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    }
                    .background(.ultraThinMaterial)
                    
                    if pickerTab == 0 {
                        
                        if let image = ImageUtils().loadImageFromDiskWith(fileName: imgeFileName) {
                            VStack{
                                Image(uiImage: image)
                                    .resizable()
                                    .scaledToFit()
                                    .clipped()
                                    .cornerRadius(25)
                                // for placeholders
                                    .foregroundColor(Color.gray)
                                    .padding(5)
                                
                                VStack{
                                    Text(personName)
                                        .font(.largeTitle)
                                        .bold()
                                        .foregroundColor(.accentColor)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.horizontal)
                                    
                                    Text(jobTitles.randomElement()!)
                                        .font(.body)
                                        .foregroundColor(.accentColor)
                                        .frame(maxWidth: .infinity,alignment: .leading)
                                        .padding(.horizontal)
                                        .padding(.bottom,5)
                                    
                                }
                                .frame(maxWidth: .infinity)
                                .background(.ultraThinMaterial)
                                .cornerRadius(15)
                                .padding()
                                
                            }
                            
                        }
                        Spacer()
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
                        .ignoresSafeArea()
                        .cornerRadius(10)
                        .padding(5)
                    }
                    
                }
                .transition(.identity)
            .animation(Animation.easeInOut)
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
//    var locations : [personData]
