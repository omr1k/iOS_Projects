//
//  HomeStatusView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 02/01/2023.
//

import SwiftUI

struct HomeStatusView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @Binding var showPortfolio: Bool
    
    var body: some View {
        HStack{
            ForEach(vm.statistics){ stat in
                StatisticView(statistic: stat)
                    .frame(width: UIScreen.main.bounds.width / 3)
            }
        }.frame(width: UIScreen.main.bounds.width,
                alignment: showPortfolio ? .trailing : .leading)
    }
}

struct HomeStatusView_Previews: PreviewProvider {
    static var previews: some View {
        HomeStatusView(showPortfolio: .constant(false))
//            .previewLayout(.sizeThatFits)
    }
}
