//
//  MainVC.swift
//  AlphabetsBangla
//
//  Created by Arif  on 2/16/17.
//  Copyright © 2017 Arif . All rights reserved.
//

import UIKit

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var lessons = [Lesson]()
    var lessonCounter: Int! //once you finish a lesson, this will go up by one
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLayoutSubviews()
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        let lesson1Array = [["অ", "a", "4"], ["আ", "aa", "6"], ["ই", "i", "3"], ["ঈ", "ee", "5"], ["উ", "u", "3"]]
//        let lesson2Alpha = ["ঊ": 3, "ঋ": 5, "এ": 1, "ঐ": 2, "ও": 1, "ঔ": 2]
        let lesson2Array = [["ঊ", "u", "3"], ["এ", "ae", "1"], ["ঐ", "oy" ,"2"], ["ও", "o", "1"], ["ঔ", "ou", "2"]]
//        let lesson3Alpha = ["ক": 2, "খ": 3, "গ": 3, "ঘ": 2, "ঙ": 1]
//        let lesson4Alpha = ["চ": 2, "ছ": 2, "জ": 2, "ঝ": 4, "ঞ": 2, "য": 3, "শ": 4]
        
        let lesson1 = Lesson(lessonTitle: "Lesson 1", lessonCharacters: "অ  আ  ই  ঈ  উ", alphabets: lesson1Array)
        let lesson2 = Lesson(lessonTitle: "Lesson 2", lessonCharacters: "ঊ  এ  ঐ  ও  ঔ", alphabets: lesson2Array)
//        let lesson3 = Lesson(lessonTitle: "Lesson 3", lessonCharacters: "ক  খ  গ  ঘ  ঙ", alphabets: lesson3Alpha)
//        let lesson4 = Lesson(lessonTitle: "Lesson 4", lessonCharacters: "চ  ছ  জ  ঝ  ঞ  য  শ", alphabets: lesson4Alpha)
        
        lessons.append(lesson1)
        lessons.append(lesson2)
//        lessons.append(lesson3)
//        lessons.append(lesson4)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableFooterView = UIView(frame: .zero)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 125
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LessonCell", for: indexPath) as? LessonCell {
            let lesson = lessons[indexPath.row]
            cell.updateUI(lesson: lesson)
            
            return cell
        } else {
            return UITableViewCell()
            
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lessons.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lesson = lessons[indexPath.row]
        print(lesson.lessonTitle)
        UIView.setAnimationsEnabled(false)
        performSegue(withIdentifier: "LessonDetailVC", sender: lesson)
        
    }
 
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       if let destination = segue.destination as? LessonDetailVC {
        
          if let lesson = sender as? Lesson {
              destination.lesson = lesson
          }
       }
   }
    
    

}
