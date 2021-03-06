//
//  ViewController.swift
//  Example
//
//  Created by Heberti Almeida on 08/04/15.
//  Copyright (c) 2015 Folio Reader. All rights reserved.
//

import UIKit
import FolioReaderKit

class ViewController: UIViewController {
    
    
    var coverImage:UIImage?
    
    private func readerConfiguration(forEpub epub: Epub) -> FolioReaderConfig {
        let config = FolioReaderConfig(withIdentifier: epub.readerIdentifier)
        config.shouldHideNavigationOnTap = epub.shouldHideNavigationOnTap
        config.scrollDirection = epub.scrollDirection
        
        // Custom sharing quote background
        config.quoteCustomBackgrounds = []
        if let image = UIImage(named: "demo-bg") {
            let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
            config.quoteCustomBackgrounds.append(customImageQuote)
        }
        let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
        let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
        let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
        config.quoteCustomBackgrounds.append(customQuote)
        return config
    }
    
    override func viewDidLoad() {
        print("Loaded")
        
        
    }
    
    
    
    @IBAction func loadBook(){
        
        let bookPath = Bundle.main.path(forResource: "The Silver Chair", ofType: "epub")
        
        //let parser = FREpubParser()
        
        
        
//        parser
//        guard let parsedBook = try FREpubParser().readEpub(epubPath: self.epubPath, removeEpub: self.shouldRemoveEpub) else {
//            self.errorOnLoad = true
//        }
   
            
        do {
            let cover = try FREpubParser().parseCoverImage(bookPath!)
            coverImage = cover
        } catch {
            print("Poop")
        }
        

        
        var subject = FREpubParser()
        do {
            let book = try subject.readEpub(epubPath: bookPath!)
            
            for i in book!.tableOfContents{
                print("chapter",i.title)
            }
            
        } catch let e as FolioReaderError {
            print(e.localizedDescription)
        } catch {
            print("Unknown error")
        }
        
/*
        let folioReader = FolioReader()
        let readerConfiguration = self.readerConfiguration(forEpub: Epub(rawValue: 0)!)
        folioReader.presentReader(parentViewController: self, withEpubPath: bookPath!, andConfig: readerConfiguration, shouldRemoveEpub: false)*/

        
        
        
        //self.performSegue(withIdentifier: "loadBook", sender: nil)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Second") as! SecondVC
        
        nextViewController.coverImage = self.coverImage
        
        self.present(nextViewController, animated:true, completion:nil)
        
        
    }
    
}

//MARK:- Original
/*
 @IBOutlet weak var bookOne: UIButton?
 @IBOutlet weak var bookTwo: UIButton?
 let folioReader = FolioReader()
 
 override func viewDidLoad() {
 super.viewDidLoad()
 
 self.bookOne?.tag = Epub.bookOne.rawValue
 self.bookTwo?.tag = Epub.bookTwo.rawValue
 
 self.setCover(self.bookOne, index: 0)
 self.setCover(self.bookTwo, index: 1)
 }
 
 private func readerConfiguration(forEpub epub: Epub) -> FolioReaderConfig {
 let config = FolioReaderConfig(withIdentifier: epub.readerIdentifier)
 config.shouldHideNavigationOnTap = epub.shouldHideNavigationOnTap
 config.scrollDirection = epub.scrollDirection
 
 // See more at FolioReaderConfig.swift
 //        config.canChangeScrollDirection = false
 //        config.enableTTS = false
 //        config.allowSharing = false
 //        config.tintColor = UIColor.blueColor()
 //        config.toolBarTintColor = UIColor.redColor()
 //        config.toolBarBackgroundColor = UIColor.purpleColor()
 //        config.menuTextColor = UIColor.brownColor()
 //        config.menuBackgroundColor = UIColor.lightGrayColor()
 //        config.hidePageIndicator = true
 //        config.realmConfiguration = Realm.Configuration(fileURL: FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("highlights.realm"))
 
 // Custom sharing quote background
 config.quoteCustomBackgrounds = []
 if let image = UIImage(named: "demo-bg") {
 let customImageQuote = QuoteImage(withImage: image, alpha: 0.6, backgroundColor: UIColor.black)
 config.quoteCustomBackgrounds.append(customImageQuote)
 }
 
 let textColor = UIColor(red:0.86, green:0.73, blue:0.70, alpha:1.0)
 let customColor = UIColor(red:0.30, green:0.26, blue:0.20, alpha:1.0)
 let customQuote = QuoteImage(withColor: customColor, alpha: 1.0, textColor: textColor)
 config.quoteCustomBackgrounds.append(customQuote)
 
 return config
 }
 
 fileprivate func open(epub: Epub) {
 guard let bookPath = epub.bookPath else {
 return
 }
 
 let readerConfiguration = self.readerConfiguration(forEpub: epub)
 folioReader.presentReader(parentViewController: self, withEpubPath: bookPath, andConfig: readerConfiguration, shouldRemoveEpub: false)
 }
 
 private func setCover(_ button: UIButton?, index: Int) {
 guard
 let epub = Epub(rawValue: index),
 let bookPath = epub.bookPath else {
 return
 }
 
 do {
 if let image = try FolioReader.getCoverImage(bookPath) {
 button?.setBackgroundImage(image, for: .normal)
 }
 } catch let e as FolioReaderError {
 print(e.localizedDescription)
 } catch {
 print("Unkown error")
 }
 }
 }
 
 // MARK: - IBAction
 
 extension ViewController {
 
 @IBAction func didOpen(_ sender: AnyObject) {
 guard let epub = Epub(rawValue: sender.tag) else {
 return
 }
 
 self.open(epub: epub)
 }
 }*/
