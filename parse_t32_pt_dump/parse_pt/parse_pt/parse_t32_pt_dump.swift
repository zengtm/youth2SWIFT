import Foundation;

func colon_dash_parse(t : String) -> (code: Bool, b: UInt, e: UInt) {
     let m = NSCharacterSet(charactersInString: "--")
     var fields = t.componentsSeparatedByCharactersInSet(m) 
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

// step 1: read file into a String object
// let myFileURL = NSBundle.mainBundle().URLForResource("input", withExtension: "txt")!

// let path = NSBundle.mainBundle().pathForResource("input", ofType: "txt")
// let path = "/Users/tomzeng/Projects/teachingSWIFT/parse_t32_pt_dump/input.txt"

func parse_pt_file(fname : String) -> Bool {

    let my_max : Double = (pow(2,32));
    let int32_max = Int (my_max);

    //if path == nil {
    //  return nil
    //}

    let text = try NSString(contentsOfFile: fname, encoding: NSUTF8StringEncoding)

    //print(text)

    let lineArray = text.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    // print(lineArray[0])
    //let myText = try! String(contentsOfURL: myFileURL, encoding: NSISOLatin1StringEncoding)
    // print(String(myText))

    // step 2: tokenize by "|"

    // at the end of the below for loop, we will get an array of structure:
    // pte_info:  1. start input addr and size   2. phys addr. 3. permission 4. memory attributes
    struct pte_info {
        var a : UInt = 0;
        var b : UInt = 0;
        var p : UInt = 0;
        var s : UInt = 0;
        var va_jump : UInt = 0;
        var pa_jump : UInt = 0;
        // var perm : String; 
        // var attr : String;  
    };

    var pteArray : [pte_info] = [];

    var pte = pte_info(a: 0, b: 0, p: 0, s: 0, va_jump: 0, pa_jump: 0);
    //var pre_pte = pte_info(a: 0, b: 0, p: 0, s: 0, va_jump: 0, pa_jump: 0);
    var v : UInt = 0;
    var p : UInt = 0;
    var p2 : UInt = 0;
    for (index, element) in lineArray.enumerate() {
         //	print(element)

         let mySeparator = NSCharacterSet(charactersInString: "|")
         var tokens = element.componentsSeparatedByCharactersInSet(mySeparator)
         if (tokens.count < 4) 
            { continue }

         var rc : Bool;
         (rc, pte.a, pte.b) = colon_dash_parse(tokens[0])
         let tmpa = pte.a

         if (rc == true) {
            pte.s = strtoul(tokens[4], nil, 16)
            //print (pte.s)
            var junk : UInt = 0
            // print(tokens)
            (rc, pte.p, junk) = colon_dash_parse(tokens[1])
            let tmpp = pte.p;
            if (rc  == true) {
                //print(rc)
                if (pteArray.count > 0)
                 { 
                    pte.va_jump = pte.a - v;      
                    pte.pa_jump = pte.p - p;
                    //pre_pa = pte.p;
                    v = tmpa
                    print(p2, tmpp)
                    print(pte.va_jump, pte.pa_jump, int32_max, Int(pte.pa_jump) - int32_max);
                 } else {
                    pte.va_jump = 0;
                    pte.pa_jump = 0;
                    v = tmpa
                    //p = tmpp  
                    //print(tmpa, tmpp)
                    print(pte.va_jump, pte.pa_jump);
                 }
            p2 = pte.p;
                pteArray.append(pte);
                // pre_pte = pte;  // make a copy of the pte structure.
            }
         }
    }
}

// step 3: from first token, "C:FFFF...--FFFF...", filter out:
//       1. "C:"
//       2. if PA is blank

// step 4: compute VA and PA distances
//
//       3.1: get start and stop addresses of VA
//       3.2: get start and stop addresses of PA
//       3.2: compute VA distance
