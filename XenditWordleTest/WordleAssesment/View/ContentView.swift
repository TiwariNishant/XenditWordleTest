//
//  ContentView.swift
//  WordleAssesment
//
//  Created by webwerks on 17/03/22.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = WordleViewModel()
    @FocusState private var isTextActive: Bool
    
    var body: some View {
        VStack {
            ZStack {
                TextField("", text: $viewModel.wordStr)
                    .keyboardType(.asciiCapable)
                    .disableAutocorrection(true)
                    .focused($isTextActive)
                    .opacity(0)
                    .onChange(of: viewModel.wordStr.uppercased()) { newString in
                        if viewModel.validateFullWord(newString: newString) {
                            viewModel.evaluateWordData(newString: newString)
                        }
                    }
                GridView(
                    width: viewModel.width,
                    height: viewModel.height,
                    spacing: 8
                ) { row, column in
                    SquareBoxView(
                        letter: viewModel.letters[row][column],
                        evaluation: viewModel.letterMode[row][column]
                    )
                }
                .frame(maxHeight: .infinity)
                .onTapGesture {
                    isTextActive.toggle()
                }
            }
            Button("Reset") {
                withAnimation {
                    viewModel.resetGame()
                }
            }
            .padding(8)
        }
        .padding([.horizontal], 32)
        .padding([.vertical], 24)
        .background(Color.white)
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
