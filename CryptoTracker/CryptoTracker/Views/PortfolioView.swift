//
//  AddPortfolioCoins .swift
//  CryptoTracker
//
//  Created by Omar Khattab on 03/01/2023.
//

import SwiftUI

struct PortfolioView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: HomeViewModel
    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText = ""
    @State private var showCheckMark: Bool = false
    
    private let portfolioDBService = PortfolioDataService()
        
    var body: some View {
        NavigationView{
            ScrollView{
                VStack(alignment: .leading, spacing: 0){
                    SearchBarView(searchText: $vm.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
            .navigationTitle("Edit Portfolio")
            .toolbar(content: {
                ToolbarItem(placement: .navigationBarLeading,  content: {
                    Button(action: {
                        dismiss()
                    }, label: {
                        XMarkButtonView()
                    })
                })
                ToolbarItem(placement: .navigationBarTrailing, content: {
                    HStack{
                        Image(systemName: "checkmark")
                            .opacity(showCheckMark ? 1.0 : 0.0)
                        Button(action: {
                            saveButtonPressed()
                        }, label: {
                            Text("Save".uppercased())
                        })
                        .opacity(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText) ? 1.0 : 0.0)
                    }
                    .font(.headline)
                })
            })
            .onChange(of: vm.searchText) { value in
                if value == "" {
                    removeSelectedCoin()
                }
            }
        }
    }
}

struct AddPortfolioCoins__Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(HomeViewModel())
    }
}

extension PortfolioView {
    private func saveButtonPressed(){
        guard
            let coin = selectedCoin,
            let amount = Double(quantityText)
            else { return }
        // MARK: Save to portfolio
//        portfolioDBService.updatePortfolio(coin: coin, amount: Double(quantityText) ?? 0.0)
        vm.updatePortfolio(coin: coin, amount: amount)

        // MARK: Show checkmark
        withAnimation(.easeIn){
            showCheckMark = true
            removeSelectedCoin()
        }
        // MARK: Hide keyboard
        UIApplication.shared.endEditing()
        // MARK: Hide checkmark
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0){
            withAnimation(.easeOut){
                showCheckMark = false
            }
        }
        
    }
    //MARK: - End Function

    
    private func removeSelectedCoin(){
        selectedCoin = nil
        vm.searchText = ""
        quantityText = ""
    }
    
    private func getCurrentValue() -> Double {
        if let quantity = Double(quantityText){
            return quantity * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    var coinLogoList: some View{
        ScrollView(.horizontal, showsIndicators: false, content: {
            LazyHStack(spacing: 10){
                ForEach(vm.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn){
                                selectedCoin = coin
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin? .id == coin.id ? Color.theme.GreenColor : Color.clear, lineWidth: 1)
                        )
                }
            }
            .padding(.vertical, 4)
            .padding(.leading)
        })
    }
    
    var portfolioInputSection: some View {
        VStack(spacing: 20){
            HStack{
                Text("Current Price of \(selectedCoin?.symbol.uppercased() ?? "" ):")
                Spacer()
                Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
            }
            Divider()
            HStack{
                Text("Amount Holding:")
                Spacer()
                TextField("Ex: 1.5", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack{
                Text("Current Value")
                Spacer()
                Text("\(getCurrentValue())")
            }
        }
        .padding()
        .font(.headline)
    }
}





//    private func updateCoinWithAmount(coin: CoinModel){
//
//            for coinAmountData in portfolioService.savedEntities{
//                if coin.id == coinAmountData.coinID {
//                    let newCoin = coin.updateHoldings(amount: coinAmountData.amount)
//                    if var row = vm.portfolioCoins.first(where: {$0.id == coin.id}) {
//                    }
//                }
//            }
//
//    }

//        vm.updatePortCoins(coin: coin)
