//
//  FileUtil.swift
//  KLibrary
//
//  Created by KO on 2015/01/25.
//  Copyright (c) 2015年 KO. All rights reserved.
//

import Foundation

/**
 * ファイルに関するユティリティ関数を集めたクラス
 */
public class FileUtil {
  /** 
   * テキストファイル全行を得る
   *
   * :param: path テキストファイルのパス
   * :returns: 各行の文字列の配列
   */
  public class func readLines(path: String) -> [String] {
    let contents = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil)
    if let contents = contents {
      let lines = contents.componentsSeparatedByString("\n")
      return lines
    } else {
      return [String]()
    }
  }
  
  /** iOSアプリのサンドボックスのドキュメントディレクトリ */
  public class var documentDir: String {
    let docDirs = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory,
      NSSearchPathDomainMask.UserDomainMask, true)
    return docDirs![0] as! String
  }
  
  /** 
   * 指定のディレクトリ直下の条件に合致するファイルの一覧を得る
   *
   * :param: dir ディレクトリ
   * :param: predicate 条件に合致するかどうかを判定する関数
   * :returns: 条件に合致するファイルの一覧
   */
  public class func listFiles(dir: String, predicate: (fileName: String) -> Bool) -> [String] {
    var result = [String]()
    let fm = NSFileManager.defaultManager()
    let files = fm.contentsOfDirectoryAtPath(dir, error: nil)
    var fileName = ""
    for file in files! {
      fileName = (file as? String)!
      if predicate(fileName: fileName) {
        result.append(fileName)
      }
    }
    return result
  }
}