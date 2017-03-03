//
//  Lesson.swift
//  AlphabetsBangla
//
//  Created by Arif  on 2/17/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import Foundation


class Lesson {
    
    private var _lessonTitle: String!
    private var _lessonCharacters: String!
    private var _alphabets: [Array<String>]

    
    var lessonTitle: String {
        if _lessonTitle == nil {
            _lessonTitle = "aa"
        }
        return _lessonTitle
    }
    
    var lessonCharacters: String {
        return _lessonCharacters
    }
    
    var alphabets: [Array<String>] {
        return _alphabets
    }
    
    init(lessonTitle: String, lessonCharacters: String, alphabets: [Array<String>]){
        
        _lessonTitle = lessonTitle
        _lessonCharacters = lessonCharacters
        _alphabets = alphabets
        
    }
    
}
