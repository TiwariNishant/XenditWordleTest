//
//  WordleViewModel.swift
//  WordleAssesment
//
//  Created by webwerks on 17/03/22.
//

import SwiftUI
import Foundation

enum LetterType {
    case match
    case mismatch
    case exist
    
}

class WordleViewModel: ObservableObject {
    
    let width: Int
    let height: Int

    @Published var solved: Bool = false
    @Published var lost: Bool = false
    @Published var letters: [[Character?]]
    @Published var letterMode: [[LetterType?]] = []
    
    @Published var wordStr: String = "" {
        didSet {
            stringToLetters(wordStr)
        }
    }

    private var wordleWord: String = ""
    private let allowedCharacters = CharacterSet.letters
    private var activeRow: Int = 0

    init(width: Int = 5, height: Int = 6) {
        self.width = width
        self.height = height
        letters = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        letterMode = Array(
            repeating: .init(repeating: nil, count: width),
            count: height
        )
        resetGame()
    }

    func validateRandomWord() -> Bool {
        return wordleWord.isEmpty == false
    }
    
    func resetGame() {
        activeRow = 0
        wordStr = ""
        letterMode = letterMode.map { $0.map { _ in nil }}
        wordleWord = WordDataModel().generateWord()
    }
    
    func validateFullWord(newString:String) ->Bool{
        let finishedFullWord = newString.uppercased().count - activeRow * width == width
        return finishedFullWord
    }
    
    func evaluateWordData(newString:String) {
        guard validateRandomWord() else {return}
        wordStr = newString.uppercased()
        let word = String(wordStr.suffix(width))
        let solution = Array(wordleWord.uppercased())
        let rowEvaluation: [LetterType] = word
            .uppercased()
            .enumerated()
            .map { index, character in
                if character == solution[index] {
                    return .match
                } else if solution.contains(character) {
                    return .exist
                } else {
                    return .mismatch
                }
            }
        letterMode[activeRow] = rowEvaluation
        activeRow += 1
    }
    
    private func stringToLetters(_ string: String) {
        for i in 0..<height {
            for j in 0..<width {
                let index = i * width + j
                if index < string.count {
                    letters[i][j] = [Character](string)[index]
                } else {
                    letters[i][j] = nil
                }
            }
        }
    }
}

