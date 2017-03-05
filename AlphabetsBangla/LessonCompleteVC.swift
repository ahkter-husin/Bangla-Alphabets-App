//
//  LessonCompleteVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 3/4/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit

class LessonCompleteVC: UIViewController {

    @IBOutlet weak var lessonTitle: UILabel!
    @IBOutlet weak var completeLabel: UILabel!
    @IBOutlet weak var retryLabel: UIButton!
    @IBOutlet weak var testLabel: UIButton!
    
    private var _lesson: Lesson!
    
    var lesson: Lesson {
        get {
            return _lesson
        } set {
            _lesson = newValue
        }
    }
    
    let attributes: [String: Any] = [NSStrokeWidthAttributeName: 2.0,
                                     NSStrokeColorAttributeName: UIColor.white,
                                     NSForegroundColorAttributeName: UIColor.red
                                    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        lessonTitle.text = lesson.lessonTitle
        styleLabel(uilabel: completeLabel)
        styleButton(uibutton: retryLabel)
        styleButton(uibutton: testLabel)
        
    }
    
    func styleLabel(uilabel: UILabel) {
        uilabel.attributedText = NSAttributedString(string: completeLabel.text!, attributes: attributes)
    }
    
    func styleButton(uibutton: UIButton) {
        uibutton.layer.cornerRadius = 10
    }
    
    @IBAction func backBtn(_ sender: Any) {
        
    }

    @IBAction func retryBtn(_ sender: Any) {
        
    }

    @IBAction func testBtn(_ sender: Any) {
        
    }
    
}
