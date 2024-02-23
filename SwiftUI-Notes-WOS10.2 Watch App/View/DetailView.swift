//
//  DetailView.swift
//  SwiftUI-Notes-WOS10.2 Watch App
//
//  Created by Daniel Felipe on 21/02/24.
//

import SwiftUI

struct DetailView: View {
    //MARK: - Properties
    let note:Note
    let count: Int
    let index: Int
    
    @State private var isCreditsPresented: Bool = false
    @State private var isSettingsPresented: Bool = false
    //MARK: - Body
    var body: some View {
        VStack(alignment: .center, spacing: 3) {
            // Header
            HeaderView(title: "")
            
            //Content
            Spacer()
            
            ScrollView(.vertical) {
                Text(note.text)
                    .font(.title3)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.center)

            }//: Scroll
            
            Spacer()
            //Footer
            HStack(alignment: .center) {
                Image(systemName: "gear")
                    .imageScale(.large)
                    .onTapGesture {
                        isSettingsPresented.toggle()
                    }
                    .sheet(isPresented: $isSettingsPresented, content: {
                        SettingsView()
                    })
                
                
                Spacer()
                
                Text("\(count) / \(index + 1)")
               
                Spacer()

                Image(systemName: "info.circle")
                    .imageScale(.large)
                    .onTapGesture {
                        isCreditsPresented.toggle()
                    }
                    .sheet(isPresented: $isCreditsPresented, content: {
                        CreditsView()
                    })
            }//: VStack
            .foregroundStyle(.secondary)
            
        }//: VStack
        .padding(3)
    }
}

#Preview {
    DetailView(note: Note(id: UUID(), text: "Hello, world!"), count: 5, index: 1)
}
