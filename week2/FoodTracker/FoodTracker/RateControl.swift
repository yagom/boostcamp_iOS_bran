//
//  RateControl.swift
//  FoodTracker
//
//  Created by JU HO YOON on 2017. 7. 7..
//  Copyright © 2017년 YJH Studio. All rights reserved.
//

import UIKit

@IBDesignable
class RateControl: UIStackView {
    
    @IBInspectable var starSize: CGSize = CGSize(width: 44, height: 44) {
        didSet {
            self.setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            self.setupButtons()
        }
    }
    
    private var ratingButtons = [UIButton]()
    var rating = 0 {
        didSet {
            self.updateButtonSelectionStates()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupButtons()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        self.setupButtons()
    }
    
    private func setupButtons() {
        
        for button in self.ratingButtons {
            self.removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        self.ratingButtons.removeAll()
        
        let bundle = Bundle(for: type(of: self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let highlightedStar = UIImage(named: "highlightedStar", in: bundle, compatibleWith: self.traitCollection)
        
        for index in 0 ..< self.starCount {
            let button = UIButton()
            
            button.setImage(emptyStar, for: .normal)
            button.setImage(filledStar, for: .selected)
            button.setImage(highlightedStar, for: .highlighted)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.widthAnchor.constraint(equalToConstant: self.starSize.width).isActive = true
            button.heightAnchor.constraint(equalToConstant: self.starSize.height).isActive = true
            
            button.addTarget(self, action: #selector(self.ratingButtonTapped(sender:)), for: .touchUpInside)
            
            button.accessibilityLabel = "Set \(index + 1) star rating"
            
            self.addArrangedSubview(button)
            self.ratingButtons.append(button)
        }
        
        self.updateButtonSelectionStates()
    }
    
    func ratingButtonTapped(sender: UIButton) {
        guard let index = self.ratingButtons.index(of: sender)
            else {
                fatalError("The button, \(sender), is not in the ratingButtons array: \(ratingButtons)")
        }
        let selectedRating = index + 1
        if selectedRating == self.rating {
            self.rating = 0
        } else {
            self.rating = selectedRating
        }
    }
    
    func updateButtonSelectionStates() {
        for (index, button) in self.ratingButtons.enumerated() {
            button.isSelected = (index < self.rating)
            
            var hintString: String?
            if rating == index + 1 {
                hintString = "Tap to reset the rating to zero"
            } else {
                hintString = nil
            }
            
            let valueString: String
            switch (self.rating) {
            case 0:
                valueString = "No rating set"
            case 1:
                valueString = "1 star set."
            default:
                valueString = "\(self.rating) star set."
            }
            
            button.accessibilityHint = hintString
            button.accessibilityValue = valueString
        }
    }

}
