//
//  LocationsView.swift
//  MapApp
//
//  Created by Omar Khattab on 11/02/2023.
//

import SwiftUI
import MapKit

struct LocationsView: View {
    @EnvironmentObject private var vm : LocationsViewModel
    @StateObject private var AddLocationViewModel = AddNewLocationViewModel()

    let maxWidthForIPad: CGFloat = 700
    var body: some View {
        ZStack{
            mapLayer
                .ignoresSafeArea(.all)
            VStack(spacing: 0){
                header
                    .frame(maxWidth: maxWidthForIPad)
                    .sheet(isPresented: $vm.showAddLocationSheet) {
                        AddNewLocationView(vm: AddLocationViewModel)
                    }
                Spacer()
                previewStack
                    .sheet(item: $vm.showDetailsSheet){ location in
                        LocationDetailView(location: location)
                    }
            }
            .padding()
        }
    }
}

struct LocationsView_Previews: PreviewProvider {
    static var previews: some View {
        LocationsView()
            .environmentObject(LocationsViewModel())
    }
}


extension LocationsView {
    private var header: some View {
        
        VStack {
            ZStack(alignment: .trailing) {
                Button(action: {
                    vm.loadSavedLocations()
                    vm.toggleLocationsList()
                }) {
                    Text(vm.mapLocation.name)
                        .font(.system(.title2, design: .rounded))
                        .bold()
                        .foregroundColor(.primary)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .overlay(alignment: .leading) {
                            Image(systemName:  "chevron.down")
                                .font(.title3)
                                .bold()
                                .foregroundColor(vm.showLocationsList ? .red : .primary)
                                .padding()
                                .rotationEffect(Angle(degrees: vm.showLocationsList ? 540 : 0))
                                
                        }
                }
                Button {
                    vm.showAddLocationSheet.toggle()
                    withAnimation (.spring()){
                        vm.showLocationsList = false
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                }
                .padding()
            }
            
            if vm.showLocationsList {
                Divider()
                LocationsListView()
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 15)
    }
    
    private var mapLayer: some View {
            Map(coordinateRegion: $vm.mapRegion,
                annotationItems: vm.locations,
                annotationContent: { location in
                MapAnnotation(coordinate: location.coordinates){
                    Image(systemName: "pin.circle.fill")
                        .background(Color.white)
                        .cornerRadius(55555)
                        .scaleEffect(vm.mapLocation == location ? 2.5 : 1.5)
                        .padding(.bottom, 40)
                        .foregroundColor(vm.mapLocation == location ? .red : .black)
                        .onTapGesture {
                            vm.showNextLocation(newLocation: location)
                        }
                }
            })
    }
    private var previewStack: some View {
        ZStack{
            ForEach(vm.locations) { location in
                if vm.mapLocation == location {
                    LocationPreviewView(location: location)
                        .padding(15)
                        .frame(maxWidth: maxWidthForIPad)
                        .frame(maxWidth: .infinity)
                        .transition(.asymmetric(
                            insertion: .move(edge: .trailing),
                            removal: .move(edge: .leading)))
                }
            }
        }
    }
}
