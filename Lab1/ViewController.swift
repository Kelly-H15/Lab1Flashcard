//
//  ViewController.swift
//  Lab1
//
//  Created by Kelly Henry on 2/20/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // card round corners
        card.layer.cornerRadius = 20.0;
        card.layer.shadowRadius = 15.0;
        card.layer.shadowOpacity = 0.9;
        
        // clip labels and round
        frontLabel.clipsToBounds = true;
        backLabel.clipsToBounds = true;
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        
        // button Design One
        btnOptionOne.layer.borderWidth = 3.0;
        btnOptionOne.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btnOptionOne.layer.cornerRadius = 15.0;
        
        // button Design Two
        btnOptionTwo.layer.borderWidth = 3.0;
        btnOptionTwo.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btnOptionTwo.layer.cornerRadius = 15.0;

        
        //button Design Three
        btnOptionThree.layer.borderWidth = 3.0;
        btnOptionThree.layer.borderColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        btnOptionThree.layer.cornerRadius = 15.0;

        
        // Do any additional setup after loading the view.
    }
    
// code for tapping card
    @IBAction func didTapOnButtons(_ sender: Any) {
        // toggle with card
        if (frontLabel.isHidden == false )
        {
        frontLabel.isHidden = true;
            return;
        }
        else if (frontLabel.isHidden == true)
        {
            frontLabel.isHidden = false;
            return;
        }
    }

// New flashcard
    func updateFlashcard(question: String, answer:String, extraAnswerOne: String?, extraAnswerTwo: String?, extraAnswerThree: String?)
    {
        frontLabel.text = question
        backLabel.text = answer
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(extraAnswerTwo, for: .normal)
        btnOptionThree.setTitle(extraAnswerThree, for: .normal)
    }
  
    // Tapped button One
    @IBAction func didTapButtonOne(_ sender: Any) {
        btnOptionOne.isHidden = true;
    }
    
    //Tapped button Two
    @IBAction func didTapButtonTwo(_ sender: Any) {
        frontLabel.isHidden = true;
        btnOptionOne.isHidden = true;
        btnOptionThree.isHidden = true;
        
    }
    
    // Tapped button Three
    @IBAction func didTapButtonThree(_ sender: Any) {
        btnOptionThree.isHidden = true;
    }
  
   
    override func prepare (for segue:UIStoryboardSegue, sender: Any?) {
    
        let navigationController = segue.destination as!
        UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
        
        if segue.identifier == "EditSegue"{
        creationController.initialQuestion = frontLabel.text
        creationController.initialAnswer = backLabel.text
        
        }
    }
    
    
    
    
}

