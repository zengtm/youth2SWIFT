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
    
    
    func colon_dash_parse(t : String) -> (code: Bool, b: UInt, e: UInt) {
        //let m = NSCharacterSet(charactersInString: "--")
        var fields = t.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:"--"))
        //print(fields);
        if (fields.count < 3)
        { return (false, 0, 0) }
        
        //print(tokens)
        //print(fields);
        let e = strtoul(fields[2], nil, 16);
        let colon = NSCharacterSet(charactersInString: ":")
        var toks = fields[0].componentsSeparatedByCharactersInSet(colon)
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
    
    func myHex (c: Character) -> Int {
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
    
    func myPow(base:Int, exp:Int) -> Int {
        var y:Int = 1
        if exp == 0 {
            return 1
        }
        for _ in 1...exp {
            y = y*base
        }
        
         return(y)
    }
    
    func myStrtoul (t: String) -> (code: Bool, b: Int) {
        // 1. break string into characters	
     
        let chars = [Character](t.characters)
        
        var x:Int = 0;
        
        
        for n in (0...(chars.count-1)).reverse() {
            let u = myHex(chars[n]);
            x = x+u*myPow(16,exp: chars.count-n-1)
        }
        
        return(true,x)
    }
    
    func nestedLoops(n : Int) -> Int {
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
    func nestedLoopsWhile(n : Int) -> Int {
        var tmp : String = ""
        var j = 0
        var i = 0
        repeat {
            i = i + 1
            j = j + 1
            repeat {
                tmp = tmp + "(\(i),\(j))\t" + ", "
            } while (i<=n)
            print(tmp)
        } while (j<=n)
    return(1)
    }
    
}