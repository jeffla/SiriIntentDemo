//
//  UsageView.swift
//  IntentKit
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

public class UsageView: UIView {
    private let contentView = UIView()
    private let barBack = UIView()
    private let barFront = UIView()
    private let maxLabel = UILabel()
    private let usedLabel = UILabel()
    private var wiper: NSLayoutConstraint!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setUpSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    public func update(_ max: Int, _ used: Int) {
        if max == 0 {
            return
        }
        self.layoutIfNeeded()
        let percent = CGFloat(used)/CGFloat(max)
        wiper.constant = barBack.frame.width * percent + 8
        maxLabel.text = "\(max)"
        usedLabel.text = "\(used)"
        UIView.animate(withDuration: 0.9) { [weak self] in
            self?.layoutIfNeeded()
        }
    }
}

private extension UsageView {
    func setUpSubViews() {
        contentView.backgroundColor = UIColor.white
        addSubview(contentView)
        
        barBack.backgroundColor = UIColor(red:  232/255, green: 232/255, blue: 232/255, alpha: 1)
        contentView.addSubview(barBack)

        barFront.backgroundColor = UIColor(red:  129/255, green: 159/255, blue: 247/255, alpha: 1)
        contentView.addSubview(barFront)

        maxLabel.text = "100"
        maxLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        maxLabel.textColor = UIColor(red:  32/255, green: 32/255, blue: 32/255, alpha: 1)
        maxLabel.textAlignment = .right
        contentView.addSubview(maxLabel)

        usedLabel.text = "0"
        usedLabel.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        usedLabel.textColor = UIColor(red:  69/255, green: 80/255, blue: 81/255, alpha: 1)
        contentView.addSubview(usedLabel)
        
        addConstraints()
    }
    
    func addConstraints() {
        contentView.translatesAutoresizingMaskIntoConstraints = false
        barBack.translatesAutoresizingMaskIntoConstraints = false
        barFront.translatesAutoresizingMaskIntoConstraints = false
        usedLabel.translatesAutoresizingMaskIntoConstraints = false
        maxLabel.translatesAutoresizingMaskIntoConstraints = false
        wiper = NSLayoutConstraint(item: barFront, attribute: .trailing, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 8)

        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            barBack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            contentView.trailingAnchor.constraint(equalTo: barBack.trailingAnchor, constant: 8),
            barBack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            contentView.bottomAnchor.constraint(equalTo: barBack.bottomAnchor, constant: 30),
            
            barFront.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            wiper,
            barFront.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            contentView.bottomAnchor.constraint(equalTo: barFront.bottomAnchor, constant: 30),
            
            usedLabel.topAnchor.constraint(equalTo: barBack.bottomAnchor, constant: 2),
            contentView.bottomAnchor.constraint(equalTo: usedLabel.bottomAnchor),
            usedLabel.widthAnchor.constraint(greaterThanOrEqualToConstant: 10),
            usedLabel.centerXAnchor.constraint(lessThanOrEqualTo: barFront.trailingAnchor),

            maxLabel.leadingAnchor.constraint(lessThanOrEqualTo: barBack.trailingAnchor),
            contentView.trailingAnchor.constraint(equalTo: maxLabel.trailingAnchor, constant: 2),
            maxLabel.topAnchor.constraint(equalTo: barBack.bottomAnchor, constant: 2),
            contentView.bottomAnchor.constraint(equalTo: maxLabel.bottomAnchor),
            maxLabel.leadingAnchor.constraint(greaterThanOrEqualTo: usedLabel.trailingAnchor, constant: 2),

            contentView.heightAnchor.constraint(equalToConstant: 85),
            ])
    }
}
