//
//  CacheSaveHelper.swift
//  MapiaOnSwift
//
//  Created by Sasha Minikin on 5/13/16.
//  Copyright © 2016 Sasha Prokhorenko. All rights reserved.
//

import Foundation

class FileSaveHelper {
  
  // MARK:- Error Types
  
  private enum FileErrors:ErrorType {
    case FileNotSaved
    case ImageNotConvertedToData
    case FileNotRead
    case FileNotFound
  }
  
  // MARK:- File Extension Types
  enum FileExtension: String {
    case MAPIA = ".mapia"
  }

  // MARK:- Private Properties
  private let directory:NSSearchPathDirectory
  private let directoryPath: String
  private let fileManager = NSFileManager.defaultManager()
  private let fileName:String
  private let filePath:String
  private let fullyQualifiedPath:String
  private let subDirectory:String
  
  // MARK:- Public Properties
  var fileExists:Bool {
    get {
      return fileManager.fileExistsAtPath(fullyQualifiedPath)
    }
  }
  
  var directoryExists:Bool {
    get {
      var isDir = ObjCBool(true)
      return fileManager.fileExistsAtPath(filePath, isDirectory: &isDir )
    }
  }
  
  // MARK:- Initializers
  convenience init(fileName:String, fileExtension:FileExtension, subDirectory:String){
    self.init(fileName:fileName, fileExtension:fileExtension, subDirectory:subDirectory, directory:.DocumentDirectory)
  }

  /**
   Initialize the FileSaveHelper Object with parameters
   
   :param: fileName      The name of the file
   :param: fileExtension The file Extension
   :param: directory     The desired sub directory
   :param: saveDirectory Specify the NSSearchPathDirectory to save the file to
   
   */
  init(fileName:String, fileExtension:FileExtension, subDirectory:String, directory:NSSearchPathDirectory){
    self.fileName = fileName + fileExtension.rawValue
    self.subDirectory = "/\(subDirectory)"
    self.directory = directory
    self.directoryPath = NSSearchPathForDirectoriesInDomains(directory, .UserDomainMask, true)[0]
    self.filePath = directoryPath + self.subDirectory
    self.fullyQualifiedPath = "\(filePath)/\(self.fileName)"
    createDirectory()
  }
  
  /**
   If the desired directory does not exist, then create it.
   */
  private func createDirectory(){
    if !directoryExists {
      do {
        try fileManager.createDirectoryAtPath(filePath, withIntermediateDirectories: false, attributes: nil)
      }
      catch {
        print("An Error was generated creating directory")
      }
    }
  }
  
  // MARK:- File saving method
  
  /**
   
   Save the data to file.
   
   :param: data NSData
   
   */
  
  func saveDataToCache(data : NSData) throws {
    
    if !fileManager.createFileAtPath(fullyQualifiedPath, contents: data, attributes: nil){
      throw FileErrors.FileNotSaved
    }
  }
  
  // MARK:- File get method
  
  /**
   
   Get the data of file.
   
   */
  
  func getCacheData() throws -> NSData? {
    
//    guard fileExists else {
//      throw FileErrors.FileNotRead
//    }
    
    print(fullyQualifiedPath)
    
//    guard let cacheData = NSData(contentsOfFile: fullyQualifiedPath)else {
//      throw FileErrors.FileNotRead
//    }
    return NSData(contentsOfFile: fullyQualifiedPath)
  }
  
}