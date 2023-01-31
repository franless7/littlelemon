//
//  HeaderView.swift
//  Little Lemon
//
//  Created by Fatih Yörük on 6.02.2023.
//

import SwiftUI

struct Header: View {
    var body: some View {
        VStack {
            HStack(spacing: 50) {
                Spacer()
                LittleLemonLogo()
                Image("profile-image-placeholder")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
            }.padding()
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        Header()
    }
}
