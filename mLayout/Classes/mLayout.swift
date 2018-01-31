//
//  mLayout.Swift
//
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

    @discardableResult func mLay( _ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, _ attribute1: NSLayoutAttribute, multiplier: CGFloat, constant: CGFloat, active: Bool = true, priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        let layout =  NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: attribute1, multiplier: multiplier, constant: constant)
        layout.priority = priority
        layout.isActive = active
        return layout
    }

    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, active: Bool = true, priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: 0, active: active, priority: priority)
    }

    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ constant: CGFloat, active: Bool = true, priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, .equal, nil, attribute, multiplier: 1, constant: constant, active: active, priority: priority)
    }

    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, multiplier: CGFloat, constant: CGFloat, active: Bool = true, priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: multiplier, constant: constant, active: active, priority: priority)
    }

    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, constant: CGFloat, active: Bool = true, priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute, multiplier: 1, constant: constant, active: active, priority: priority)
    }

    @discardableResult func mLay(_ attribute: NSLayoutAttribute, _ relatedBy: NSLayoutRelation, _ toItem: Any?, _ attribute1: NSLayoutAttribute, constant: CGFloat, active: Bool = true, priority: UILayoutPriority = .init(1000)) -> NSLayoutConstraint {
        return mLay(attribute, relatedBy, toItem, attribute1, multiplier: 1, constant: constant, active: active, priority: priority)
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

extension UIView {
    enum mLayDirection {
        case top
        case left
        case bottom
        case right

        func getLayoutAttribute() -> NSLayoutAttribute {
            switch self {
            case .top: return .top
            case .left: return .left
            case .bottom: return .bottom
            case .right: return .right
            }
        }
    }

    // Auto Active
    @discardableResult func mLayEqualSafeArea(with item: UIView, direction: mLayDirection, constant: CGFloat = 0, active: Bool = true) -> NSLayoutConstraint {
        self.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            switch direction {
            case .top:  return self.topAnchor.constraint(equalTo: item.safeAreaLayoutGuide.topAnchor, constant: constant).active(bool: active)
            case .left: return self.leftAnchor.constraint(equalTo: item.safeAreaLayoutGuide.leftAnchor, constant: constant).active(bool: active)
            case .bottom: return self.bottomAnchor.constraint(equalTo: item.safeAreaLayoutGuide.bottomAnchor, constant: constant).active(bool: active)
            case .right: return self.rightAnchor.constraint(equalTo: item.safeAreaLayoutGuide.rightAnchor, constant: constant).active(bool: active)
            }
        } else {
            let attrib = direction.getLayoutAttribute()
            return NSLayoutConstraint(item: self, attribute: attrib, relatedBy: .equal, toItem: item, attribute: attrib, multiplier: 1, constant: constant).active(bool: active)
        }
    }

}

extension NSLayoutConstraint {
    @discardableResult func active(bool: Bool) -> NSLayoutConstraint {
        self.isActive = bool
        return self
    }
}
