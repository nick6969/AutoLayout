//
//  AutoLayout.swift
//  scrollViewAutoLayout
//
//  Created by nick on 2016/12/3.
//  Copyright © 2016年 nick. All rights reserved.
//

import UIKit

// 自己建立的簡單的使用 AutoLayout
extension UIView{
    
    func mLay(_ attribute:NSLayoutAttribute,_ relatedBy:NSLayoutRelation,_ toItem:Any?,_ attribute1:NSLayoutAttribute , multiplier: CGFloat , constant: CGFloat)->NSLayoutConstraint{
        self.translatesAutoresizingMaskIntoConstraints = false
        return NSLayoutConstraint(item: self, attribute: attribute, relatedBy: relatedBy, toItem: toItem, attribute: attribute1, multiplier: multiplier, constant: constant)
    }
    
    func mLay(_ attribute:NSLayoutAttribute,_ relatedBy:NSLayoutRelation,_ toItem:Any?)->NSLayoutConstraint{
        return mLay(attribute, relatedBy, toItem, attribute, multiplier:1, constant:0)
    }
    
    func mLay(_ attribute:NSLayoutAttribute,_ constant: CGFloat)->NSLayoutConstraint{
        return mLay(attribute, .equal, nil, attribute,multiplier: 1, constant:constant)
    }
    
    func mLay(_ attribute:NSLayoutAttribute,_ relatedBy:NSLayoutRelation,_ toItem:Any?, multiplier: CGFloat, constant: CGFloat)->NSLayoutConstraint{
        return mLay(attribute, relatedBy , toItem, attribute, multiplier:multiplier, constant:constant)
    }
    
    func mLay(_ attribute:NSLayoutAttribute,_ relatedBy:NSLayoutRelation,_ toItem:Any?,  constant: CGFloat)->NSLayoutConstraint{
        return mLay(attribute, relatedBy , toItem, attribute, multiplier:1, constant:constant)
    }
    
    func mLay(_ attribute:NSLayoutAttribute,_ relatedBy:NSLayoutRelation,_ toItem:Any?,_ attribute1:NSLayoutAttribute ,constant: CGFloat)->NSLayoutConstraint{
        return mLay(attribute, relatedBy , toItem, attribute1, multiplier:1, constant:constant)
    }
    
}

