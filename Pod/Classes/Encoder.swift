//
//  Encoder.swift
//  Gloss
//
// Copyright (c) 2015 Harlan Kellaway
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
//

public struct Encoder {
    
    /**
    Returns function to encode value to JSON
    
    :param: key Key used to create JSON property
    
    :returns: Function decoding value to JSON
    */
    public static func encode<T>(key: String) -> T? -> JSON? {
        return {
            object in
            
            if let object = object {
                
                return [key : object as! AnyObject]
            }
            
            return nil
        }
    }
    
    /**
    Returns function to encode value to JSON
    for objects the conform to the Encodable protocol
    
    :param: key Key used to create JSON property
    
    :returns: Function decoding value to JSON
    */
    public static func encode<T: Encodable>(key: String) -> T? -> JSON? {
        return {
            object in
            
            if let object = object {
                return [key : object.toJSON()]
            }
            
            return nil
        }
    }
    
    // MARK: - Custom Encoders
    
    /**
    Returns function to encode date as JSON
    
    :param: key           Key used to create JSON property
    :param: dateFormatter Formatter used to format date string
    
    :returns: Function encoding date as JSON
    */
    public static func encodeDate(key: String, dateFormatter: NSDateFormatter) -> NSDate? -> JSON? {
        return {
            date in
            
            if let d = date {
                return [key : dateFormatter.stringFromDate(d)]
            }
            
            return nil
        }
    }
    
    /**
    Returns function to encode ISO8601 date as JSON
    
    :param: key           Key used to create JSON property
    :param: dateFormatter Formatter used to format date string
    
    :returns: Function encoding ISO8601 date as JSON
    */
    public static func encodeDateISO8601(key: String, dateFormatter: NSDateFormatter) -> NSDate -> JSON? {
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        return Encoder.encodeDate(key, dateFormatter: dateFormatter)
    }
    
    /**
    Returns function to encode enum value as JSON
    
    :param: key Key used to create JSON property
    
    :returns: Function encoding enum value as JSON
    */
    public static func encodeEnum<T: RawRepresentable>(key: String) -> T? -> JSON? {
        return {
            enumValue in
            
            if let e = enumValue {
                return [key : e.rawValue as! AnyObject]
            }
            
            return nil
        }
    }
    
    /**
    Returns function to encode URL as JSON
    
    :param: key Key used to create JSON property
    
    :returns: Function encoding URL as JSON
    */
    public static func encodeURL(key: String) -> NSURL? -> JSON? {
        return {
            url in
            
            if let u = url {
                return [key : u.absoluteString!]
            }
            
            return nil
        }
    }
    
}
