//
//  AddView.swift
//  NeverForgetNames
//
//  Created by Omar Khattab on 07/10/2022.
//

import SwiftUI

struct AddView: View {
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?
    @State private var DocImage: UIImage?
    @State private var name = ""
    @State private var imagePath = ""
    @State private var imageFileName = ""
    @State private var latitude = 2001.5
    @State private var longitud = 2002.5
    @State private var showAlert = false
    @FetchRequest(sortDescriptors: []) var fetchPerson: FetchedResults<Person>
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
    let context = CIContext()
    let locationFetcher = LocationFetcher()
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
    
    var body: some View {
        NavigationView {
            ZStack {
                LiveBackgroundView()
                
                VStack{
                    
                    if image != nil {
                        VStack{
                            image?
                                .resizable()
                                .scaledToFit()
                                .cornerRadius(10)
                                .frame(maxWidth: .infinity, maxHeight: 500)
                                
                                .padding()
                            
                            if inputImage != nil {
                                TextField("Enter name", text: $name)
                                    .padding()
                                    .background(.thinMaterial)
                                    .cornerRadius(15)
                                    .padding()
                            }
                        }
                        .background(.ultraThinMaterial.opacity(0.7))
                        .cornerRadius(15)
                        .padding(15)
                        
                            
                    }
                    Spacer()
                    Button{
                        showingImagePicker = true
                    }label: {
                        Label("Select Photo", systemImage:"photo")
                            .foregroundColor(.accentColor)
                            .font(.system(.largeTitle, design: .rounded))
                            .padding()
                            .background(.ultraThinMaterial)
                            .cornerRadius(15)
                    }
                    .padding()
                    
                    
                }
                .navigationTitle("Add New Person")
                
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Save") {
                            if name != "" && image != nil {
                                save()
                                dismiss()
                            }else{
                                showAlert.toggle()
                            }
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onAppear() {
            self.locationFetcher.start()
        }
        .onChange(of: inputImage) { _ in loadImage() }
        .alert(isPresented: $showAlert){
            Alert(title: Text("Ops!"),message:Text("Please input all info"),dismissButton: .default(Text("OK")))
        }
    }
    
    func getUserLocation(){
        if let location = locationFetcher.lastKnownLocation {
            print("Your location is \(location)")
            longitud = location.longitude
            latitude = location.latitude
            print("LA: \(latitude) ==== LO: \(longitud)")
            
        } else {
            print("Your location is unknown")
        }
    }
    
    func loadImage() {
        // swiftUI image
        guard let inputImage = inputImage else { return }
        // convert swiftUi image to CI Image
        guard let TheCIImage = CIImage(image: inputImage) else { return }
        
        // convert CIImage to CGImage
        if let cgimg = context.createCGImage(TheCIImage, from: TheCIImage.extent) {
            // convert back the CGImage to swiftUi Image
            let uiImage = UIImage(cgImage: cgimg)
            // assinge it
            image = Image(uiImage: uiImage)
            DocImage = uiImage
        }
    }
    
    private func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths[0])
        return paths[0]
    }
    
    func save() {
        getUserLocation()
        guard let DocImage = DocImage else { return }
        let imageUtils = ImageUtils()
        imageUtils.writeToDocuments(image: DocImage)  // save image to documents
        imagePath = imageUtils.imagePathToShow()   // get image path
        imageFileName = imageUtils.imageFileNameString // get image file name (text)
       
        // save all needed info to CoreData
        let newPerson = Person(context: moc)
        newPerson.id = UUID()
        newPerson.imageAbslutePath = imagePath
        newPerson.imageFilename = imageFileName
        newPerson.name = name
        newPerson.latitude = latitude
        newPerson.longitude = longitud
        try? moc.save()
    }
}
    
    
    
    
    
//@ObservedObject var SavePersonData : SavePersonData
struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
    }
}



//    func getUserLocation(){
//
//
//        if let location = self.locationFetcher.lastKnownLocation {
//            print("Your location is \(location)")
//            latitude = location.latitude
//            longitud = location.longitude
//            print("LA: \(latitude) ==== LO: \(longitud)")
//        } else {
//            print("Your location is unknown")
//            print("LA: \(latitude) ==== LO: \(longitud)")
//        }
//    }


//
//do {
//
//    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPlaces")
//    let data = try JSONEncoder().encode(persons)
//    try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//} catch {
//    print("Unable to save data.")
//}



    
//        let jsonString = "{\"location\": \"the mXXXXoon\"}"
//
//        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
//                                                            in: .userDomainMask).first {
//            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonStringOmar.json")
//            do {
//                try jsonString.write(to: pathWithFilename,atomically: true,encoding: .utf8)
//            } catch {
//                // Handle error
//            }
//        }



//
//func saveDataAsJson(personData : personData){
//    
//    
//    do {
//        let data = try JSONEncoder().encode(personData)
//        try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//    } catch {
//        print("Unable to save data.")
//    }
//}
