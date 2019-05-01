//
//  BillViewController.swift
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
import IntentsUI
import os.log

class BillViewController: UIViewController {
    private let container = UIView()
    private let billView = BillView()
    private let button = UIButton()
    private let activity: NSUserActivity?

    init(_ activity: NSUserActivity?) {
        self.activity = activity
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSubviews()
    }
    

}

private extension BillViewController {
    @objc func addSiriShortcutButtonPressed(_ sender: UIButton) {
        
        guard let shortcut = INShortcut(intent: ViewMyBillIntent()) else {
            return
        }
        let viewController = INUIAddVoiceShortcutViewController(shortcut: shortcut)
        viewController.delegate = self
        present(viewController, animated: true, completion: nil)
    }
    
    func setUpSubviews() {
        view.backgroundColor = UIColor.white
        title = "Billing"
        view.addSubview(container)
        
        button.setTitle("Add Shortcut to Siri", for: .normal)
        button.addTarget(self, action: #selector(addSiriShortcutButtonPressed(_:)), for: .touchUpInside)
        button.setTitleColor(UIColor.blue, for: .normal)
        view.addSubview(button)
        
        container.addSubview(billView)
        
        addConstraints()
    }
    
    func addConstraints() {
        container.translatesAutoresizingMaskIntoConstraints = false
        billView.translatesAutoresizingMaskIntoConstraints = false
        button.translatesAutoresizingMaskIntoConstraints = false
        let guide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            container.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            guide.trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: 10),
            container.topAnchor.constraint(equalTo: guide.topAnchor, constant: 10),
            
            billView.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            container.trailingAnchor.constraint(equalTo: billView.trailingAnchor),
            billView.topAnchor.constraint(equalTo: container.topAnchor),
            container.bottomAnchor.constraint(equalTo: billView.bottomAnchor),
            
            button.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 10),
            guide.trailingAnchor.constraint(equalTo: button.trailingAnchor, constant: 10),
            button.topAnchor.constraint(equalTo: container.bottomAnchor, constant: 10),
            button.heightAnchor.constraint(equalToConstant: 44),
            ])
        
    }
}

extension BillViewController: INUIAddVoiceShortcutButtonDelegate {
    
    func present(_ addVoiceShortcutViewController: INUIAddVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        addVoiceShortcutViewController.delegate = self
        present(addVoiceShortcutViewController, animated: true, completion: nil)
    }
    
    func present(_ editVoiceShortcutViewController: INUIEditVoiceShortcutViewController, for addVoiceShortcutButton: INUIAddVoiceShortcutButton) {
        editVoiceShortcutViewController.delegate = self
        present(editVoiceShortcutViewController, animated: true, completion: nil)
    }
}

extension BillViewController: INUIAddVoiceShortcutViewControllerDelegate {
    func addVoiceShortcutViewController(_ controller: INUIAddVoiceShortcutViewController, didFinishWith voiceShortcut: INVoiceShortcut?, error: Error?) {
        if let error = error as NSError? {
            os_log("Error adding voice shortcut: %@", log: OSLog.default, type: .error, error)
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addVoiceShortcutViewControllerDidCancel(_ controller: INUIAddVoiceShortcutViewController) {
        dismiss(animated: true, completion: nil)
    }
}

extension BillViewController: INUIEditVoiceShortcutViewControllerDelegate {
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didUpdate voiceShortcut: INVoiceShortcut?,
                                         error: Error?) {
        if let error = error as NSError? {
            os_log("Error adding voice shortcut: %@", log: OSLog.default, type: .error, error)
        }
        
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewController(_ controller: INUIEditVoiceShortcutViewController,
                                         didDeleteVoiceShortcutWithIdentifier deletedVoiceShortcutIdentifier: UUID) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func editVoiceShortcutViewControllerDidCancel(_ controller: INUIEditVoiceShortcutViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
}

