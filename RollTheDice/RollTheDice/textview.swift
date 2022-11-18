//
//  textview.swift
//  RollTheDice
//
//  Created by Omar Khattab on 18/11/2022.
//

import SwiftUI

struct textview: View {
    init() {
            UITableView.appearance().backgroundColor = .clear // For tableView
            UITableViewCell.appearance().backgroundColor = .clear // For tableViewCell
        }
    var body: some View {

        VStack{
            Button("fds"){}
        }
    }
}

struct textview_Previews: PreviewProvider {
    static var previews: some View {
        textview()
    }
}

//ZStack{
////            Image("d")
////                .resizable()
////                .scaledToFill()
////                .edgesIgnoringSafeArea(.all)
//
//      List{
//          Text("sdgdfg").listRowBackground(Color.clear)
////                Text("sdgdfg").listRowBackground(Color.red)
////                Text("sdgdfg").listRowBackground(Color.yellow)
////                Text("sdgdfg").listRowBackground(Color.green)
//      }.background(Image("d"))
////            .listRowBackground(Color.clear)
////            .onAppear(){
////                UITableView.appearance().backgroundColor = UIColor.clear
////                UITableViewCell.appearance().backgroundColor = UIColor.clear
////            }
//
//
////        }
