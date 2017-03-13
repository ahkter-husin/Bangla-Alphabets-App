//
//  TestVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 3/5/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit
import AVFoundation

class TestVC: UIViewController {

    var musicPlayer: AVAudioPlayer!
    
    @IBOutlet weak var optionOne: UIButton!
    @IBOutlet weak var optionTwo: UIButton!
    @IBOutlet weak var optionThree: UIButton!
    @IBOutlet weak var optionFour: UIButton!
    
    var randomNumbers: [Int]! = [0]
    var testAlphabets: [String]!
    var answerCounter: Int = 0
    
    var isItRight: Bool = false
    
    var alphaArray = ["অ", "আ", "ই", "ঈ", "উ", "ঊ", "ঋ", "ৠ", "ঌ", "ৡ", "এ", "ঐ", "ও", "ঔ", "ক", "খ", "গ", "ঘ", "ঙ", "হ", "চ", "ছ", "জ", "ঝ", "ঞ", "য", "শ", "ট", "ট", "ড", "ঢ", "ণ", "র", "ষ", "ত", "থ", "দ", "ধ", "ন", "ল", "স", "প", "ফ", "ব", "ভ", "ম", "ৱ", "ড়", "ঢ়", "য়"]
    
    var score = 0
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
        
        randomNumber()
        randomOptions()
        
    }

    @IBAction func letterSound(_ sender: Any) {
        
    }
    
    func randomAnswers() -> Array<String> {
        var charDict = lesson.alphabets.shuffled()
        let dictCount = lesson.alphabets.count
        
        var i = 0 //counter 
        
        if i < dictCount {
            if let char = charDict[i][0] as? String {
                testAlphabets.append(char)
            }
            i += 1
        }
        return testAlphabets
    }
    
    
    func generateRandomOptions() {
        var array = testAlphabets!
        var i = 0
        var optionsArray: [String] = []
        var alphaCount = alphaArray.count
        var o = ""
       
            repeat {
                let o = alphaArray[(Int(arc4random_uniform(UInt32(alphaCount))))]
                optionsArray.append(o)
            } while optionsArray.count < 3 && o != array[0]
        
    }
    
    
//    func example() {
//        
//        var y = 0
//        var array = testAlphabets!
//        var count = alphaArray.count
//        var alphaCount = alphaArray.count
//        var randomArray: [String]
//        
//        if y < count {
//            
//            var char = alphaArray[y]
//            
//            repeat {
//                alphaArray[(Int(arc4random_uniform(UInt32(alphaCount))))]
//            } while alphaArray[(Int(arc4random_uniform(UInt32(alphaCount))))] != char {
//                
//            }
//        
//        }
//    }
    
    
//    func setAnswer() {
//        let charDict = lesson.alphabets.shuffled()
//        var letterCount = lesson.alphabets.count //example: this is 6
//        
//        if i < letterCount {
//            if let currentChar = charDict[i][0] as? String {
//                currentAnswer = currentChar
//                
//                let path = Bundle.main.path(forResource: currentAnswer, ofType: "mp3")!
//                
//                do {
//                    musicPlayer = try AVAudioPlayer(contentsOf: URL(string: path)!)
//                    musicPlayer.prepareToPlay()
//                    musicPlayer.numberOfLoops = 1 //will play once
//                    musicPlayer.play()
//                    
//                } catch let err as NSError {
//                    print(err.debugDescription)
//                }
//            }
//        }
//    }
    
    
    func randomNumber() {
        var a: Int!
        repeat {
            repeat {
                let a = Int(arc4random_uniform(50) + 1)
            } while randomNumbers.contains(a)
            randomNumbers.append(a)
        } while randomNumbers.count < 4
    }
    
    
    func randomOptions() {
        var btnArray = [optionOne, optionTwo, optionThree, optionFour].shuffled()
        var index = [0, 1, 2, 3].shuffled()

        var zero = index[0]
        var one = index[1]
        var two = index[2]
        var three = index[3]
        
//        btnArray[zero]?.setTitle(String(randomNumbers[0]), for: .normal)
//        btnArray[one]?.setTitle(String(randomNumbers[1]), for: .normal)
//        btnArray[two]?.setTitle(String(randomNumbers[2)], for: .normal)
//        btnArray[three]?.setTitle(String(currentAnswer), for: .normal)
        
        
    }
    
    func selectAnswer() {
        
    }
    
    func convertString(string: String) -> String {
        let data = string.data(using: String.Encoding.ascii, allowLossyConversion: true)
        return NSString(data: data!, encoding: String.Encoding.ascii.rawValue) as! String
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

//get the answers in an array answerArray
//generate random characters for each element in answerArray and make sure the random characters don't match the element in answerArray


