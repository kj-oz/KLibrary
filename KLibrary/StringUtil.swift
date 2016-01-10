//
//  StringUtil.swift
//  KLibrary
//
//  Created by KO on 2015/09/28.
//  Copyright (c) 2015年 KO. All rights reserved.
//

import Foundation

/**
 * 文字列に関するユティリティ関数を集めたクラス
 */
public class StringUtil {
  /** 都道府県の接尾句の文字集合 */
  public static let prefectureDivider = NSCharacterSet(charactersInString: "都道府県")
  
  /**
   * 先頭に都道府県のついた住所文字列から都道府県名を除外する
   *
   * - parameter address: 先頭に都道府県のついた住所文字列
   * - returns: 都道府県を抜いた住所文字列
   */
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
