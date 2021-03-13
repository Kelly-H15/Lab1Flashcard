//
//  CreationViewController.swift
//  Lab1
//
//  Created by Kelly Henry on 3/11/21.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    
    @IBOutlet weak var questionTextField: UITextField!
   
    @IBOutlet weak var answerTextField: UITextField!
    
    
    override func viewDidLoad() {
       super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTaponCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
  
    @IBAction func didTapOnDone(_ sender: Any) {
        // Get text in the question text field
        let questionText = questionTextField.text
        
    // Get the text in the answer text field
        let answerText = answerTextField.text
        
    // Check if empty
        if questionText == nil || answerText == nil{
            let alert = UIAlertController(title:"Missing Text", message:"You need to enter both a question and an answer", preferredStyle:.alert)
            present(alert,animated:true)
        }
        
        
        else {
        flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
        }
        
        //Dismiss
        dismiss(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
