//
//  TraceVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 2/19/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit

class TraceVC: UIViewController {


    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var strokeLabel: UILabel!
    @IBOutlet weak var traceCharacter: UILabel!
    var timer: Timer!
    var time: Double = 0
    var i = 0 //char iterator
    private var _lesson: Lesson!
    var lastPoint = CGPoint.zero
    var swiped = false
    
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
    
    func setTimeAndStarData() {
        
        while i == lesson.alphabets.count - 1 {
            
            timer.invalidate()
            let strTime = time.strToTime()
            UserDefaults.standard.set(time, forKey: "\(lesson.lessonTitle)RawLastTime")
            UserDefaults.standard.set("\(strTime)", forKey: "\(lesson.lessonTitle)LastTime")
            
            if UserDefaults.standard.string(forKey: "\(lesson.lessonTitle)BestTime") == nil {
                UserDefaults.standard.set(time, forKey: "\(lesson.lessonTitle)RawBestTime")
                UserDefaults.standard.set("\(strTime)", forKey: "\(lesson.lessonTitle)BestTime")
            }
            
            let rawBestTime = UserDefaults.standard.double(forKey: "\(lesson.lessonTitle)RawBestTime")
            
            if time > rawBestTime {
                UserDefaults.standard.set(time, forKey: "\(lesson.lessonTitle)RawBestTime")
                UserDefaults.standard.set("\(strTime)", forKey: "\(lesson.lessonTitle)BestTime")
            }
            
            if time < 90.00 {
                UserDefaults.standard.set("3", forKey: "\(lesson.lessonTitle)starRating")
            } else if time < 180.00 {
                UserDefaults.standard.set("2", forKey: "\(lesson.lessonTitle)starRating")
            } else if time < 10000000.00 {
                UserDefaults.standard.set("1", forKey: "\(lesson.lessonTitle)starRating")
            }
        }
    }
    
    @IBAction func undoTapped() {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = false
        if let touch = touches.first {
            lastPoint = touch.location(in: self.view)
        }
    }
    
    func drawLines(fromPoint: CGPoint, toPoint: CGPoint) {
        UIGraphicsBeginImageContext(self.view.frame.size)
        imageView.image?.draw(in: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        var context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint(x: fromPoint.x, y: fromPoint.y))
        context?.addLine(to: CGPoint(x: toPoint.x, y: toPoint.y))
        
        context?.setBlendMode(CGBlendMode.normal)
        context?.setLineCap(CGLineCap.round)
        context?.setLineWidth(8)
        context?.setStrokeColor(UIColor(red: 255, green: 67, blue: 57, alpha: 1.0).cgColor)
        
        context?.strokePath()
        imageView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        swiped = true
        if let touch = touches.first {
            var currentPoint = touch.location(in: self.view)
            drawLines(fromPoint: lastPoint, toPoint: currentPoint)
            
            lastPoint = currentPoint
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !swiped {
            drawLines(fromPoint: lastPoint, toPoint: lastPoint)
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
