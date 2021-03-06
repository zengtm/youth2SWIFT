//
//  ViewController.swift
//  FirstDemo
//
//  Created by Thomas M Zeng on 9/4/16.
//  Copyright © 2016 Thomas M Zeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func colon_dash_parse(_ t : String) -> (code: Bool, b: UInt, e: UInt) {
        //let m = NSCharacterSet(charactersInString: "--")
        var fields = t.components(separatedBy: CharacterSet(charactersIn:"--"))
        //print(fields);
        if (fields.count < 3)
        { return (false, 0, 0) }
        
        //print(tokens)
        //print(fields);
        let e = strtoul(fields[2], nil, 16);
        let colon = CharacterSet(charactersIn: ":")
        var toks = fields[0].components(separatedBy: colon)
        //print(toks)
        var b : UInt = 0
        if (toks.count > 1){
            b = strtoul(toks[1], nil, 16);
            //print(pte.a)
            return (true, b,e)
        } else {
            return (false, 0, 0)
        }
        
    }
    
    func myHex (_ c: Character) -> Int {
        switch c {
            case "0":
                return (0)
            case "1":
                return (1)
            case "2":
                return (2)
            case "3":
                return (3)
            case "4":
                return (4)
            case "5": return (5)
            case "6": return (6)
            case "7": return (7)
            case "8": return (8)
            case "9": return (9)
            case "a": return (10)
            case "b": return (11)
            case "c": return (12)
            case "d": return (13)
            case "e": return (14)
            case "f": return (15)
        default: return (-1)
            
        }
    }
    
    func myPow(_ base:Int, exp:Int) -> Int {
        var y:Int = 1
        if exp == 0 {
            return 1
        }
        for _ in 1...exp {
            y = y*base
        }
        
         return(y)
    }
    
    func myStrtoul (_ t: String) -> (code: Bool, b: Int) {
        // 1. break string into characters	
     
        let chars = [Character](t.characters)
        
        var x:Int = 0;
        
        
        for n in (0...(chars.count-1)).reversed() {
            let u = myHex(chars[n]);
            x = x+u*myPow(16,exp: chars.count-n-1)
        }
        
        return(true,x)
    }
    
    func nestedLoops(_ n : Int) -> Int {
        for i in 0...n {
            var tmp : String = ""
            for j in 0...n {
                if j < n {
                    tmp = tmp + "(\(i),\(j))\t" + ", "
                }
                
                else {
                    tmp = tmp + "(\(i),\(j))\t"
                    
                }
            }
            print (tmp)
        }
        
        return (1)
    }
    func nestedLoopsWhile(_ n : Int) -> Int {
        var tmp : String = ""
        var i = 0
        repeat {
            tmp = "\0"
            var j = 0
            i = i + 1
            repeat {
                j = j + 1
                tmp = tmp + "(\(i),\(j))\t" + ", "
            } while (j<n)
            print(tmp)
        } while (i<n)
    return(1)
    }
    //
    // exclusive-oring strings of different lengths
    //
    func strxor(a: String, b: String) -> String {
        var c:String = ""
        var asub=a
        var bsub=b
        var n=0
        
        if a.characters.count > b.characters.count {
            n = b.characters.count
            let stop=a.index(a.startIndex, offsetBy:n-1)
            asub = a.substring(to:stop)
        }
        else {
            n = a.characters.count
            let stop=b.index(b.startIndex, offsetBy:n-1)
            bsub=b.substring(to:stop)
        }
        for (x,y) in zip(asub.unicodeScalars,bsub.unicodeScalars) {
                c.append(Character(UnicodeScalar(x.value ^ y.value)!) )
        }
        return c
        
    }
}
