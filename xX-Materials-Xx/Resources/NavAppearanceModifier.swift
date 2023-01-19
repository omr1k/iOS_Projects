//
//  NavAppearanceModifier.swift
//  Bookworm
//
//  Created by Omar Khattab on 06/09/2022.
//

import SwiftUI

struct NavAppearanceModifier: ViewModifier {
    
    init(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor?, hideSeparator: Bool) {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [.foregroundColor: foregroundColor]
        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: foregroundColor]
//        navBarAppearance.backgroundColor = backgroundColor
        navBarAppearance.configureWithTransparentBackground()
        if hideSeparator {
            navBarAppearance.shadowColor = .clear
        }
        UINavigationBar.appearance().standardAppearance = navBarAppearance
        UINavigationBar.appearance().compactAppearance = navBarAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
        if let tintColor = tintColor {
            UINavigationBar.appearance().tintColor = tintColor
        }
    }
    
    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func navigationAppearance(backgroundColor: UIColor, foregroundColor: UIColor, tintColor: UIColor? = nil, hideSeparator: Bool = false) -> some View {
        self.modifier(NavAppearanceModifier(backgroundColor: backgroundColor, foregroundColor: foregroundColor, tintColor: tintColor, hideSeparator: hideSeparator))
        
    }
}


//UINavigationBar.appearance().standardAppearance = navBarAppearance
//UINavigationBar.appearance().compactAppearance = navBarAppearance
//UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance


// Usage
//    .navigationAppearance(backgroundColor: .purple, foregroundColor: .black, tintColor: .black, hideSeparator: true)
