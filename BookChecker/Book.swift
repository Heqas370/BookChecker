//
//  Book.swift
//  BookChecker
//
//  Created by Adam Herman on 08/02/2026.
//

import Foundation
import SwiftData

@Model
class Book {
    
    var title: String
    var author: String
    var type: String
    var review: String
    var rating: Int
    
    init(title: String, author: String, type: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.type = type
        self.review = review
        self.rating = rating
    }
}
