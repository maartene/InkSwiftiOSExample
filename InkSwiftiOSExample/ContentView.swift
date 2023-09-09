//
//  ContentView.swift
//  InkSwiftiOSExample
//
//  Created by Maarten Engels on 09/09/2023.
//

import SwiftUI
import InkSwift

struct ContentView: View {
    @StateObject var story = InkStory()
    
    var body: some View {
        VStack {
            Text(story.currentText)
            if story.canContinue {
                Button("Continue") {
                    story.continueStory()
                }
            }
            ForEach(story.options, id: \.index) { option in
                Button(option.text) {
                    story.chooseChoiceIndex(option.index)
                }
            }
        }.padding()
        .onAppear {
            loadStory()
        }
    }
    
    func loadStory() {
        guard let url = Bundle.main.url(forResource: "test.ink", withExtension: "json") else {
            fatalError("Could not find ink story file.")
        }

        guard let storyJSON = try? String(contentsOf: url) else {
            fatalError("Could not load story file.")
        }

        story.loadStory(json: storyJSON)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
