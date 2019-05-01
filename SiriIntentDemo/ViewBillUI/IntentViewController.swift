//
//  IntentViewController.swift
//  ViewBillUI
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

import IntentsUI
import IntentKit
import os.log

class IntentViewController: UIViewController, INUIHostedViewControlling {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureView(for parameters: Set<INParameter>, of interaction: INInteraction, interactiveBehavior: INUIInteractiveBehavior, context: INUIHostedViewContext, completion: @escaping (Bool, Set<INParameter>, CGSize) -> Void) {
        
        os_log("TK421: %{public}s", "\(#function)")

        if interaction.intentHandlingStatus == .success {
            os_log("TK421: intentHandlingStatus == .success")
            if let _ = interaction.intentResponse as? ViewMyBillIntentResponse {
                
                os_log("TK421: inside ViewMyBillIntentResponse")
                let billView = BillView()
                view.addSubview(billView)
                billView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    billView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: billView.trailingAnchor),
                    billView.topAnchor.constraint(equalTo: view.topAnchor),
                    ])
                billView.setNeedsLayout()
                billView.layoutIfNeeded()
                completion(true, parameters, CGSize(width: desiredSize.width, height: billView.frame.height))
                return
            }

            if let response = interaction.intentResponse as? ViewMyUsageIntentResponse {
                
                os_log("TK421: inside ViewMyBillIntentResponse")
                let usageView = UsageView()
                view.addSubview(usageView)
                usageView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    usageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: usageView.trailingAnchor),
                    usageView.topAnchor.constraint(equalTo: view.topAnchor),
                    ])
                usageView.update(response.maxData?.intValue ?? 30, response.usedData?.intValue ?? 20)
                completion(true, parameters, CGSize(width: desiredSize.width, height: usageView.frame.height))
                return
            }
        }
        
        if interaction.intentHandlingStatus == .ready {
            if let response = interaction.intentResponse as? PayMyBillIntentResponse {
                
                os_log("TK421: inside PayMyBillIntentResponse")
                response.amount = "$34.56"
                let billView = BillView()
                view.addSubview(billView)
                billView.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint.activate([
                    billView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                    view.trailingAnchor.constraint(equalTo: billView.trailingAnchor),
                    billView.topAnchor.constraint(equalTo: view.topAnchor),
                    ])
                billView.setNeedsLayout()
                billView.layoutIfNeeded()
                completion(true, parameters, CGSize(width: desiredSize.width, height: billView.frame.height))
                return
            }
        }

        completion(false, parameters, self.desiredSize)
    }
    
    var desiredSize: CGSize {
        return self.extensionContext!.hostedViewMaximumAllowedSize
    }
    
}

extension IntentViewController: INUIHostedViewSiriProviding {
    var displaysMessage: Bool {
        os_log("TK421: %{public}s", "\(#function)")
        return true
    }
    
    var displaysMap: Bool {
        os_log("TK421: %{public}s", "\(#function)")
        return false
    }
    
    var displaysPaymentTransaction: Bool {
        os_log("TK421: %{public}s", "\(#function)")
        return false
    }
}
