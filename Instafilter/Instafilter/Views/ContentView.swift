//
//  ContentView.swift
//  Instafilter
//
//  Created by Omar Khattab on 13/09/2022.
//
import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    
    @State private var image : Image?
    @State private var filterIntensity = 0.5
    
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var processedImage: UIImage?
    @State private var showingFilterSheet = false
  
    @State private var currentFilter: CIFilter = CIFilter.sepiaTone()
    let context = CIContext()
    
    @State private var showDoneEmoji = false
    static let color0 = Color(red: 0/255, green: 188/255, blue: 212/255);
    static let color1 = Color(red: 130/255, green: 238/255, blue: 134/255);
    let gradient = Gradient(colors: [color0, color1]);
    
    @Environment(\.colorScheme) var colorScheme
    

    var textColor: Color {
        if colorScheme == .dark {
            return Color.white
        } else {
            return Color.black
        }
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Rectangle()
                    .fill(LinearGradient(
                        gradient: gradient,
                        startPoint: .init(x: 0.00, y: 0.50),
                        endPoint: .init(x: 1.00, y: 0.50)
                    ))
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    ZStack{
                        Rectangle()
                            .fill(.ultraThinMaterial)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                            .padding(.horizontal)
                        VStack{
                            Text("Tap to Uploade an Image")
                                .foregroundColor(.secondary)
                            
                            image?
                                .resizable()
                                .scaledToFit()
                                .padding()
                                
                        }.padding()
                    }.onTapGesture {
                        showingImagePicker = true
                        showDoneEmoji = false
                    }
                    
                    HStack {
                        Text("Intensity")
                        Slider(value: $filterIntensity)
                            .onChange(of: filterIntensity){_ in applyProcessing()}
                            .onChange(of: filterIntensity){_ in showDoneEmoji = false}
                    }.padding(.horizontal)
                    
                    HStack {
                        Button("Change Filter") {
                            showingFilterSheet = true
                            showDoneEmoji = false
                        }.foregroundColor(textColor)
                        
                        Spacer()
                
                        Button("Save"){
                            save()
                        }
                        .foregroundColor((image != nil) ? textColor : Color.secondary)
                        .disabled(image == nil)
                        Text(showDoneEmoji ? "✅" : "")
                            .animation(.easeInOut, value: showDoneEmoji)
                    }.padding(.horizontal)
                    
                }
            }
            .navigationTitle("Filters")
            .onChange(of: inputImage){_ in loadImage()}
            .sheet(isPresented: $showingImagePicker){
                ImagePicker(image: $inputImage)
            }
            .confirmationDialog("select a filter", isPresented: $showingFilterSheet){
                Button("Crystallize") { setFilter(CIFilter.crystallize()) }
                Button("Edges") { setFilter(CIFilter.edges()) }
                Button("Gaussian Blur") { setFilter(CIFilter.gaussianBlur()) }
                Button("Pixellate") { setFilter(CIFilter.pixellate()) }
                Button("Sepia Tone") { setFilter(CIFilter.sepiaTone()) }
                Button("Unsharp Mask") { setFilter(CIFilter.unsharpMask()) }
                Button("Vignette") { setFilter(CIFilter.vignette()) }
                Button("Cancel", role: .cancel) { }
            }
            
        }
    }
    func loadImage(){
        guard let inputImage = inputImage else { return }
        
        let beginImage = CIImage(image: inputImage)
        currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
        applyProcessing()
    }
    
    func save(){
        guard let processedImage = processedImage else { return }
        
        let imageSaver = ImageSaver()
        
        imageSaver.successHandler = {
            print("Success!")
            showDoneEmoji = true
        }
        imageSaver.errorHandler = {print("Oops!\($0.localizedDescription)")}
        
        imageSaver.writeToPhotoAlbum(image: processedImage)
    }
    
    func applyProcessing() {
        let inputKeys = currentFilter.inputKeys
        
        if inputKeys.contains(kCIInputIntensityKey){
            currentFilter.setValue(filterIntensity, forKey: kCIInputIntensityKey)
        }
        if inputKeys.contains(kCIInputRadiusKey){
            currentFilter.setValue(filterIntensity * 200, forKey: kCIInputRadiusKey)
        }
        if inputKeys.contains(kCIInputScaleKey){
            currentFilter.setValue(filterIntensity * 10, forKey: kCIInputScaleKey)
        }
        
        

        guard let outputImage = currentFilter.outputImage else { return }
        
        if let cgimg = context.createCGImage(outputImage, from: outputImage.extent){
            let uiImage = UIImage(cgImage: cgimg)
            image = Image(uiImage: uiImage)
            processedImage = uiImage
        }
    }
    
    func setFilter (_ filter : CIFilter){
        currentFilter = filter
        loadImage()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
