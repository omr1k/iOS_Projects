//
//  ContentView.swift
//  Instafilter
//
//  Created by Omar Khattab on 13/09/2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var image : Image?
    @State private var inputImage : UIImage?
    @State private var showImagePicker = false
    
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
            
            Button("show picker"){
                showImagePicker = true
            }
            
            Button("Save image"){
                guard let inputImage = inputImage else {return}
                let imageSaver = ImageSaver()
                imageSaver.writeToPhotoAlbum(image: inputImage)
            }
        }
        .sheet(isPresented: $showImagePicker){
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage){_ in loadImage()}
    }
    
    func loadImage (){
        guard let inputImage = inputImage else {return}
        image = Image(uiImage: inputImage)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
