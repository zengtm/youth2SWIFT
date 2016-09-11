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
    



}

