//
//  Home.swift
//  Little Lemon
//
//  Created by Fatih Yörük on 4.02.2023.
//

import SwiftUI

struct HomeView: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            MenuView()
                .tabItem({
                    Label("Menu", systemImage: "list.dash")
                })
            UserProfileView()
                .tabItem({
                    Label("Profile", systemImage: "square.and.pencil")
                })
        }.environment(\.managedObjectContext, persistence.container.viewContext)
            .navigationBarBackButtonHidden(true)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
