//
//  StringUtil.swift
//  KLibrary
//
//  Created by KO on 2015/09/28.
//  Copyright (c) 2015年 KO. All rights reserved.
//

import Foundation

public class StringUtil {
  public static let prefectureDivider = NSCharacterSet(charactersInString: "都道府県")
  
  public static func removePrefevtureFromAddress(address: String) -> String {
    let nsAddress = address as NSString
    let range = nsAddress.rangeOfCharacterFromSet(prefectureDivider)
    if range.location == NSNotFound {
      return address
    }
    for var i = range.location + 1; i < nsAddress.length; i++ {
      let char = nsAddress.characterAtIndex(i)
      if !prefectureDivider.characterIsMember(char) {
        return String(nsAddress.substringFromIndex(i))
      }
    }
    return ""
  }
}
