//
//  LessonCell.swift
//  AlphabetsBangla
//
//  Created by Arif  on 2/16/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit

class LessonCell: UITableViewCell {

    @IBOutlet weak var cellTitle: UILabel!
    @IBOutlet weak var cellCharacters: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func updateUI(lesson: Lesson) {
        cellTitle.text = lesson.lessonTitle
        cellCharacters.text = lesson.lessonCharacters
}
}
