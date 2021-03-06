//
//  Log.swift
//  KLibrary
//
//  Created by KO on 2015/01/16.
//  Copyright (c) 2015年 KO. All rights reserved.
//

import Foundation

/**
 * ローテーション可能なログファイル
 */
public class LogFile {
  /** ログを保存するディレクトリ */
  private let dir: String
  
  /** ログファイル名の先頭につく固定文字列 */
  private let prefix: String
  
  /** 何日でローテーションするか */
  private let rotationDays: Int
  
  /** ローテション後のログファイルを何世代保存するか */
  private let maxBackups: Int
  
  /** ファイルハンドル */
  private var fileHandle: NSFileHandle?
  
  /** ログファイルのパス */
  private var path = ""
  
  /** 次にローテションする日付(整数) */
  private var rotationDate = 0
  
  /** ファイルの内容 */
  public var contents: String? {
    let files = listFiles()
    
    var contentList = [String]()
    for file in files {
      if let fileContent = try? NSString(contentsOfFile: (dir as NSString).stringByAppendingPathComponent(file),
          encoding: NSUTF8StringEncoding) {
        contentList.append(String(fileContent))
      }
    }
    
    if contentList.count > 0 {
      return contentList.joinWithSeparator("")
    } else {
      return nil
    }
  }
  
  /**
   * ログファイルのインスタンスを生成する
   *
   * - parameter dir: ログを保存するディレクトリ
   * - parameter prefix: ログファイル名の先頭につく固定文字列
   * - parameter rotationDays: 何日でローテーションするか
   * - parameter maxBackups: ローテション後のログファイルを何世代保存するか
   */
  public init(dir: String, prefix: String, rotationDays: Int, maxBackups: Int) {
    self.dir = dir
    self.prefix = prefix
    self.rotationDays = rotationDays
    self.maxBackups = maxBackups
    
    let files = listFiles()
    
    let startDay: Int
    let fileName: String
    if files.count > 0 {
      fileName = files.last!
      startDay = extractDateFromFileName(fileName)
    } else {
      startDay = NSDate().dateInt
      fileName = createFile(startDay)
    }
    
    rotationDate = dateForRotation(startDay)
    path = (dir as NSString).stringByAppendingPathComponent(fileName)
    fileHandle = NSFileHandle(forWritingAtPath: path)
    if let fileHandle = fileHandle {
      fileHandle.seekToEndOfFile()
    }
  }
  
  // 破棄時に呼び出される
  deinit {
    closeFile()
  }
  
  /**
   * ログを記入する（与えれらた文字列の前に日時が挿入される）
   *
   * - parameter log: ログ文字列
   */
  public func log(log: String) {
    let today = NSDate().dateInt
    while today >= rotationDate {
      rotateFile()
    }
    if let fileHandle = fileHandle {
      let output = NSDate().simpleString + " " + log + "\n"
      let data = output.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)
      print(output, terminator: "")
      fileHandle.writeData(data!)
    }
  }
  
  /**
   * ファイル名から日付(整数）を得る
   *
   * - parameter fileName: ファイル名
   * - returns: 日付(整数）
   */
  private func extractDateFromFileName(fileName: String) -> Int {
    return Int((fileName as NSString).stringByDeletingPathExtension.substringFromIndex(
      fileName.startIndex.advancedBy(prefix.characters.count)))!
  }
  
  /**
   * 所定のディレクトリーの下のログファイルのリストを得る
   *
   * - returns: ログファイル名の配列
   */
  private func listFiles() -> [String] {
    return FileUtil.listFiles(dir, predicate: { fileName in
      return (fileName as NSString).pathExtension == "log" &&
        fileName.rangeOfString(self.prefix)?.startIndex == fileName.startIndex
    })
  }
  
  /**
   * ログファイルを作成する
   *
   * - parameter firstDate: ログ開始日
   * - returns: ファイル名
   */
  private func createFile(firstDate: Int) -> String {
    let fileName = "\(prefix)\(firstDate).log"
    path = (dir as NSString).stringByAppendingPathComponent(fileName)
    
    let fm = NSFileManager.defaultManager()
    fm.createFileAtPath(path, contents: nil, attributes: nil)
    fileHandle = NSFileHandle(forWritingAtPath: path)
    
    return fileName
  }
  
  /**
   * 開いているログファイルがあれば閉じる
   */
  private func closeFile() {
    if let fileHandle = fileHandle {
      fileHandle.synchronizeFile()
      fileHandle.closeFile()
    }
  }
  
  /**
   * 次にローテーションを行う日付を得る
   *
   * - parameter firstDate: ログ開始日
   * - returns: 次にローテーションを行う日付(日付)
   */
  private func dateForRotation(firstDate: Int) -> Int {
    return NSDate.fromInt(firstDate)!.dateByAddingTimeInterval(
      Double(rotationDays) * 24 * 60 * 60.0).dateInt
  }
  
  /**
   * ファイルをローテーションし、保存数を超える古いファイルは削除する
   */
  private func rotateFile() {
    closeFile()
    let files = listFiles()
    
    let fm = NSFileManager.defaultManager()
    if files.count > maxBackups {
      for i in 0 ..< files.count - maxBackups {
        let fileName = files[i]
        let path = (dir as NSString).stringByAppendingPathComponent(fileName)
        do {
          try fm.removeItemAtPath(path)
        } catch _ {
        }
      }
    }
    
    createFile(rotationDate)
    rotationDate = dateForRotation(rotationDate)
  }
}
