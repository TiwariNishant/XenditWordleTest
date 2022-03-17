//
//  Words.swift
//  WordleAssesment
//
//  Created by webwerks on 17/03/22.
//

import Foundation
import UIKit

struct WordDataModel {
    
   private var words = ["Hello", "Youth", "Mouth", "Teeth"]
    
    func generateWord() -> String {
        return (words.randomElement() ?? "Hello") 
        
    }
}
