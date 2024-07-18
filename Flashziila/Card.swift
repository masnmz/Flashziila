//
//  Card.swift
//  Flashziila
//
//  Created by Mehmet Alp Sönmez on 16/07/2024.
//

import Foundation

struct Card {
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who", answer: "Jodie Whittaker")
}
