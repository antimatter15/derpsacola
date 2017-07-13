

import Cocoa

let systemWideElement = AXUIElementCreateSystemWide()

open class Object: Equatable {
  
  open var element: AXUIElement!
  
  public init?(_ el: AXUIElement?) {
    if el == nil { return nil }
    element = el
  }
  
  public init(_ el: AXUIElement) { element = el }
  
  open func title() -> String? {
    return element.getAttribute(NSAccessibilityTitleAttribute)
  }
  
  internal func subrole() -> String? {
    return element.getAttribute(NSAccessibilitySubroleAttribute)
  }
  
  internal func role() -> String? {
    return element.getAttribute(NSAccessibilityRoleAttribute)
  }
  
}

public func ==(left: Object, right: Object) -> Bool {
  return CFEqual(left.element, right.element)
}
