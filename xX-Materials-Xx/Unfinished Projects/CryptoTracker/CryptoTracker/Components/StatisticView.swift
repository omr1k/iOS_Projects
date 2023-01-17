//
//  StatisticView.swift
//  CryptoTracker
//
//  Created by Omar Khattab on 02/01/2023.
//

import SwiftUI

struct StatisticView: View {
    
    let statistic: StatisticModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4.0){
            Text(statistic.title)
                .font(.caption)
                .foregroundColor(Color.theme.SecondaryTextColor)
            
            Text(statistic.value)
                .font(.headline)
                .foregroundColor(Color.theme.accent)
            
            HStack{
                Image(systemName: "triangle.fill")
                    .font(.caption2)
                    .rotationEffect(Angle(degrees: (statistic.percentageChange ?? 0) >= 0 ? 0 : 180))
                
                Text(statistic.percentageChange?.asPercentString() ?? "")
                    .font(.caption)
                    .bold()
                
            }
            .foregroundColor((statistic.percentageChange ?? 0) >= 0 ? Color.theme.GreenColor : Color.theme.RedColor)
            .opacity(statistic.percentageChange == nil ? 0.0 : 1.0)
            
        }
    }
}

struct StatisticView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticView(statistic: StatisticModel.example())
            .previewLayout(PreviewLayout.sizeThatFits)
    }
}
