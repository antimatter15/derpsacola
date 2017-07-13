import Cocoa

open class App: Object {
  
  open var pid: pid_t {
    var pid: pid_t = 0
    AXUIElementGetPid(element, &pid)
    
    return pid
  }
  
  open var app: NSRunningApplication? {
    return NSRunningApplication(processIdentifier: pid)
  }
  
  public convenience init(_ app: NSRunningApplication) {
    self.init(AXUIElementCreateApplication(app.processIdentifier))
  }
  
  public convenience init(_ pid: pid_t) {
    self.init(AXUIElementCreateApplication(pid))
  }
  
  open class func allApps() -> [App] {
    return (NSWorkspace.shared().runningApplications as [NSRunningApplication]).map{ App($0) }
  }
  
  open class func focusedApp() -> App? {
    return App(systemWideElement.getAttribute("AXFocusedApplication"))
  }
  
  open func mainWindow() -> Window? {
    return Window(element.getAttribute("AXMainWindow"))
  }
  
  open func focusedWindow() -> Window? {
    return Window(element.getAttribute(NSAccessibilityFocusedWindowAttribute))
  }
  
  open func allWindows() -> [Window]? {
    return (element.getAttributes("AXWindows") as [AXUIElement]?)?.map{ Window($0) }
  }
  
  open override func title() -> String? {
    return app?.localizedName
  }
  
  open func activate(_ allWindows: Bool) -> Bool? {
    var opts = NSApplicationActivationOptions.activateIgnoringOtherApps
    if allWindows {
      opts = .activateAllWindows
    }
    return app?.activate(options: opts)
  }
  
  open func isHidden() -> Bool? {
    return element.getAttribute(NSAccessibilityHiddenAttribute)
  }
  
  open func terminate(_ force: Bool = false) -> Bool? {
    return force ? app?.forceTerminate() : app?.terminate()
  }
  
  open func hide() -> Bool? {
    return element.setAttribute(NSAccessibilityHiddenAttribute, value: true as AnyObject)
  }
  
  open func unhide() -> Bool? {
    return element.setAttribute(NSAccessibilityHiddenAttribute, value: false as AnyObject)
  }
  
}
