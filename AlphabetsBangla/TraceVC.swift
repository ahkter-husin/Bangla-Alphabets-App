//
//  TraceVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 2/19/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit

class TraceVC: UIViewController {



    @IBOutlet weak var boardImageView: UIImageView!
    @IBOutlet weak var strokeLabel: UILabel!
    @IBOutlet weak var traceCharacter: UILabel!
    var timer: Timer!
    var time: Double = 0
    var i = 0 //char iterator
    var strokeCounter = 0 //stroke iterator
    private var _lesson: Lesson!
    
    //second method
    var finalPoint: CGPoint!
    var isDrawing: Bool!
    var lineWidth: CGFloat = 8.0
    var red: CGFloat!
    var green: CGFloat!
    var blue: CGFloat!
    
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
        
        red = 255.0/255.0
        green = 67.0/255.0
        blue = 57.0/255.0
        
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
                if strokeCount == "1" {
                    strokeLabel.text = "\(strokeCount) stroke left"
                } else {
                    strokeLabel.text = "\(strokeCount) strokes left"
                }
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
    
    @IBAction func undoDrawing(_ sender: AnyObject) {
        self.boardImageView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = false
        if let touch = touches.first {
            finalPoint = touch.preciseLocation(in: boardImageView)
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        isDrawing = true
        
        if let touch = touches.first {
            
            let currentCoordinate = touch.preciseLocation(in: boardImageView)
            
            UIGraphicsBeginImageContext(boardImageView.frame.size)
            boardImageView.image?.draw(in: CGRect(x: 0, y: 0, width: boardImageView.frame.size.width, height: boardImageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: finalPoint.x, y: finalPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currentCoordinate.x, y: currentCoordinate.y))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(lineWidth)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.strokePath()
            boardImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            finalPoint = currentCoordinate
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (!isDrawing) {
            
            UIGraphicsBeginImageContext(boardImageView.frame.size)
            boardImageView.image?.draw(in: CGRect(x: 0, y: 0, width: boardImageView.frame.size.width, height: boardImageView.frame.size.height))
            UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: finalPoint.x, y: finalPoint.y))
            UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: finalPoint.x, y: finalPoint.y))
            UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
            UIGraphicsGetCurrentContext()?.setLineWidth(lineWidth)
            UIGraphicsGetCurrentContext()?.setStrokeColor(red: red, green: green, blue: blue, alpha: 1.0)
            UIGraphicsGetCurrentContext()?.strokePath()
            self.boardImageView.image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
        }
        strokeCounter += 1
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
