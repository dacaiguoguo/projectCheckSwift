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
//let 声明的事常量，不可变immutable，var 声明的是变量，可以变mutable
//var someInts = [Int](count: 3, repeatedValue: 4)
//someInts.append(3)
//print(someInts)
//let threeDoubles = [Double](count: 3, repeatedValue: 0.0)
//let antherThreeDoubles = [Double](count: 3, repeatedValue: 1.0)
//let sixDoubles = threeDoubles + antherThreeDoubles
//print(sixDoubles)
//let initWithArrayLiteral = [1.0, 2.0, 3.0, "abc"]
//print(initWithArrayLiteral)
//类型推断为String的数组
//var shoppingList = ["Eggs", "Milk"]
//print("The shopping list is contain \(shoppingList.count) items")
//if shoppingList.isEmpty {
//    print("The shopping list is Empty")
//} else {
//    print("the shopping list is not Empty")
//}

//创建常量字符串
let fileDictoryPath = "/Users/sunyanguo/Documents/work/lvmama_iphone7.5.007"
let abc =  fileDictoryPath.rangeOfString("abcc")
let abc2 =  fileDictoryPath.rangeOfString("lvmama_iphone731")
let s: String = "Stack Overflow"
let ss1: String = (s as NSString).substringToIndex(5)
let index: String.Index = s.startIndex.advancedBy(5) // Swift 2
let ss2:String = s.substringToIndex(index)
//print(fileDictoryPath.length)
//调用NSURL的init方法
let url = NSURL(fileURLWithPath:fileDictoryPath);
let manager = NSFileManager.defaultManager()

do {
    //不会递归，这个方法钱要加 try
    let contents = try manager.contentsOfDirectoryAtURL(url, includingPropertiesForKeys: nil
        , options: NSDirectoryEnumerationOptions.SkipsPackageDescendants);
    //递归遍历目录下的文件，返回NSDirectoryEnumerator
    let enumeratorAtURL = manager.enumeratorAtURL(url, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles, errorHandler: nil)
    let allFileUrlArray = enumeratorAtURL?.allObjects
    //筛选后缀为m的文件路径
    let filteredmArray = allFileUrlArray?.filter({ (path:(AnyObject)) -> Bool in
        let surl:NSURL = path as! NSURL
        return surl.pathExtension == "m"
    })
    //用枚举器遍历数组
    let lowercaseSet: String.Index = s.startIndex.advancedBy(1)
    let firstSet = "abcdefghijklmnopqrstuvwxyz_"
    for (index, value) in filteredmArray!.enumerate() {
        let fileNameFirst = value.lastPathComponent.substringToIndex(lowercaseSet)
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
//        print("Item \(index + 1): \(value)")
    }
} catch{}


