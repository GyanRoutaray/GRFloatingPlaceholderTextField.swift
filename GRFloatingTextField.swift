//
//  GRFloatingTextField.swift
//  JustStuck
//
//  Created by Gyan Routray on 20/01/17.
//  Copyright © 2017 Headerlabs. All rights reserved.
//

import UIKit

@IBDesignable public class GRFloatingTextField: UITextField {
    let textLeftInset = 3.0
    let placeholderLabel = UITextField()
    var pLInitialFrame = CGRect()
    var pLFinalFrame = CGRect()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    @IBInspectable public var place_holder: String?{
        didSet{
            placeholderLabel.text = place_holder
        }
    }
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    public override func draw(_ rect: CGRect) {
        placeholder = ""
        backgroundColor = UIColor.clear
        placeholderLabel.text = place_holder
        pLInitialFrame = placeholderRect(forBounds: bounds)
        
        if let viewSuper = superview {
            pLInitialFrame = convert(pLInitialFrame, to: viewSuper)
            placeholderLabel.frame = pLInitialFrame
            viewSuper.insertSubview(placeholderLabel, belowSubview: self)
        }
        placeholderLabel.textColor = UIColor(red: 0.78, green: 0.78, blue: 0.80, alpha: 1.0)
        placeholderLabel.font = font
        
    }
    
    override public func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: CGFloat(bounds.origin.x) + CGFloat(textLeftInset), y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    override public func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: CGFloat(bounds.origin.x) + CGFloat(textLeftInset), y: bounds.origin.y, width: bounds.width, height: bounds.height)
    }
    
    func animateUp() {
       
      }
    
    func setup() {
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidBeginEditing(notification:)), name: .UITextFieldTextDidBeginEditing, object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidEndEditing(notification:)), name: .UITextFieldTextDidEndEditing, object: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(textFieldDidChange(notification:)), name: .UITextFieldTextDidChange, object: self)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidBeginEditing, object: self)
        NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidEndEditing, object: self)
        NotificationCenter.default.removeObserver(self, name: .UITextFieldTextDidChange, object: self)
    }
    
    func textFieldDidBeginEditing(notification: NSNotification) {
        
     }
    
    func textFieldDidEndEditing(notification: NSNotification) {
        if (text?.characters.count)!<1 {
            let fontsize = (font?.pointSize)!
            let fontName = (font?.fontName)!
            UIView.animate(withDuration: 0.20, animations: {
                self.placeholderLabel.frame = self.pLInitialFrame

            },  completion: { (finished: Bool) in
                self.placeholderLabel.font = UIFont(name: fontName, size: fontsize)
            })
        }
    }
    
    func textFieldDidChange(notification: NSNotification) {
        if (text?.characters.count)!<1 {
            let fontsize = (font?.pointSize)!
            let fontName = (font?.fontName)!
            UIView.animate(withDuration: 0.20, animations: {
                self.placeholderLabel.frame = self.pLInitialFrame
                
            },  completion: { (finished: Bool) in
                self.placeholderLabel.font = UIFont(name: fontName, size: fontsize)
            })
            
        }
        else{
            pLFinalFrame = CGRect(x: pLInitialFrame.origin.x, y: CGFloat(pLInitialFrame.origin.y - pLInitialFrame.size.height/2), width: pLInitialFrame.size.width, height: pLInitialFrame.size.height/1.5)
            let fontsize = (font?.pointSize)!
            let fontName = (font?.fontName)!
            UIView.animate(withDuration: 0.20, animations: {
                self.placeholderLabel.font = UIFont(name: fontName, size: fontsize/1.5)
                self.placeholderLabel.frame = self.pLFinalFrame
            }, completion: nil)

        }
    }


}
