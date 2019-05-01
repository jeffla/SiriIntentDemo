//
//  ViewController.swift
//  SiriIntentDemo
//
//  MIT License
//
//  Copyright (c) 2019 Jeff Lacey
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

import UIKit
import IntentKit
import Intents
import os.log

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "You're Awesome!"
    }
    
    @IBAction func didPressViewMyBill(_ sender: Any) {
        navigateToBillingScreen(nil)
    }
    
    @IBAction func didPressViewMyUsage(_ sender: Any) {
        navigateToUsageScreen(nil)
    }
    
    @IBAction func didPressPayMyBill(_ sender: Any) {
        navigateToPaymentScreen(nil)
    }
    
    func navigateToBillingScreen(_ activity: NSUserActivity?) {
        let viewController = BillViewController(activity)
        navigationController?.popToRootViewController(animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToPaymentScreen(_ activity: NSUserActivity?) {
        let viewController = PayBillViewController(activity)
        navigationController?.popToRootViewController(animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func navigateToUsageScreen(_ activity: NSUserActivity?) {
        let viewController = UsageViewController(activity)
        navigationController?.popToRootViewController(animated: false)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    override func restoreUserActivityState(_ activity: NSUserActivity) {
        os_log("TK421: %{public}s", "\(#function)")
        super.restoreUserActivityState(activity)
        
        if activity.activityType == NSUserActivity.viewMyBillActivityType {
            navigateToBillingScreen(activity)
        } else if activity.activityType == NSStringFromClass(ViewMyBillIntent.self) {
            navigateToBillingScreen(activity)
        } else if activity.activityType == NSStringFromClass(PayMyBillIntent.self) {
            navigateToPaymentScreen(activity)
        } else if activity.activityType == NSStringFromClass(ViewMyUsageIntent.self) {
            navigateToUsageScreen(activity)
        }
    }
}

