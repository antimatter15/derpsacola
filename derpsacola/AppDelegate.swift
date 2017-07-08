//
//  AppDelegate.swift
//  derpsacola
//
//  Created by Kevin Kwok on 4/5/15.
//  Copyright (c) 2015 Kevin Kwok. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    @IBOutlet weak var window: NSWindow!


    func applicationDidFinishLaunching(aNotification: NSNotification) {
        // Insert code here to initialize your application
        for app in App.allApps() {
            if app.isHidden() != false { continue }
            println(app.title());
            for win in app.allWindows()! {
                print("---");
                println(win.title())
                for name in win.element.getAttributeNames()! {
                    println("\t", name, win.element.getAttribute(name) as CFTypeRef?)
                }
            }
        }
    }

    func applicationWillTerminate(aNotification: NSNotification) {
        // Insert code here to tear down your application
    }

    
    func oldUnusedCode(){
        
        let systemWideElement : AXUIElement = AXUIElementCreateSystemWide().takeRetainedValue()
        
        var elPtr = UnsafeMutablePointer<Unmanaged<AXUIElement>?>.alloc(1)
        let error = AXUIElementCopyElementAtPosition(systemWideElement, 656.843750, 849.500000, elPtr)
        
        if(error == Int32(kAXErrorSuccess)){
            print("woot")
            
            
        }
        println(elPtr)
        
        for name in systemWideElement.getAttributeNames()! {
            println(name, systemWideElement.getAttribute(name) as CFTypeRef?);
        }
        
        println("----------------");
        
        //        systemWideElement.getAttributes(<#property: String#>)
        
        let focusedApp : AXUIElementRef = systemWideElement.getAttribute("AXFocusedApplication")!;
        //        let focusedApp = elPtr.memory!.takeRetainedValue();
        
        
        for name in focusedApp.getAttributeNames()! {
            println(name);
            if(name == NSAccessibilityChildrenAttribute){
                println("!!!!!!!!omg children");
                
            }
            let t:CFTypeRef? = focusedApp.getAttribute(name);
            //            switch AXValueGetType(t) {
            //            case AXUIElementGetTypeID():
            //                println("ui el")
            //
            //            }
            if(t != nil){
                if(CFGetTypeID(t) == AXUIElementGetTypeID()){
                    println("----ui el");
                }else if(CFGetTypeID(t) == CFArrayGetTypeID()){
                    println("----array", t);
                }else{
                    println("----", t);
                }
            }else{
                println("0000 nil");
            }
            
        }

    }

}

