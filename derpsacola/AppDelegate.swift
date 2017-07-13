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
  
  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
    for app in App.allApps() {
      if app.isHidden() != false { continue }
      print(app.title() ?? "No Title Found");
      for win in app.allWindows()! {
        print("---");
        print(win.title() ?? "Window has no title")
        for name in win.element.getAttributeNames()! {
          print("\t", name, win.element.getAttribute(name) as CFTypeRef? ?? "Couldn't get attribute for \(name)")
        }
      }
    }
  }
  
  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }
  
  
  func oldUnusedCode(){
    //
    //        let systemWideElement : AXUIElement = AXUIElementCreateSystemWide().takeRetainedValue()
    //
    //        var elPtr = UnsafeMutablePointer<Unmanaged<AXUIElement>?>.allocate(capacity: 1)
    //        let error = AXUIElementCopyElementAtPosition(systemWideElement, 656.843750, 849.500000, elPtr)
    //
    //        if error == AXError.success.rawValue {
    //            print("woot")
    //
    //
    //        }
    //        print(elPtr)
    //
    //        for name in systemWideElement.getAttributeNames()! {
    //            print(name, systemWideElement.getAttribute(name) as CFTypeRef?);
    //        }
    //
    //        print("----------------");
    //
    //        //        systemWideElement.getAttributes()
    //
    //        let focusedApp : AXUIElement = systemWideElement.getAttribute("AXFocusedApplication")!;
    //        //        let focusedApp = elPtr.memory!.takeRetainedValue();
    //
    //
    //        for name in focusedApp.getAttributeNames()! {
    //            print(name);
    //            if(name == NSAccessibilityChildrenAttribute){
    //                print("!!!!!!!!omg children");
    //
    //            }
    //            let t:CFTypeRef? = focusedApp.getAttribute(name);
    //            //            switch AXValueGetType(t) {
    //            //            case AXUIElementGetTypeID():
    //            //                print("ui el")
    //            //
    //            //            }
    //            if(t != nil){
    //                if(CFGetTypeID(t) == AXUIElementGetTypeID()){
    //                    print("----ui el");
    //                }else if(CFGetTypeID(t) == CFArrayGetTypeID()){
    //                    print("----array", t);
    //                }else{
    //                    print("----", t);
    //                }
    //            }else{
    //                print("0000 nil");
    //            }
    //
    //        }
    //
  }
  
}

