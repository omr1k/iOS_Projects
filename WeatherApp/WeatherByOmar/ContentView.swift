//
//  ContentView.swift
//  WeatherByOmar
//
//  Created by Omar Khattab on 22/11/2022.
//


import SwiftUI
import MapKit

struct ContentView: View {
    
    @StateObject var viewModel = ContentViewViewModel()
    
    var body: some View {
        
        ZStack{
            RadialGradient(
                stops: [
                    .init(color:.orange,location: 0.3),
                    .init(color: .blue, location: 0.3)],
                center: .top,
                startRadius: 200,
                endRadius: 700)
            .ignoresSafeArea()
            
            VStack{
                if viewModel.isLoading {
                    VStack{
                        Spacer()
                        ProgressView()
                            .padding()
                        Text("Loading")
                        Spacer()
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding()
                    
                } else {
                    VStack{
                        Text("Last Update: \(Date().formatted(.dateTime.day().month().year().hour().minute()))")
                            .fontWeight(.light)
                            .font(.footnote)
                            .foregroundColor(.white)
                        
                        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
                            MapAnnotation(coordinate: location.coordinate) {
                                
                                VStack {
                                    Image(systemName: "mappin.circle.fill")
                                        .resizable()
                                        .foregroundColor(.red)
                                        .frame(width: 44, height: 44)
                                        .background(.white)
                                        .clipShape(Circle())
                                }
                                Text("\(location.name)")
                                
                            }
                        }
                        .frame(width: .infinity, height: 150)
                        .cornerRadius(25)
                        
                        Text(viewModel.weatherData.name ?? "Loading")
                            .bold().font(.title)
                            .padding()
                        
                        Text("\(Int(viewModel.weatherData.main?.temp ?? 0.0)) °C")
                            .bold()
                            .font(.title)
                            .fontWeight(.bold)
                        
                        AsyncImage(url: URL(string: viewModel.weatherIconUrl()), scale: 5) { image in
                            image
                                .resizable()
                                .scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame( width: 150,height: 150)
                        
                        Text(viewModel.weatherData.weather?[0].main ?? "Loading")
                            .font(.title3)
                            .foregroundColor(.white)
                        
                        HStack{
                            Spacer()
                            VStack{
                                Image(systemName: "humidity")
                                Text("Humidity")
                                Text("\(viewModel.weatherData.main?.humidity ?? 0) %")
                            }.padding()

                            Spacer()

                            VStack{
                                Image(systemName: "aqi.high")
                                Text("Pressure")
                                Text("\(viewModel.weatherData.main?.pressure ?? 0)")

                            }.padding()
                            Spacer()
                        }

                        .background(.ultraThinMaterial)
                        //                    .clipShape(Capsule())
                        .frame(maxWidth: .infinity)
                        .cornerRadius(25)
                        .padding()
                        
                        
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 50))
                    .padding()
                    
                    
                }
            }
        }
        .preferredColorScheme(.dark)
        .onAppear{
            viewModel.startDetectingLocation()
        }
    }
}













//import SwiftUI
//import MapKit
//
//struct ContentView: View {
//
//    @StateObject var viewModel = ContentViewViewModel()
//
//    var body: some View {
//
//        ZStack{
//            RadialGradient(
//                stops: [
//                    .init(color:.indigo,location: 0.3),
//                    .init(color: .red, location: 0.3)],
//                center: .top,
//                startRadius: 200,
//                endRadius: 700)
//            .ignoresSafeArea()
//            VStack{
//                if viewModel.isLoading {
//                    VStack{
//                        Spacer()
//                        ProgressView()
//                        Text("Loading")
//                        Spacer()
//                    }
//
//                } else {
//                    VStack{
//                        Text("Last Update: \(Date().formatted(.dateTime.day().month().year().hour().minute()))")
//                            .fontWeight(.light)
//                            .foregroundColor(.white)
//                        //                        .padding()
//
//                        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
//                            MapAnnotation(coordinate: location.coordinate) {
//
//                                VStack {
//                                    Image(systemName: "mappin.circle.fill")
//                                        .resizable()
//                                        .foregroundColor(.red)
//                                        .frame(width: 44, height: 44)
//                                        .background(.white)
//                                        .clipShape(Circle())
//                                }
//                                Text("\(location.name)")
//
//                            }
//                        }
//                        .frame(width: .infinity, height: 200)
//
//                        VStack{
//
//                            Text(viewModel.weatherData.name ?? "Loading")
//                                .bold().font(.title)
//                                .foregroundColor(.white)
//
//                            Text("\(Int(viewModel.weatherData.main?.temp ?? 0.0)) °C")
//                                .bold()
//                                .font(.title)
//                                .fontWeight(.bold)
//
//                            AsyncImage(url: URL(string: viewModel.weatherIconUrl()), scale: 5) { image in
//                                image
//                                    .resizable()
//                                    .scaledToFit()
//                            } placeholder: {
//                                ProgressView()
//                            }
//                            .frame( width: 150,height: 150)
//
//                            Text(viewModel.weatherData.weather?[0].main ?? "Loading")
//                                .font(.title3)
//                                .foregroundColor(.white)
//                        }
//
//                        HStack{
//                            Spacer()
//                            VStack{
//                                Image(systemName: "humidity")
//                                Text("Humidity")
//                                Text("\(viewModel.weatherData.main?.humidity ?? 0) %")
//                            }.padding()
//
//                            Spacer()
//
//                            VStack{
//                                Image(systemName: "aqi.high")
//                                Text("Pressure")
//                                Text("\(viewModel.weatherData.main?.pressure ?? 0)")
//
//                            }.padding()
//                            Spacer()
//                        }
//
//                        .background(.secondary)
//                        //                    .clipShape(Capsule())
//                        .frame(maxWidth: .infinity)
//                        .cornerRadius(25)
//                        .padding()
//
//
//
//                    }
//                }
//            }
//            .frame(maxWidth: .infinity)
//            .preferredColorScheme(.dark)
//            .onAppear{
//                viewModel.startDetectingLocation()
//            }
//        }
//    }
//}





















//import SwiftUI
//import MapKit
//
//struct ContentView: View {
//
//    @StateObject var viewModel = ContentViewViewModel()
//
//    static let color0 = Color(red: 255/255, green: 78/255, blue: 0/255);
//    static let color1 = Color(red: 84/255, green: 122/255, blue: 220/255);
//    let gradient = Gradient(colors: [color0, color1]);
//
//    var body: some View {
//
//        ZStack (alignment: .leading){
//            Rectangle()
//                    .fill(LinearGradient(
//                      gradient: gradient,
//                      startPoint: .init(x: 0.00, y: 0.51),
//                      endPoint: .init(x: 1.00, y: 0.49)
//                    ))
//                  .edgesIgnoringSafeArea(.all)
//
//            if viewModel.isLoading {
//                VStack{
//                    ProgressView()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    Text("Loading...")
//                        .bold().font(.title)
//                }
//            }else{
//                VStack{
//                    Text(viewModel.weatherData.name ?? "Loading...")
//                        .bold().font(.title)
//                    Text("Last Update: \(Date().formatted(.dateTime.day().month().year().hour().minute()))")
//                        .fontWeight(.light)
//
//                    AsyncImage(url: URL(string: viewModel.weatherIconUrl()), scale: 3) { image in
//                        image
//                            .resizable()
//                            .scaledToFit()
//                    } placeholder: {
//                        ProgressView()
//                    }
//                    .frame(height: 100)
//                    Text(viewModel.weatherData.weather?[0].main ?? "Loading...")
//                    Text("\(Int(viewModel.weatherData.main?.temp ?? 0.0)) °C")
//                        .font(.system(size: 80))
//                        .fontWeight(.bold)
//                        .padding()
//                    HStack{
//                        Spacer()
//                        Text("H: \(Int(viewModel.weatherData.main?.tempMax ?? 0.0)) °C")
//                        Spacer()
//                        Text("L: \(Int(viewModel.weatherData.main?.tempMin ?? 0.0)) °C")
//                        Spacer()
//                    }
//
//                    VStack{
//
//                        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
//                            MapAnnotation(coordinate: location.coordinate) {
//
//                                VStack {
//                                    Image(systemName: "mappin.circle.fill")
//                                        .resizable()
//                                        .foregroundColor(.red)
//                                        .frame(width: 44, height: 44)
//                                        .background(.white)
//                                        .clipShape(Circle())
//                                }
//                                Text("\(location.name)")
//
//                            }
//                        }
//                        .frame(width: .infinity,height: 100)
//                        .cornerRadius(15)
//                        .padding(.vertical)

//                        Spacer()
//                    }
//                    .frame(maxWidth: .infinity)
//
//                    VStack{
//                        HStack{
//                            VStack{
//                                Image(systemName: "sparkles")
//                                Text("Feels Like")
//                                Text("\(Int(viewModel.weatherData.main?.feelsLike ?? 0.0)) °C")
//
//
//                            }
//                            .padding()
//                            .background(.secondary)
//                            .cornerRadius(8)
//                            .frame(maxWidth: 200,maxHeight: 200)
//
//                            VStack{
//                                Image(systemName: "sparkles")
//                                Text("Visibility")
//                                Text("\(Int(viewModel.weatherData.main?.feelsLike ?? 0.0)) °C")
//                            }
//                            .padding()
//                            .background(.secondary)
//                            .cornerRadius(8)
//                            .frame(maxWidth: 200,maxHeight: 200)
//                        }
//                        HStack{
//                            VStack{
//                                Image(systemName: "sparkles")
//                                Text("Humidity")
//                                Text("\(Int(viewModel.weatherData.main?.feelsLike ?? 0.0)) °C")
//                            }
//                            .padding()
//                            .background(.secondary)
//                            .cornerRadius(8)
//                            .frame(maxWidth: 200,maxHeight: 200)
//
//
//                            VStack{
//                                Image(systemName: "sparkles")
//                                Text("Wind Speed")
//                                Text("\(Int(viewModel.weatherData.main?.feelsLike ?? 0.0)) °C")
//                            }
//                            .padding()
//                            .background(.secondary)
//                            .cornerRadius(8)
//                            .frame(maxWidth: 200,maxHeight: 200)
//                        }
//                    }
//
//
//
//
////                    VStack {
////                        Spacer()
////                        VStack(alignment: .leading, spacing: 20) {
////                            Text("Weather now")
////                                .bold()
////                                .padding(.bottom)
////
////                            HStack {
////                                WeatherRow(logo: "thermometer", name: "Min temp", value: ((viewModel.weatherData.main?.tempMin ??  0.0) + ("°")))
////                                Spacer()
////                                WeatherRow(logo: "thermometer", name: "Max temp", value: (viewModel.weatherData.main?.tempMax.roundDouble() + "°"))
////                            }
////
////                            HStack {
////                                WeatherRow(logo: "wind", name: "Wind speed", value: (viewModel.weatherData.wind?.speed.roundDouble() + " m/s"))
////                                Spacer()
//////                                WeatherRow(logo: "humidity", name: "Humidity", value: "\(viewModel.weatherData.ma.roundDouble())%")
////                            }
////                        }
////                        .frame(maxWidth: .infinity, alignment: .leading)
////                        .padding()
////                        .padding(.bottom, 20)
////                        .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
////                        .background(.white)
////                        .cornerRadius(20, corners: [.topLeft, .topRight])
////
////                }
////                .padding()
////                .frame(maxWidth: .infinity, alignment: .leading)
//            }
//        }
////        .background(.red)
//        .preferredColorScheme(.dark)
//        .onAppear{
//            viewModel.startDetectingLocation()
//        }
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}















//import SwiftUI
//import MapKit
//
//struct ContentView: View {
//
//    @StateObject var viewModel = ContentViewViewModel()
//
//    static let color0 = Color(red: 255/255, green: 78/255, blue: 0/255);
//    static let color1 = Color(red: 84/255, green: 122/255, blue: 220/255);
//    let gradient = Gradient(colors: [color0, color1]);
//
//    var body: some View {
//
//        ZStack (alignment: .leading){
//            Rectangle()
//                    .fill(LinearGradient(
//                      gradient: gradient,
//                      startPoint: .init(x: 0.00, y: 0.51),
//                      endPoint: .init(x: 1.00, y: 0.49)
//                    ))
//                  .edgesIgnoringSafeArea(.all)
//
//            if viewModel.isLoading {
//                VStack{
//                    ProgressView()
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    Text("Loading...")
//                        .bold().font(.title)
//                }
//            }else{
//                VStack{
//                    Text(viewModel.weatherData.name ?? "Loading...")
//                        .bold().font(.title)
//                    Text("Last Update: \(Date().formatted(.dateTime.day().month().year().hour().minute()))")
//                        .fontWeight(.light)
//
//                        VStack(alignment: .leading, spacing: 5){
//                            HStack{
//                                Text(viewModel.weatherData.name ?? "Loading...")
//                                    .bold().font(.title)
//                                Spacer()
//                                Text(viewModel.weatherData.weather?[0].main ?? "Loading...")
//
//                            }
//
//
//                        Text("Today: \(Date().formatted(.dateTime.day().month().year().hour().minute()))")
//                            .fontWeight(.light)
//                    }.frame(maxWidth: .infinity, alignment: .leading)
////                    Spacer()
//                    VStack{
//
//                        Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
//                            MapAnnotation(coordinate: location.coordinate) {
//
//                                VStack {
//                                    Image(systemName: "mappin.circle.fill")
//                                        .resizable()
//                                        .foregroundColor(.red)
//                                        .frame(width: 44, height: 44)
//                                        .background(.white)
//                                        .clipShape(Circle())
//                                }
//                                Text("\(location.name)")
//
//                            }
//                        }
//                        .frame(width: .infinity,height: 200)
//                        .cornerRadius(15)
//                        .padding(.vertical)
//
//
//                        VStack{
//
//                            Text("\(Int(viewModel.weatherData.main?.temp ?? 0.0)) °")
//                                .font(.system(size: 80))
//                                .fontWeight(.bold)
//                                .padding()
//
//
//                            HStack{
//                                AsyncImage(url: URL(string: viewModel.weatherIconUrl()), scale: 3) { image in
//                                    image
//                                        .resizable()
//                                        .scaledToFit()
//                                } placeholder: {
//                                    ProgressView()
//                                }
//                                .frame(height: 100)
//
//                                Text(viewModel.weatherData.weather?[0].main ?? "Loading...")
//                            }
//                            .frame(width: 150, alignment: .leading)
//
//                        }
//
//                        Spacer()
////                            .frame(height: 80)
//
//
//                    }
//                    .frame(maxWidth: .infinity)
//                }
//
//                .padding()
//                .frame(maxWidth: .infinity, alignment: .leading)
//            }
//        }
////        .background(.red)
//        .preferredColorScheme(.dark)
//
//        .onAppear{
//            viewModel.startDetectingLocation()
//        }
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//




//
////  ContentView.swift
////  WeatherByOmar
////
////  Created by Omar Khattab on 22/11/2022.
////
//
//import SwiftUI
//import MapKit
//struct ContentView: View {
//
//    @StateObject var viewModel = ContentViewViewModel()
//
//    static let color0 = Color(red: 227/255, green: 76/255, blue: 227/255);
//    static let color1 = Color(red: 0/255, green: 209/255, blue: 255/255);
//    let gradient = Gradient(colors: [color0, color1]);
//
//
//
//    var body: some View {
//        ZStack{
//            //            Rectangle()
//            //                .fill(LinearGradient(
//            //                    gradient: gradient,
//            //                    startPoint: .init(x: 0.00, y: 0.50),
//            //                    endPoint: .init(x: 1.00, y: 0.50)
//            //                ))
//            //                .edgesIgnoringSafeArea(.all)
//
//            if viewModel.isLoading == false {
//            VStack{
//                HStack{
//                    Spacer()
//                    Text("\(viewModel.weatherData.name ?? "City")")
//                        .font(.title)
//                    Spacer()
//                }.padding()
//
//                HStack{
//                    Spacer()
//                    Text("\(viewModel.weatherData.main?.temp ?? 12)")
//                        .font(.title)
//                    Spacer()
//                }.padding()
//
//                Text(viewModel.formattedCurrentDate)
//                Map(coordinateRegion: $viewModel.mapRegion, annotationItems: viewModel.locations) { location in
//                    MapAnnotation(coordinate: location.coordinate) {
//
//                        VStack {
//                            Image(systemName: "mappin.circle.fill")
//                                .resizable()
//                                .foregroundColor(.red)
//                                .frame(width: 44, height: 44)
//                                .background(.white)
//                                .clipShape(Circle())
//                        }
//                        Text("\(location.name)")
//
//                    }
//                }.frame(width: 200,height: 200)
//
//
//
//                Text("\(viewModel.lastKnownLocation?.latitude ?? 0.0)")
//                Text("\(viewModel.lastKnownLocation?.longitude ?? 0.0)")
//                Text(viewModel.weatherData.name ?? "City")
//                Button("get Laoction"){
//                    viewModel.startDetectingLocation()
//                }
//                Button("stop"){
//                    viewModel.stopDetectingLocation()
//                }
//                Button("get weather data"){
//                    Task {
//                        await viewModel.getData()
//                    }
//                }
//            }
//        }else {
//            VStack{
//                ProgressView()
//                    .font(.title)
//            }
//        }
//
//        }.alert(isPresented: $viewModel.showError) {
//            Alert(
//                title: Text("Error get data weather"),
//                message: Text("no data found"),
//                primaryButton: .destructive(Text("Retery")) {
//                    Task{
//                        await viewModel.getData
//                    }
//                },
//                secondaryButton: .cancel()
//            )
//        }
//
//
//
//        .padding()
//        .onAppear{
//            viewModel.startDetectingLocation()
//        }
//
//
//    }
//}
//
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//
