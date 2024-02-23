//
//  CreditsView.swift
//  SwiftUI-Notes-WOS10.2 Watch App
//
//  Created by Daniel Felipe on 21/02/24.
//

import SwiftUI

struct CreditsView: View {
    //MARK: - Properties
    @State private var randomNumber: Int = Int.random(in: 1..<4)
    
    private var randomImage: String {
        return "developer-no\(randomNumber)"
    }
    //MARK: - Body
    var body: some View {
        VStack(spacing: 3) {
            // Profile
            Image(randomImage)
                .resizable()
                .scaledToFit()
                .layoutPriority(1)
            //Header
            HeaderView(title: "Credits")
            //Content
            Text("Danfelogar")
                .foregroundStyle(.primary)
                .fontWeight(.bold)
            
            Text("Mobile Developer")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .fontWeight(.light)
        }// :VStack
    }
}

#Preview {
    CreditsView()
}
