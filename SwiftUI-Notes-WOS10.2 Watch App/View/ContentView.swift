//
//  ContentView.swift
//  SwiftUI-Notes-WOS10.2 Watch App
//
//  Created by Daniel Felipe on 21/02/24.
//

import SwiftUI

struct ContentView: View {
    //MARK: - Properties
    @AppStorage("lineCount") var lineCount: Int = 1

    @State private var notes: [Note] = [Note]()
    @State private var text: String = ""
    
    //functions
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        //        dump(notes)
        DispatchQueue.main.async {
            do {
                //1. Convert the notes array to data using JSONEncoder
                let data = try JSONEncoder().encode(notes)
                //2. Create a new URL to save the file using the getDocumentDirectory
                let  url = getDocumentDirectory().appendingPathComponent("notes")
                //3. Write the data to the given URL
                try data.write(to: url)
            }catch{
                print("Saving data has failed")
            }
        }
    }
    
    func load() {
        do {
            //1. Get the notes Url path
            let url = getDocumentDirectory().appendingPathComponent("notes")
            //2. Create a new property for the data
            let data = try Data(contentsOf: url)
            //3. Decode the data
            notes = try JSONDecoder().decode([Note].self, from: data)
        }catch {
            //Do nothing
        }
    }
    
    func delete(offsetes: IndexSet) {
        notes.remove(atOffsets: offsetes)
        save()
    }
    
    //MARK: - Body
    var body: some View {
        NavigationStack {
            VStack {
                HStack(alignment: .center, spacing: 6) {
                    TextField("Add New Note", text: $text)
                    
                    Button {
                        //Action
                        //1. Only run the button's action when the text field is not empty
                        guard text.isEmpty == false else { return }
                        //2. Create a new note item and initialize it with the text value
                        let note  = Note(id: UUID(), text: text)
                        //3. Add the new note item to the notes array (append)
                        notes.append(note)
                        //4. Make the text field empty
                        text = ""
                        //5. Save the notes (function)
                        save()
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 42, weight: .semibold))
                    }//:Btn
                    .fixedSize()
                    .buttonStyle(PlainButtonStyle())
                    .foregroundColor(.accentColor)
                    //.buttonStyle(BorderedButtonStyle(tint: .accentColor))
                }//: HStack
                
                Spacer()
                
                if notes.count >= 1 {
                    List {
                        ForEach(0..<notes.count, id: \.self) { i in
                            NavigationLink(destination: DetailView(note: notes[i], count: notes.count, index: i)) {
                                HStack {
                                    Capsule()
                                        .frame(width: 4)
                                        .foregroundColor(.accentColor)
                                    Text(notes[i].text)
                                        .lineLimit(lineCount)
                                        .padding(.leading, 5)
                                }//: HStack
                            }//: Nav link
                        }//: Loop
                        .onDelete(perform: delete)
                    }//: List
                } else {
                    Spacer()
                    Image(systemName: "note.text")
                        .resizable()
                        .scaledToFit()
                        .foregroundStyle(.gray)
                        .opacity(0.25)
                        .padding()
                    Spacer()
                }
            }//: VStack
            .navigationTitle("Notes")
            .onAppear(perform: {
                load()
            })
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview { ContentView() }
