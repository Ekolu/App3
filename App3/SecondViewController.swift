//
//  SecondViewController.swift
//  App3
//
//  Created by Kipras on 2/17/16.
//  Copyright © 2016 Kipras. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        importTheText()
        randomText()
        pickSpeechParts()
        InputButton(0)
        inputButton.enabled = false

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var NumberOfWordsLeft: UILabel!
    @IBOutlet weak var ReminderSpeechType: UILabel!
    @IBOutlet weak var textFieldInput: UITextField!
    @IBOutlet weak var inputButton: UIButton!
    

    // Initializing variables
    var passedInput = [String]()
    var speechPartCounter = 0
    var wordsLeft: Int?
    var done: Int?
    var speechParts = [String]()
    var splitTextArray = [String]()
    var textRandom: String?
    var textArray = [String]()
    var wordCount = 1
    var previous = 0
    
    // Imports the madlib texts, returns an array of texts
    func importTheText () {
        let textNames = ["madlib0_simple", "madlib1_tarzan", "madlib2_university", "madlib3_clothes", "madlib4_dance"]
        
        for fileName in textNames {
            
            var text: String?
            
            if let path: String = NSBundle.mainBundle().pathForResource(fileName, ofType: "txt") {
                do {
                    text = try String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
                    textArray.append(text!)
                } catch {
                    print("Error")
                    /* error handling here */
                }
            }
        }
    }
    
    // Selects a random text
    func randomText (){
        var random = Int(arc4random_uniform(5))
        if random == previous
        {
            while random == previous
            {
                random = Int(arc4random_uniform(5))
            }
        }
        previous = random
        textRandom = textArray[random]
    }
    
    // Creates an array of speech parts that need to be filled in
    func pickSpeechParts (){
        splitTextArray = textRandom!.characters.split{$0 == " " || $0 == "\r\n"}.map(String.init)
        for scene in splitTextArray {
            if scene.hasPrefix("<") {
                let original = scene.substringToIndex(scene.endIndex.predecessor())
                let trunctated = original.substringFromIndex(original.startIndex.advancedBy(1))
                
                speechParts.append(trunctated)
            }
        }
        wordsLeft = speechParts.count
    }

    // The display of second view controller is update after each click
    // User input is collected into an array
    @IBAction func InputButton(sender: AnyObject) {
        if wordsLeft > 0
        {
            self.ReminderSpeechType.text = "Please type a/an \(speechParts[speechPartCounter])"
            self.NumberOfWordsLeft.text = "\(wordsLeft) word(s) left"
            textFieldInput.placeholder = speechParts[speechPartCounter]
            speechPartCounter += 1
            wordsLeft! -= 1
        }
        else
        {
            self.ReminderSpeechType.text = "You are done!"
            self.NumberOfWordsLeft.text = "You are done!"
            textFieldInput.placeholder = nil
            done = 1
        }
        
        passedInput.append(textFieldInput.text!)
        //rint(passedInput)
        
        textFieldInput.text="";
        inputButton.enabled = false
        

    }

    // validates user input
    @IBAction func Validation(sender: UITextField) {
        if (textFieldInput.text!.isEmpty)
        {
            inputButton.enabled = false
        }
        else
        {
            inputButton.enabled = true
        }
    }
    
    // Checks whether user has inputted all speech parts
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        //validation to change segue when all the input has been provided
        if done == 1
        {
            return true
            
        }
        else
        {
            return false
        }
    }
    
    // Generates the mad lib story text, converts it to a string and sends it to the 
    // third view controller
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        for scene in splitTextArray {
            if scene.hasPrefix("<") {
                let temp = splitTextArray.indexOf("\(scene)")
                splitTextArray[temp!] = passedInput[wordCount]
                wordCount += 1
            }
        }
        
        let finalText = splitTextArray.joinWithSeparator(" ")
    
        let generatedText = segue.destinationViewController as! ThirdViewController;
        
        generatedText.toPass = finalText
        generatedText.randomCounter = previous
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
