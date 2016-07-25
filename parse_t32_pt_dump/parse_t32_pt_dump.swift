import Foundation;
// step 1: read file into a String object
// let myFileURL = NSBundle.mainBundle().URLForResource("input", withExtension: "txt")!

// let path = NSBundle.mainBundle().pathForResource("input", ofType: "txt")
//let path = "/Users/tomzeng/Projects/teachingSWIFT/parse_t32_pt_dump/input.txt"
let path = "input.txt"

//if path == nil {
//  return nil
//}

var text = try NSString(contentsOfFile: path, encoding: NSUTF8StringEncoding)
//print(text)

var lineArray = text.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet())
// print(lineArray[0])
//let myText = try! String(contentsOfURL: myFileURL, encoding: NSISOLatin1StringEncoding)
// print(String(myText))

// step 2: tokenize by "|"

for (index, element) in lineArray.enumerate() {
     //	print(element)

     let mySeparator = NSCharacterSet(charactersInString: "|")
     var tokens = element.componentsSeparatedByCharactersInSet(mySeparator)
     print(tokens[0])
}


// step 3: from first token, "C:FFFF...--FFFF...", filter out:
//       1. "C:"
//       2. if PA is blank

// step 4: compute VA and PA distances
//
//       3.1: get start and stop addresses of VA
//       3.2: get start and stop addresses of PA
//       3.2: compute VA distance
