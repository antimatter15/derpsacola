import Cocoa

open class Window: Object {
  
  var winid: Int?
  
  open class func focusedWindow() -> Window? {
    return App.focusedApp()?.focusedWindow()
  }
  
  open class func allWindows() -> [Window] {
    return App.allApps().map{$0.allWindows()!}.reduce([], +)
  }
  
  open func topLeft() -> NSPoint? {
    return (element.getAttribute(NSAccessibilityPositionAttribute) as AXValue?)?.convertToStruct()
  }
  
  open func size() -> NSSize? {
    return (element.getAttribute(NSAccessibilitySizeAttribute) as AXValue?)?.convertToStruct()
  }
  
  open func app() -> App? {
    var pid = pid_t(0)
    
    guard AXUIElementGetPid(self.element, &pid) == AXError.success else {
      return nil
    }
    
    return App(pid)
  }
  
  open func frame() -> NSRect? {
    guard let p = topLeft(), let s = size() else {
      return nil
    }
    return NSRect(origin: p, size: s)
  }
  
  open func setTopLeft(_ p: NSPoint) -> Bool {
    return element.setAttribute(NSAccessibilityPositionAttribute, value: AXValue.fromPoint(p))
  }
  
  open func setSize(_ s: NSSize) -> Bool {
    return element.setAttribute(NSAccessibilitySizeAttribute, value: AXValue.fromSize(s))
  }
  
  open func setFrame(_ f: NSRect) -> Bool {
    return self.setSize(f.size) &&
      self.setTopLeft(f.origin) &&
      self.setSize(f.size)
  }
  
  open func isStandard() -> Bool? {
    return subrole() == "AXStandardWindow"
  }
  //
  //    public func id() -> Int? {
  //        return 42;
  ////        if winid != nil { return winid }
  ////        var id = CGWindowID(0)
  ////        let result = _AXUIElementGetWindow(element, &id)
  ////        if result != AXError(kAXErrorSuccess) { return nil }
  ////        winid = Int(id)
  ////        return winid
  //    }
  
}
