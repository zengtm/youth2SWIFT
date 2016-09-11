import Foundation;

/**
 * scan to find out the status of 16 contiguous.
 func is_16_contig_block(pArray : [Distance_t], pos : UInt) -> Bool {
 
 }
 */

func colon_dash_parse(t : String) -> (code: Bool, b: UInt64, e: UInt64) {
    let m = NSCharacterSet(charactersInString: "--")
    var fields = t.componentsSeparatedByCharactersInSet(m)
    //print(fields);
    if (fields.count < 3)
    { return (false, 0, 0) }
    
    //print(tokens)
    //print(fields);
    let e = strtoull(fields[2], nil, 16);
    let colon = NSCharacterSet(charactersInString: ":")
    var toks = fields[0].componentsSeparatedByCharactersInSet(colon)
    //print(toks)
    var b : UInt64 = 0
    if (toks.count > 1){
        //b = strtoul(toks[1], nil, 16);
        b = strtoull(toks[1], nil, 16);
        //print(toks[1], b)
        return (true, b, e)
    } else {
        return (false, 0, 0)
    }
    
}


// step 1: read file into a String object
// let myFileURL = NSBundle.mainBundle().URLForResource("input", withExtension: "txt")!

// let path = NSBundle.mainBundle().pathForResource("input", ofType: "txt")
// let path = "/Users/tomzeng/Projects/teachingSWIFT/parse_t32_pt_dump/input.txt"

func parse_pt_file(fname : String) -> Bool {

    //let int32_max = Int (my_max);

    //if path == nil {
    //  return nil
    //}
    var text : NSString;
    do {
        text = try NSString(contentsOfFile: fname, encoding: NSUTF8StringEncoding);
    } catch {
        print("parse_pt_file cannot open file")
        return false
    }

    let lineArray = text.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
    // print(lineArray[0])
    //let myText = try! String(contentsOfURL: myFileURL, encoding: NSISOLatin1StringEncoding)
    // print(String(myText))
    
    struct Distances_t {
        var va : Int64 = 0;
        var pa : Int64 = 0;
    };

    // step 2: tokenize by "|"

    // at the end of the below for loop, we will get an array of structure:
    // pte_info:  1. start input addr and size   2. phys addr. 3. permission 4. memory attributes
    struct pte_info {
        var a : UInt64 = 0;
        var b : UInt64 = 0;
        var p : UInt64 = 0;
        var s : UInt64 = 0;
        var va_jump : UInt64 = 0;
        var pa_jump : UInt64 = 0;
    };

    var pteArray : [pte_info] = [];

    var pte = pte_info(a: 0, b: 0, p: 0, s: 0, va_jump: 0, pa_jump: 0);
    //var pre_pte = pte_info(a: 0, b: 0, p: 0, s: 0, va_jump: 0, pa_jump: 0);
    var v : UInt64 = 0;
    var p : UInt64 = 0;
    for (_, element) in lineArray.enumerate() {
         //	print(element)

         let mySeparator = NSCharacterSet(charactersInString: "|")
         var tokens = element.componentsSeparatedByCharactersInSet(mySeparator)
         if (tokens.count < 4) 
            { continue }

         var rc : Bool;
        (rc, pte.a, pte.b) = colon_dash_parse(tokens[0])
         let tmpa = pte.a

         if (rc == true) {
            pte.s = strtoull(tokens[4], nil, 16)
            
            //print (pte.s)
            // var junk : UInt = 0
            // print(tokens)
            (rc, pte.p,_) = colon_dash_parse(tokens[1])
            if (rc  == true) {
                //print(rc)
                if (pteArray.count > 0)
                 { 
                    pte.va_jump = pte.a - v;      
                    pte.pa_jump = pte.p - p;
                    v = tmpa
                 } else {
                    pte.va_jump = 0;
                    pte.pa_jump = 0;
                    v = tmpa
                    //p = tmpp  
                    //print(tmpa, tmpp)
                    //print(pte.va_jump, pte.pa_jump);
                 }
                pteArray.append(pte);
                // pre_pte = pte;  // make a copy of the pte structure.
            }
         }
    }
    
    var distances : [Distances_t] = [];
    var d = Distances_t(va : 0, pa : 0);
    var a : UInt64 = 0;
    var pa_distance_stats = [Int64: UInt]()
    var size_stats = [UInt64: UInt]()
    var va_region_count = 0;
    for (n, pte) in pteArray.enumerate() {
        // print(n);
        if (n > 0) {
            // print(pteArray[n-1].a)
            a = pteArray[n-1].a
            p = pteArray[n-1].p
            //print (a, p)
        }
        let p1 = pte.p
        let a1 = pte.a
        if (n>0) {
            d.va = Int64(a1 - a);
            if (p1 > p) {
                d.pa = Int64(p1 - p);
            } else {
                d.pa = Int64(p - p1) * (-1);
            } 
        } 
        
        //print (d);
        
        distances.append(d);
        
        if (pa_distance_stats.keys.contains(d.pa))
        { pa_distance_stats[d.pa]! = pa_distance_stats[d.pa]! + 1}
        else
        { pa_distance_stats[d.pa] = 1 }
        
        if (size_stats.keys.contains(pte.s))
        { size_stats[pte.s]! = size_stats[pte.s]! + 1}
        else
        { size_stats[pte.s] = 1 }
        
        // detect the number of VA regions
        if (pte.s + a != pte.a) {
            va_region_count+=1
        }
    }
    
    for (k, v) in pa_distance_stats {
        let format = String(format:"   %x(%d), %d", k,k, v);
        print (format);
    }
    print ("# entries in PA distance stats: \(pa_distance_stats.count)")
    
    print("PTE Size stats: \n\n")
    for (k, v) in size_stats {
        let format = String(format:"   %x, %d", k, v);
        print (format);
    }
    
    print("Number of VA regions: \(va_region_count)")
    return true
    
}


