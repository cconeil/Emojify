//
//  ViewController.swift
//  Swiftmoji
//
//  Created by Chris O'Neil on 4/7/16.
//  Copyright © 2016 Because. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let tf = UITextField(frame: CGRect(x: 100.0, y: 200.0, width: 210.0, height: 100.0))

    let tv = UITextView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.


//        let label = UILabel(frame: CGRect(x: 0.0, y: 0.0, width: 300.0, height: 100.0))
//        label.numberOfLines = 0
//        label.lineBreakMode = .ByWordWrapping
//        label.text = "I am happy for beer because food is tasty shrimp."
//
//        let label2 = UILabel(frame: CGRect(x: 10.0, y: 150.0, width: 300.0, height: 100.0))
//        label2.attributedText = NSAttributedString(string: "Hello this is an attrbuted string with a great big grin and house in the sky.")
//        label2.numberOfLines = 0
//        label2.lineBreakMode = .ByWordWrapping


        tf.backgroundColor = UIColor.greenColor()
        tf.startEmojifying()

        tv.startEmojifying()
        tv.backgroundColor = UIColor.lightTextColor()

        tv.text = "hello"

        view.addSubview(tf)
        view.addSubview(tv)

//        dispatch_after(dispatch_time_t(3000.0), dispatch_get_main_queue()) { () -> Void in
//            label.emojify()
//            label2.emojify()
//        }


    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)

        tf.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

