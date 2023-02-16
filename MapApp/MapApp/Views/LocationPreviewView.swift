//
//  LocationPreviewView.swift
//  MapApp
//
//  Created by Omar Khattab on 14/02/2023.
//

import SwiftUI

struct LocationPreviewView: View {
    
    @EnvironmentObject var vm : LocationsViewModel
    let location: Location
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            
            VStack(alignment: .leading, spacing: 16.0){
                image
                title
            }
//            Spacer()
            VStack(spacing: 8.0){
                learnMoreButton
                nextButton
            }
        }
        .padding(15)
        .background(
        RoundedRectangle(cornerRadius: 15)
            .fill(.ultraThinMaterial)
            .offset(y: 50)
        )
        .cornerRadius(15)
        
        
    }
}

struct LocationPreviewView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
            LocationPreviewView(location: LocationsDataService.locations.first!)
        }
        .previewLayout(PreviewLayout.sizeThatFits)
        .environmentObject(LocationsViewModel())
    }
    
    
    
}


extension LocationPreviewView {
    private var image: some View {
        ZStack{
            if let image = location.imageNames.first{
                Image(image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
            }
        }
        .padding(6)
        .background(Color.white)
        .cornerRadius(10)
    }
    private var title: some View {
        VStack(alignment: .leading, spacing: 2.0){
            Text(location.name)
                .font(.title2)
                .bold()
            Text(location.cityName)
        }
        .frame(maxWidth: .infinity,alignment: .leading)
        
    }
    
    private var learnMoreButton: some View{
        Button {
            vm.showDetailsSheet = location
        } label: {
            Text("Learn More")
                .padding(.horizontal, 5)
                .frame(width: 125, height: 35)
        }
        .buttonStyle(.borderedProminent)
    }
    
    private var nextButton: some View {
        Button {
            vm.nextButtonPressed()
        } label: {
            Text("Next")
                .frame(width: 125, height: 35)
                .padding(.horizontal, 5)
        }
        .buttonStyle(.bordered)
    }
}
