//
//  main.swift
//  projectCheckSwift
//
//  Created by yanguo sun on 16/3/14.
//  Copyright © 2016年 Lvmama. All rights reserved.
//

import Foundation
//给String 添加扩展
extension String {
    var length: Int {
        return characters.count
    }
}

let fileDictoryPath = "/Users/sunyanguo/Documents/work/lvmama_iphone7.5.007"
let url = NSURL(fileURLWithPath:fileDictoryPath);
let manager = NSFileManager.defaultManager()

do {
    //递归遍历目录下的文件，返回NSDirectoryEnumerator
    let enumeratorAtURL = manager.enumeratorAtURL(url, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, errorHandler: nil)
    let allFileUrlArray = enumeratorAtURL?.allObjects
    //筛选后缀为m的文件路径用于检测文件命名是否首字母大写
    let filteredmArray = allFileUrlArray?.filter({ (path:(AnyObject)) -> Bool in
        let surl:NSURL = path as! NSURL
        return surl.pathExtension == "m"
    })
    //用枚举器遍历数组
    let firstIndex: String.Index = fileDictoryPath.startIndex.advancedBy(1)
    let firstSet = "abcdefghijklmnopqrstuvwxyz_"
    for (index, value) in filteredmArray!.enumerate() {
        let fileNameFirst = value.lastPathComponent.substringToIndex(firstIndex)
        if let range = firstSet.rangeOfString(fileNameFirst) {
            let fileName = value.lastPathComponent
            print("文件名首字母check：\(fileName)")
        }
    }
    //筛选后缀为xib的文件路径
    let filteredXibArray = allFileUrlArray?.filter({ (path:(AnyObject)) -> Bool in
        let surl:NSURL = path as! NSURL
        return surl.pathExtension == "xib"
    })
    for (index, value) in filteredXibArray!.enumerate() {
        let fileContent = try String(contentsOfURL: (value as! NSURL))
        if let range = fileContent.rangeOfString("fontDescription\" type=\"system") {
            let fileName = value.lastPathComponent
            print("系统字体check：\(fileName)")
        }
        if let range = fileContent.rangeOfString("fontDescription\" type=\"boldSystem\"") {
            let fileName = value.lastPathComponent
            print("系统粗体字体check：\(fileName)")
        }
    }
    for (index, value) in filteredXibArray!.enumerate() {
        let fileContent = try String(contentsOfURL: (value as! NSURL))
        if let range = fileContent.rangeOfString("Margin") {
            let fileName = value.lastPathComponent
            print("Margin check：\(fileName)")
        }
        if let range = fileContent.rangeOfString("firstBaseline") {
            let fileName = value.lastPathComponent
            print("firstBaseline check：\(fileName)")
        }
        
    }
    //筛选后缀为h、m的文件路径用于检测 #warning by
    let filteredHmArray = allFileUrlArray?.filter({ (path:(AnyObject)) -> Bool in
        let surl:NSURL = path as! NSURL
        return surl.pathExtension == "m"||surl.pathExtension == "h"
    })
    for (index, value) in filteredHmArray!.enumerate() {
        let fileContent = try String(contentsOfURL: (value as! NSURL))
        if let range = fileContent.rangeOfString("Margin") {
            let fileName = value.lastPathComponent
            print("Margin check：\(fileName)")
        }
        if let range = fileContent.rangeOfString("#warning by") {
            let fileName = value.lastPathComponent
            print("firstBaseline check：\(fileName)")
        }
        
    }

} catch{}


