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
            Group {
                if vm.savedLocations.isEmpty {
                    whenNoLocationsView
                }
                else {
                    mapLayer
                }
            }
            .ignoresSafeArea()
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
                    Text(vm.showLocationsList ? "Saved Locations" : (vm.mapLocation.name))
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
                    Task { @MainActor in
                        withAnimation(.spring()){
                            vm.showLocationsList = false
                        }
                    }
                } label: {
                    Image(systemName: "plus")
                        .font(.title3)
                        .bold()
                        .foregroundColor(.primary)
                        .frame(width: 80, height: 55)
                }
                .offset(x: 10)
            }
            
            if vm.showLocationsList {
                Divider()
                if vm.savedLocations.count == 0 {
                    Text("No Saved Locations")
                        .foregroundColor(.primary)
                        .bold()
                        .padding(25)
                }else {
                    innerListHeader
                    LocationsListView()
                }
                
            }
        }
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .shadow(radius: 15)
    }
    
    private var mapLayer: some View {
            Map(coordinateRegion: $vm.mapRegion,
                annotationItems: vm.savedLocations,
                annotationContent: { location in
                MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: location.lat, longitude: location.long)){
                    Image(systemName: "mappin.circle.fill")
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
            ForEach(vm.savedLocations) { location in
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
    
    private var innerListHeader: some View {
        HStack{
            Text("Saved Locations")
                .foregroundColor(.primary.opacity(0.7))
                .font(.system(.footnote, design: .rounded))
            Spacer()
            Button {
                withAnimation(.linear){
                vm.showLocationsList = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5){
                        withAnimation(.easeOut){
                            vm.deleteAllSavedLocations()
                        }
                    }
                    
                }
            } label: {
                Text("Delete All")
                    .foregroundColor(.red)
                    .font(.system(.footnote, design: .rounded))
            }

        }
        .padding()
    }
    
    private var whenNoLocationsView: some View {
        
        ZStack{
            Map(coordinateRegion: .constant(MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.5, longitude: -0.12), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))), interactionModes: [])
                .blur(radius: 5)
            VStack(spacing: 15){
                Text("No Saved Locations!")
                    .font(.system(.title, design: .rounded))
                    .foregroundColor(.primary)
                Text("Please Add from + button")
                    .font(.system(.footnote, design: .rounded))
                    .foregroundColor(.primary)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .background(.thinMaterial)
            .shadow(radius: 10)
            .cornerRadius(15)
            .padding()
            .zIndex(1)
        }
        
    }
}
