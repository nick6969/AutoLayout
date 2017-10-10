//
//  AutoLayout.swift
//  scrollViewAutoLayout
//
//  Created by nick on 2016/12/3.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

public struct OptionalEdge {
    public var top: CGFloat?
    public var left: CGFloat?
    public var bottom: CGFloat?
    public var right: CGFloat?
    public init(top: CGFloat? = nil, left: CGFloat? = nil, bottom: CGFloat? = nil, right: CGFloat? = nil) {
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}

extension UIView {
    
    @discardableResult func mLay( _ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, _ attribute1: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat, active: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let layout = NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: attribute1, multiplier: multiplier, constant: constant)
        layout.isActive = active
        return layout
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, active: Bool = true) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: 0, active: active)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ constant: CGFloat, active: Bool = true) -> NSLayoutConstraint {
        return mLay(attribute, .equal, nil, attribute, multiplier: 1, constant: constant, active: active)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, multiplier: CGFloat, constant: CGFloat, active: Bool = true) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: multiplier, constant: constant, active: active)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, constant: CGFloat, active: Bool = true) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: constant, active: active)
    }
    
    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, _ attribute1: NSLayoutAttribute, constant: CGFloat, active: Bool = true) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute1, multiplier: 1, constant: constant, active: active)
    }
    
    @discardableResult func mLay(pin: UIEdgeInsets, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        return [  mLay(.top, .equal, view ?? superview!, constant: pin.top    ),
                  mLay(.left, .equal, view ?? superview!, constant: pin.left ),
                  mLay(.bottom, .equal, view ?? superview!, constant: -pin.bottom ),
                  mLay(.right, .equal, view ?? superview!, constant: -pin.right  )]
    }
    
    @discardableResult func mLayEqualSuper() -> [NSLayoutConstraint] {
        return mLay(pin: .zero)
    }
    
    @discardableResult func mLay(pin: OptionalEdge, to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        var arr: [NSLayoutConstraint] = []
        if let top    = pin.top {  arr.append( mLay(.top, .equal, view ?? superview!, constant: top    ) ) }
        if let left   = pin.left {  arr.append( mLay(.left, .equal, view ?? superview!, constant: left   ) ) }
        if let bottom = pin.bottom {  arr.append( mLay(.bottom, .equal, view ?? superview!, constant: -bottom ) ) }
        if let right  = pin.right {  arr.append( mLay(.right, .equal, view ?? superview!, constant: -right  ) ) }
        return arr
    }
    
    @discardableResult func mLayCenterXY(to view: UIView? = nil) -> [NSLayoutConstraint] {
        assert(view != nil || superview != nil, "can't add Constraint to nil , superview and parmater view is nil")
        return [ mLay(.centerY, .equal, view ?? superview! ),
                 mLay(.centerX, .equal, view ?? superview! )]
    }
    
    @discardableResult func mLay(size: CGSize) -> [NSLayoutConstraint] {
        return [ mLay( .height, size.height), mLay( .width, size.width)]
    }
    
}

extension NSLayoutConstraint {
    
    @discardableResult func priority(_ pri: UILayoutPriority) -> NSLayoutConstraint {
        self.priority = pri
        return self
    }
    
}
