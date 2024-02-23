//
//  SettingsView.swift
//  SwiftUI-Notes-WOS10.2 Watch App
//
//  Created by Daniel Felipe on 21/02/24.
//

import SwiftUI

struct SettingsView: View {
    //MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1
    @State private var value: Float = 1.0
    //MARK: - Function
    func update() {
        lineCount = Int(value)
    }
    //MARK: - Body
    var body: some View {
        VStack(spacing: 8) {
            //Header
            HeaderView(title: "Settings")
            //Actual line count
            Text("Lines: \(lineCount)".uppercased())
            //Slider
            Slider(value: Binding(
                get: {
                    self.value
                },
                set: { newValue in
                  if newValue > 0 {
                    self.value = newValue
                    self.lineCount = Int(value)
                  }
                }
            ), in: 0...4 , step: 1)
            .tint(.accentColor)
        }//: VStack
        .onAppear() {
            value = Float(lineCount)
        }
    }
}

#Preview { SettingsView() }
