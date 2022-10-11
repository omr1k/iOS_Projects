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
    
    let context = CIContext()
    
    @State private var name = ""

    @State private var imagePath = ""
    @State private var imageFileName = ""
    
    @ObservedObject var SavePersonData : SavePersonData
    
    @State private var showAlert = false
    
  @Environment(\.dismiss) var dismiss
  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section("Photo") {
            VStack {
              image?
                .resizable()
                .scaledToFit()
              Button("Pick Image") {
                showingImagePicker = true
              }
            }

          }
          Section {
              if inputImage != nil {
              TextField("Enter name", text: $name)
                .padding()
            }
          }
        }
      }
      .navigationTitle("Add New Persion")
      .toolbar {
        ToolbarItem(placement: .navigationBarTrailing) {
          Button("Save") {
              if name != "" {
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
    .sheet(isPresented: $showingImagePicker) {
      ImagePicker(image: $inputImage)
    }
    .onChange(of: inputImage) { _ in loadImage() }
    .alert(isPresented: $showAlert){
                Alert(title: Text("Ops!"),message:Text("Please input name to this picture"),dismissButton: .default(Text("OK")))
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
        guard let DocImage = DocImage else { return }
        let imageUtils = ImageUtils()
        imageUtils.writeToDocuments(image: DocImage)
        imagePath = imageUtils.imagePathToShow()
        imageFileName = imageUtils.imageFileNameString
        let persons = personData(name: name, imageFilename: imageFileName, imageAbslutePath: imagePath)
        SavePersonData.persons.append(persons)
    }
    
    func addjj(){
        let jsonString = "{\"location\": \"the mXXXXoon\"}"

        if let documentDirectory = FileManager.default.urls(for: .documentDirectory,
                                                            in: .userDomainMask).first {
            let pathWithFilename = documentDirectory.appendingPathComponent("myJsonStringOmar.json")
            do {
                try jsonString.write(to: pathWithFilename,atomically: true,encoding: .utf8)
            } catch {
                // Handle error
            }
        }
    }
    
    

}

//struct AddView_Previews: PreviewProvider {
//  static var previews: some View {
//    AddView()
//  }
