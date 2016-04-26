//
//  ViewController.swift
//  simple-calc
//
//  Created by Peter Freschi on 4/20/16.
//  Copyright © 2016 Peter Freschi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var current = ""
    var viewForHistory = ""
    var history = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnNumber(sender: UIButton) {
        let num = sender.titleLabel!.text!
        current = current + "\(num)"
        if (resultArea.text != "0"){
            resultArea.text = resultArea.text! + num
        } else {
            resultArea.text = num
        }
    }

    @IBAction func btnOperation(sender: UIButton) {
        let op = sender.titleLabel!.text!
        resultArea.text = ""
        if (op != "=") {
            current = current + " \(op) "
        } else {
            viewForHistory = "\(current) = "
            viewForHistory = viewForHistory + processRequest()
            history.append(viewForHistory)
            viewForHistory = ""

        }
    }

    @IBOutlet weak var resultArea: UILabel!
    
    @IBAction func clear(sender: UIButton) {
        current = ""
        resultArea.text = "0"
    }
    
    func processRequest() -> String {
        let response = current
        var responses = response.componentsSeparatedByString(" ")

        if (!responses.contains("count") && !responses.contains("avg") && !responses.contains("fact") ) {
            let first = Int(responses[0])
            let operation = responses[1]
            let second = Int(responses[2])
            var result = Int.init()
            
            switch operation {
            case "+":
                result = first! + second!
            case "-":
                result = first! - second!
            case "*":
                result = first! * second!
            case "/":
                result = first! / second!
            case "%":
                result = first! % second!
            default:
                print("invalid operation")
            }
            resultArea.text = ("\(result)")
            current = String(result)
            return String(result)
        } else if (responses.contains("count")){
            var count = 0
            for response in responses {
                if (response != "count" && response != "="){
                    count = count + 1
                }
            }
            resultArea.text = ("\(count)")
            return ("\(count)")
        }  else if (responses.contains("avg")){
            var nums = [Int]()
            for response in responses {
                if (response != "avg" && response != "=" && response != ""){
                    nums.append(Int(response)!)
                }
            }
            let avg = nums.reduce(0, combine: +)/nums.count
            resultArea.text = ("\(avg)")
            return ("\(avg)")

        } else if (responses.contains("fact")){
            var number = Int(responses[0])
            var result = 1
            while (number > 1) {
                result = result * number!
                number = number! - 1
            }
            resultArea.text = ("\(result)")
            return ("\(result)")
        } else {
            return "error"
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "ShowHistoryController"{
            let vc = segue.destinationViewController as! ViewControllerHistory
            vc.history = self.history
        }
    }

}

