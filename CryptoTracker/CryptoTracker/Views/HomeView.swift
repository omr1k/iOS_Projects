//
//  HomeView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 29/12/2022.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var vm: HomeViewModel
    @State private var showPortfolio: Bool = false
    
    @State private var tabSelected: Tab = .house
        
        init() {
            UITabBar.appearance().isHidden = true
        }
    
    var body: some View {
        ZStack (alignment: .bottom) {
            Color.theme.background
                .ignoresSafeArea()
            VStack{
                homeHeader
                HomeStatusView(showPortfolio: $showPortfolio)
                SearchBarView(searchText: $vm.searchText)
                
                listTitles
                if !showPortfolio {
                    if vm.allCoins.isEmpty {
                        if !vm.searchText.isEmpty{
                            
                        } else {
                            ProgressView()
                        }
                    } else {
                        allCoinsList
                            .transition(.move(edge: .leading))
                    }
                }
                
                if showPortfolio {
                    if vm.portfolioCoins.isEmpty {
                        if !vm.searchText.isEmpty{
                            
                        } else {
                            ProgressView()
                        }
                    } else {
                        portfolioCoinsList
                            .transition(.move(edge: .trailing))
                    }
                }
                Spacer(minLength: 0)
//                CustomTabBar(selectedTab: $tabSelected)
            }
            
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView{
            HomeView()
                .navigationBarHidden(true)
        }
        .environmentObject(HomeViewModel())
    }
        

}



extension HomeView {
    private var homeHeader: some View {
        HStack{
            CircleButtonView(iconName: showPortfolio ? "plus" : "gear")
                .background(
                    CircleButtonAnimationView(animate: $showPortfolio)
                )
            Spacer()
            Text(showPortfolio ? "Portfolio" : "Live Prices")
                .font(.title2)
                .bold()
                .foregroundColor(Color.theme.accent)
            Spacer()
            CircleButtonView(iconName: "chevron.right")
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    
    
    
    private var allCoinsList: some View {
        List{
            ForEach(vm.allCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: false)
                    .listRowInsets(.init(top: 10, leading:   0, bottom: 10, trailing: 10))
            }
        }
        .refreshable {
            vm.updateCoinData()
        }
        .listStyle(.plain)
    }
    
    
    
    private var portfolioCoinsList: some View {
        List{
            ForEach(vm.portfolioCoins){ coin in
                CoinRowView(coin: coin, showHoldingColumn: true)
                    .listRowInsets(.init(top: 10, leading:   0, bottom: 10, trailing: 10))
                
            }
        }
        .refreshable {
            vm.updateCoinData()
        }
        .listStyle(.plain)
    }
    
    
    private var listTitles: some View {
        HStack{
            Text("Coin")
            Spacer()
            if showPortfolio {
                Text("Holdings")
            }
            Text("Price")
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
            
        }
        .font(.caption)
        .foregroundColor(Color.theme.SecondaryTextColor)
        .padding(.horizontal)
    }
    
}
