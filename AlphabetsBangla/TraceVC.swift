//
//  TraceVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 2/19/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit

class TraceVC: UIViewController {


    @IBOutlet weak var strokeLabel: UILabel!
    @IBOutlet weak var traceCharacter: UILabel!
    var timer: Timer!
    var time: Double = 0
    
    var i = 0

    //char iterator

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

        firstChar()
        startTimer()
        
    }
    
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    func updateTimer() {
        time = time + 1
    }
    
    
    func firstChar() {
        let charDict = lesson.alphabets
        let currentChar = charDict[0][0]
        let charSound = charDict[0][1]
        let strokeCount = charDict[0][2]
        
        traceCharacter.text = currentChar
    }
    

    @IBAction func nextCharacter(_ sender: UIButton) {
        let charDict = lesson.alphabets
        print(Int(UserDefaults.standard.string(forKey: "\(lesson.lessonTitle)" + "BestTime")!)!)

        if i < lesson.alphabets.count - 1 {
            i += 1
            print(i)
            
        }

        if i < lesson.alphabets.count {
            if let currentChar = charDict[i][0] as? String {
                traceCharacter.text = currentChar
            }
            
            if let charSound = charDict[i][1] as? String {
                
            }
            
            if let strokeCount = charDict[i][2] as? String {
                
            }
            
        }

    }
    
    func setTimeData() {
        
        while i == lesson.alphabets.count - 1 {
            
            timer.invalidate()
            let strTime = time.strToTime()
            UserDefaults.standard.set(time, forKey: "\(lesson.lessonTitle)RawLastTime")
            UserDefaults.standard.set("\(strTime)", forKey: "\(lesson.lessonTitle)LastTime")
            
            let rawLastTime = UserDefaults.standard.integer(forKey: "\(lesson.lessonTitle)RawLastTime")
            
            if UserDefaults.standard.string(forKey: "\(lesson.lessonTitle)BestTime") == "0" {
                UserDefaults.standard.set(rawLastTime, forKey: "\(lesson.lessonTitle)RawBestTime")
                UserDefaults.standard.set("\(strTime)", forKey: "\(lesson.lessonTitle)BestTime")
            }
            
            let rawBestTime = UserDefaults.standard.integer(forKey: "\(lesson.lessonTitle)RawBestTime")
            
            if rawLastTime > rawBestTime {
                UserDefaults.standard.set(rawLastTime, forKey: "\(lesson.lessonTitle)RawBestTime")
                UserDefaults.standard.set("\(strTime)", forKey: "\(lesson.lessonTitle)BestTime")
            }
        }
    }
}

extension Double {
    func strToTime() -> String {
        let time: Double = self
        let minutes = floor(time/60)
        let minutesExact = time/60
        
        let seconds = Int((minutesExact - minutes) * 60)
        
        var timeMinutes = ""
        if minutes == 00 {
            timeMinutes = "00"
        } else if  minutes < 10 {
            timeMinutes = "0\(minutes)"
        } else if minutes < 60 {
            timeMinutes = "\(minutes)"
        }
        
        
        var timeSeconds = ""
        if seconds < 10 {
            timeSeconds = "0\(seconds)"
        } else {
            timeSeconds = "\(seconds)"
        }
        
        return "\(timeMinutes):\(timeSeconds)"
        
    }
    
}
