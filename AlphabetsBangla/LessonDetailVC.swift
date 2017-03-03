//
//  LessonDetailVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 2/18/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit
import CoreData


class LessonDetailVC: UIViewController {
    
    @IBOutlet weak var lessonTitleLabel: UILabel!
    @IBOutlet weak var bestTimeLabel: UILabel!
    @IBOutlet weak var lastTimeLabel: UILabel!
    @IBOutlet weak var lastCompletedLabel: UILabel!
    @IBOutlet weak var timesCompletedLabel: UILabel!
    @IBOutlet weak var starOne: UIImageView!
    @IBOutlet weak var starTwo: UIImageView!
    @IBOutlet weak var starThree: UIStackView!
    
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
        
        updateUI()
        updateStars()
        setData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
           }
    
    func updateUI() {
       
        lessonTitleLabel.text = lesson.lessonTitle
        
        
    }
    
    func setData() {
        
        let lesson = lessonTitleLabel.text!
        
        if UserDefaults.standard.string(forKey: "\(lesson)" + "BestTime") == nil {
            bestTimeLabel.text = "-"
        } else {
            bestTimeLabel.text = UserDefaults.standard.string(forKey: "\(lesson)BestTime")!
        }
        
        
        if UserDefaults.standard.string(forKey: "\(lesson)" + "LastTime") == nil {
            lastTimeLabel.text = "-"
        } else {
            lastTimeLabel.text = UserDefaults.standard.string(forKey: "\(lesson)LastTime")
        }
    }
    
    func updateStars() {
        UserDefaults.standard.set("0", forKey: "\(lesson)starRating")
        
        let starRating = UserDefaults.standard.string(forKey: "\(lesson)starRating")
        print(starRating!)
        
        if starRating == "0" {
            print("Arrow")
            starOne.image = UIImage(named: "greyStar")
            starTwo.image = UIImage(named: "greyStar")
            starTwo.image = UIImage(named: "greyStar")
        } else if starRating == "1" {
            starOne.image = UIImage(named: "yellowStar")
            starTwo.image = UIImage(named: "greyStar")
            starTwo.image = UIImage(named: "greyStar")
        } else if starRating == "2" {
            starOne.image = UIImage(named: "yellowStar")
            starTwo.image = UIImage(named: "yellowStar")
            starTwo.image = UIImage(named: "greyStar")
        } else if starRating == "3" {
            starOne.image = UIImage(named: "yellowStar")
            starTwo.image = UIImage(named: "yellowStar")
            starOne.image = UIImage(named: "yellowStar")
        }
    }
    
    @IBAction func practiceBtn(_ sender: UIButton) {
        UIView.setAnimationsEnabled(false)
        performSegue(withIdentifier: "TraceVC", sender: lesson)
    }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        UIView.setAnimationsEnabled(false)
        if let destination = segue.destination as? TraceVC {
            
            if let lesson = sender as? Lesson {
                destination.lesson = lesson
            }
            
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }


}

