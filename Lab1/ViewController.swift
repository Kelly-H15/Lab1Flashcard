//
//  ViewController.swift
//  Lab1
//
//  Created by Kelly Henry on 2/20/21.
//

import UIKit

struct Flashcard{
    var question: String
    var answer: String
    var extraAnswerOne : String
    var extraAnswerTwo : String
    var extraAnswerThree : String
    
}
class ViewController: UIViewController {

    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    var flashcards = [Flashcard]()
    
    //Current flashcard index
    var currentIndex = 0
   
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    
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
        
        
        
            //Read saved flashcards
        readSavedFlashcard()
        
        //Adding our initial flashcard if needed
        if flashcards.count == 0{
            updateFlashcard(question: "What is Blue in Spanish?", answer: "Azul", extraAnswerOne: "Anaranjado", extraAnswerTwo: "Azul", extraAnswerThree: "Rojo")
        }
        else{
            updateLabels()
            updateNextPrevButtons()
        }
        
       // updateFlashcard(question: "What is Red in Spanish", answer:"Rojo", extraAnswerOne:"Anaranjado", extraAnswerTwo:"Rojo", extraAnswerThree: "Verde")

    
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
    func updateFlashcard(question: String, answer:String, extraAnswerOne: String, extraAnswerTwo: String, extraAnswerThree: String)
    {
        let flashcard = Flashcard(question: question, answer: answer, extraAnswerOne: extraAnswerOne, extraAnswerTwo:extraAnswerTwo, extraAnswerThree: extraAnswerThree)
        
        frontLabel.text = flashcard.question
        backLabel.text = flashcard.answer
        
        //Adding flashcard in flashcard array
        flashcards.append(flashcard)
     
        // logging into console
    
        print("🥳 Added new flashcard")
        print("🥳 We now have \(flashcards.count) flashcards")
        
        //update current index
        currentIndex = flashcards.count - 1
        print("🥳 Our current index is \(currentIndex)")
        
        //Update Buttons
        updateNextPrevButtons()
        
        
        btnOptionOne.setTitle(extraAnswerOne, for: .normal)
        btnOptionTwo.setTitle(extraAnswerTwo, for: .normal)
        btnOptionThree.setTitle(extraAnswerThree, for: .normal)
        
        //update labels
        updateLabels()
        
        saveAllFlashcardsToDisk()
        
        
    }
    func updateLabels() {
         //get current flashcard
        
        
        if currentIndex >= 0 && currentIndex < flashcards.count
        {
        let currentFlashcard = flashcards [currentIndex]
            //update labels
            frontLabel.text = currentFlashcard.question
            backLabel.text = currentFlashcard.answer
            
            btnOptionOne.setTitle(currentFlashcard.extraAnswerOne, for: .normal)
            btnOptionTwo.setTitle(currentFlashcard.extraAnswerTwo, for: .normal)
            btnOptionThree.setTitle(currentFlashcard.extraAnswerThree, for: .normal)
            
        
        }
        
    }
  
    func saveAllFlashcardsToDisk(){
        
        let dictionaryArray = flashcards.map { (card) -> [String:String] in return ["question": card.question, "answer": card.answer]
        }
        //Save array on disk using userDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        
        // log it
        print("🎉 Flashcards saved to UserDefaults")
    }
    
    func readSavedFlashcard(){
        if let dictionaryArray = UserDefaults.standard.array(forKey:"flashcard") as? [[String:String]] {
      
        // In here we know for sure we have a dictionary error
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!, extraAnswerOne: dictionary["extraAnswerOne"]!, extraAnswerTwo: dictionary["extraAnswerTwo"]!,extraAnswerThree: dictionary["extraAnswerThree"]!)
                
            }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
            
        }
    }
    func updateNextPrevButtons(){
        
        // Disable next button if at the end
        if currentIndex == flashcards.count - 1 {
            nextButton.isEnabled = false
        } else{
            nextButton.isEnabled = true
        }
        
        // Disable prev button if at the beginning
        if currentIndex == 0 {
            prevButton.isEnabled = false
        } else{
            prevButton.isEnabled = true
        }
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
 
    @IBAction func didTapOnNext(_ sender: Any) {
        
        // Increases current index
        currentIndex = currentIndex + 1
        
        // update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        
        // Increases current index
        currentIndex = currentIndex - 1
        
        // update labels
        updateLabels()
        
        //Update buttons
        updateNextPrevButtons()
    }
    
   
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        // Show confirmation
        let alert = UIAlertController(title: "Delete flashcards", message: "Are you sure you want to delete this flashcard?", preferredStyle: .actionSheet)
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ action in self.deleteCurrentFlashcard()
        }
        
        alert.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
        
    }
    
    func deleteCurrentFlashcard()
    {
        // Delete current
        flashcards.remove(at: currentIndex)
        
        //Special case: Check if last card was deleted
        if currentIndex > flashcards.count - 1
        {
            currentIndex = flashcards.count - 1
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
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

