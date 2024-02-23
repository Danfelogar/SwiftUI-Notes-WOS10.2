//
//  HeaderView.swift
//  SwiftUI-Notes-WOS10.2 Watch App
//
//  Created by Daniel Felipe on 21/02/24.
//

import SwiftUI

struct HeaderView: View {
    //MARK: - Properties
    var title: String = ""
    //MARK: - Body
    var body: some View {
        VStack {
            //Title
            if title != "" {
                Text(title.uppercased())
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }
            //Spearator
            HStack {
                Capsule()
                    .frame(height: 1)
                
                Image(systemName: "note.text")
                
                Capsule()
                    .frame(height: 1)
            }//: HStack
            .foregroundColor(.accentColor)
        }//: VStack
    }
}

#Preview {
    HeaderView(title: "hello, world!")
}
