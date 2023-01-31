//
//  TextFieldStyle.swift
//  Little Lemon
//
//  Created by Fatih Yörük on 7.02.2023.
//

import Foundation
import SwiftUI

struct OutlinedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding()
            .overlay {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color(UIColor.systemGray4), lineWidth: 2.4)
            }
    }
}
