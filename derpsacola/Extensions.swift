import Foundation

public extension AXUIElement {
  
  public func getAttribute<T>(_ property: String) -> T? {
    var ptr: CFTypeRef?
    if AXUIElementCopyAttributeValue(self, property as CFString, &ptr) != AXError.success { return nil }
    return ptr.map { $0 as! T }
  }
  
  public func getAttributes<T: AnyObject>(_ property: String) -> [T]? {
    var count: CFIndex = 0
    if AXUIElementGetAttributeValueCount(self, property as CFString, &count) != AXError.success { return nil }
    if count == 0 { return [T]() }
    
    var ptr: CFArray?
    if AXUIElementCopyAttributeValues(self, property as CFString, 0, count, &ptr) != AXError.success { return nil }
    if ptr == nil { return nil }
    
    let array: Array<AnyObject>? = ptr as! Array<AnyObject>
    if array == nil { return nil }
    return array as? [T]
  }
  
  public func getAttributeNames() -> [String]? {
    var ptr: CFArray?
    AXUIElementCopyAttributeNames(self, &ptr)
    return ptr as? [String]
  }
  
  public func setAttribute<T: AnyObject>(_ property: String, value: T) -> Bool {
    return AXUIElementSetAttributeValue(self, property as CFString, value) != AXError.success
  }
  
  public subscript(property: String) -> AnyObject? {
    get { return getAttribute(property) as AnyObject? }
    set { setAttribute(property, value: newValue!) }
  }
  
}

public extension AXValue {
  
  public class func fromPoint(_ p: CGPoint) -> AXValue {
    var p = p
    return AXValueCreate(AXValueType(rawValue: kAXValueCGPointType)!, &p).unsafelyUnwrapped
  }
  
  public class func fromSize(_ p: CGSize) -> AXValue {
    var p = p
    return AXValueCreate(AXValueType(rawValue: kAXValueCGSizeType)!, &p).unsafelyUnwrapped
  }
  
  public class func fromRect(_ p: CGRect) -> AXValue {
    var p = p
    return AXValueCreate(AXValueType(rawValue: kAXValueCGRectType)!, &p).unsafelyUnwrapped
  }
  
  public class func fromRange(_ p: CFRange) -> AXValue {
    var p = p
    return AXValueCreate(AXValueType(rawValue: kAXValueCFRangeType)!, &p).unsafelyUnwrapped
  }
  
  public func convertToStruct<T>() -> T? {
    let ptr = UnsafeMutablePointer<T>.allocate(capacity: 1)
    let success = AXValueGetValue(self, AXValueGetType(self), ptr)
    let val = ptr.pointee
    ptr.deinitialize()
    guard success else {
      return nil
    }
    return val
  }
  
}
