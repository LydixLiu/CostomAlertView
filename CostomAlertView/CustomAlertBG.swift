//
//  CustomAlertBG.swift
//  CostomAlertView
//
//  Created by Lydix-Liu on 15/7/22.
//  Copyright (c) 2015年 某隻. All rights reserved.
//

import Foundation
import UIKit

public class CustomAlertBG: UIWindow, UIGestureRecognizerDelegate {
    
    private var preWindow: UIWindow?
    private var tapGesture: UITapGestureRecognizer?
    private var currentAlpha: CGFloat?
    private var waitingQueue: NSMutableArray?
    private var showingView: UIView?
    private var showingAlert:CustomAlertView?
    private var showingSheet:CustomActionSheet?
    
    /// 单例
    class var shareInstance: CustomAlertBG {
        struct Static {
            static var instance: CustomAlertBG?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            Static.instance = CustomAlertBG(frame: UIScreen.mainScreen().bounds)
        }
        
        return Static.instance!
    }
    
    /**
    显示控件到window
    
    :param: obj 控件
    */
    public func show(obj: AnyObject) {
        if showingView != nil {
            if waitingQueue == nil {
                waitingQueue = NSMutableArray()
            }
            waitingQueue?.addObject(obj)
            return
        }
        
        if self.currentAlpha == nil {
            self.currentAlpha = 0
        }
        
        for view in self.subviews {
            view.removeFromSuperview()
        }
        
        self.preWindow = UIApplication.sharedApplication().keyWindow
        showingView = obj.view;
        
        self.addSubview(showingView!)
        self.userInteractionEnabled = true
        
        tapGesture = UITapGestureRecognizer(target: self, action: "handleGestureEvent:")
        tapGesture?.delegate = self
        self.addGestureRecognizer(tapGesture!);
        
        self.alpha = self.currentAlpha!
        showingView?.alpha = 0
        showingView?.center = self.center
        self.preWindow?.userInteractionEnabled = false
        self.userInteractionEnabled = true
        if obj.isKindOfClass(CustomAlertView) {
            showingAlert = obj as? CustomAlertView
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.showingView?.alpha = 1
                self.alpha = 1
            })
        } else {
            showingSheet = obj as? CustomActionSheet
            var frame = showingView!.frame
            frame.origin.y = (UIScreen.mainScreen()).bounds.size.height - frame.size.height - 5;
            showingView!.alpha = 1
            self.alpha = 1
            
            UIView .animateWithDuration(0.2, animations: { () -> Void in
                showingView?.frame = frame
            })
        }
        
        self.makeKeyAndVisible()
    }
    
    /**
    移除控件
    
    :param: obj 控件
    */
    public func dismiss(obj: AnyObject) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            if obj.isKindOfClass(CustomAlertView) {
                self.showingView?.alpha = 0
            } else {
                var frame = self.showingView?.frame
                frame?.origin.y = UIScreen.mainScreen().bounds.size.height
                self.showingView?.frame = frame!
            }
            if self.waitingQueue?.count > 0 {
                self.alpha = 1
            } else {
                self.alpha = 0
            }
            
        }) { (Bool) -> Void in
            self.showingView?.removeFromSuperview()
            self.showingView = nil
            self.showingAlert = nil
            self.showingSheet = nil
            
            if self.waitingQueue?.count > 0 {
                self.currentAlpha = 1
                let nextObj: AnyObject? = self.waitingQueue?.lastObject
                self.show(nextObj!)
                self.waitingQueue?.removeLastObject()
            } else {
                self.reduceAlphaIfEmty()
                self.preWindow?.userInteractionEnabled = true
                self.preWindow?.makeKeyAndVisible()
            }
        }
    }
    
    /**
    控制alpha值
    */
    private func reduceAlphaIfEmty() {
        if self.subviews.count == 0 {
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.alpha = 0
                self.userInteractionEnabled = false
            })
            currentAlpha = 0
            self.cleanSelf()
        }
    }
    
    /**
    手势操作
    
    :param: gesture 手势
    */
    private func handleGestureEvent(gesture:UITapGestureRecognizer) {
        if (showingAlert != nil) {
            if (showingAlert?.tapToDismiss == true) {
                self.dismiss(showingAlert!)
            } else {
                showingAlert?.hideKeyBoard()
            }
        } else {
            self.dismiss(showingSheet!)
        }
    }
    
    /**
    清理内存
    */
    private func cleanSelf() {
        if waitingQueue != nil && waitingQueue?.count > 0 {
            self.waitingQueue?.removeAllObjects()
            self.waitingQueue = nil
        }
        showingAlert = nil;
        showingSheet = nil;
        showingView = nil;
        tapGesture = nil
    }
}