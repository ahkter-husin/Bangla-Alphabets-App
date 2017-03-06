//
//  TestVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 3/5/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit

class TestVC: UIViewController {

    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var optionFour: UIButton!
    var i = 0 //counter
    var currentAnswer = ""
    
    private var _lesson: Lesson!
    
    var lesson: Lesson {
        get {
            return _lesson
        } set {
            _lesson = newValue
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func letterSound(_ sender: Any) {
        
    }
    
    
    func setAnswer() {
        let charDict = lesson.alphabets.shuffled()
        var letterCount = lesson.alphabets.count //example: this is 6
        
        if i < letterCount {
            if let currentChar = charDict[i][0] as? String {
                currentAnswer = currentChar
            }
        }
        
        
    }

}



extension MutableCollection where Indices.Iterator.Element == Index {
    /// Shuffles the contents of this collection.
    mutating func shuffle() {
        let c = count
        guard c > 1 else { return }
        
        for (firstUnshuffled , unshuffledCount) in zip(indices, stride(from: c, to: 1, by: -1)) {
            let d: IndexDistance = numericCast(arc4random_uniform(numericCast(unshuffledCount)))
            guard d != 0 else { continue }
            let i = index(firstUnshuffled, offsetBy: d)
            swap(&self[firstUnshuffled], &self[i])
        }
    }
}


extension Sequence {
    /// Returns an array with the contents of this sequence, shuffled.
    func shuffled() -> [Iterator.Element] {
        var result = Array(self)
        result.shuffle()
        return result
    }
}
