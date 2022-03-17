//
//  SquareBoxView.swift
//  WordleAssesment
//
//  Created by webwerks on 17/03/22.
//

import SwiftUI

struct SquareBoxView: View {
    let letter: Character?
    let evaluation: LetterType?
    
    var body: some View {
        ZStack() {
            RoundedRectangle(cornerRadius: 4)
                .stroke(Color.gray, lineWidth: 1)
                .background(
                    RoundedRectangle(cornerRadius: 4)
                        .fill(boxColor))
                .aspectRatio(1, contentMode: .fit)
            if let letter = letter {
                Text(String(letter))
                    .multilineTextAlignment(.center)
                    .font(.system(size: 36, weight: .bold, design: .rounded))
                    .foregroundColor(.black)
            }
        }
    }

    private var boxColor: Color {
        guard let evaluation = evaluation else {
            return .gray
        }
        return evaluation.color
    }
}

private extension LetterType {
    var color: Color {
        switch self {
        case .mismatch:
            return .unMatch
        case .exist:
            return .included
        case .match:
            return .match
        }
    }
}
