//
//  AutocolorgenerationViewController.swift
//  ShowTalent
//
//  Created by maraekat on 16/01/20.
//  Copyright © 2020 apple. All rights reserved.
//

import UIKit

class AutocolorgenerationViewController: UIViewController {
    
    
    @IBOutlet weak var customimage: UIImageView!
    
    
    @IBOutlet weak var customview: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let canvasize = CGSize(width: 200, height: 200)

        UIGraphicsBeginImageContextWithOptions(canvasize, true, 1.0)
        customimage.image?.draw(in: CGRect(x: 0, y: 0, width: canvasize.width, height: canvasize.height))
        let renderimage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        self.customimage.image = (blur(image: customimage.image!, radius: 20))
        
        self.customview.backgroundColor = self.customimage.image!.getComplementaryForColor(color: (self.customimage.image?.areaAverage())!)
        
        
        
        

        // Do any additional setup after loading the view.
    }
    
   



  
    
    func blur(image:UIImage, radius:Int) -> UIImage {
    let subcanvasize = CGRect(x: 10, y: 10, width: 50, height: 50)
      let context = CIContext(options: nil)
      let blurFilter = CIFilter(name: "CIGaussianBlur")
      let ciImage = CIImage(image: image)
      blurFilter!.setValue(ciImage, forKey: kCIInputImageKey)
      blurFilter!.setValue(radius, forKey: kCIInputRadiusKey)

      let cropFilter = CIFilter(name: "CICrop")
      cropFilter!.setValue(blurFilter!.outputImage, forKey: kCIInputImageKey)
      cropFilter!.setValue(CIVector(cgRect: ciImage!.extent), forKey: "inputRectangle")

      let output = cropFilter!.outputImage
      let cgimg = context.createCGImage(output!, from: output!.extent)
      let processedImage = UIImage(cgImage: cgimg!)
        self.customimage.image!.draw(in: subcanvasize, blendMode: .hardLight, alpha: 1)
        renderText(text: "hello")
      return processedImage
    }
    
    func renderText(text:String) -> String {
         let newSize = CGRect(x: 10, y: 10, width: 50, height: 50)
    let text = "Sample Text" as NSString
    let textfont = UIFont(name: "Arial", size: 30)
    let paragraphstyle = NSMutableParagraphStyle()
    paragraphstyle.alignment = .center
    let textRect = CGRect(x: 0, y: 0, width: newSize.width , height: newSize.height/2)
        let textattributes = [NSAttributedString.Key.font: textfont!, NSAttributedString.Key.foregroundColor : UIColor.green, NSAttributedString.Key.paragraphStyle: paragraphstyle ] as [NSAttributedString.Key : Any]
    text.draw(with: textRect, options: [.usesLineFragmentOrigin, .truncatesLastVisibleLine], attributes: textattributes, context: nil)
    return text as String
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension UIImage {
func areaAverage() -> UIColor {

    var bitmap = [UInt8](repeating: 0, count: 4)

    let context = CIContext(options: nil)
    let cgImg = context.createCGImage(CoreImage.CIImage(cgImage: self.cgImage!), from: CoreImage.CIImage(cgImage: self.cgImage!).extent)

    let inputImage = CIImage(cgImage: cgImg!)
    let extent = inputImage.extent
    let inputExtent = CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.size.width, w: extent.size.height)
    let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: inputExtent])!
    let outputImage = filter.outputImage!
    let outputExtent = outputImage.extent
    assert(outputExtent.size.width == 1 && outputExtent.size.height == 1)

    // Render to bitmap.
    context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: CIFormat.RGBA8, colorSpace: CGColorSpaceCreateDeviceRGB())

    // Compute result.
    let result = UIColor(red: CGFloat(bitmap[0]) / 255.0, green: CGFloat(bitmap[1]) / 255.0, blue: CGFloat(bitmap[2]) / 255.0, alpha: CGFloat(bitmap[3]) / 255.0)
    return result
}
func getComplementaryForColor(color: UIColor) -> UIColor {
           
           let ciColor = CIColor(color: color)
           
           // get the current values and make the difference from white:
    let compRed: CGFloat = 0.92 - ciColor.red
    let compGreen: CGFloat = 0.7 - ciColor.green
    let compBlue: CGFloat = 0.65 - ciColor.blue
           
           return UIColor(red: compRed, green: compGreen, blue: compBlue, alpha: 1.0)
       }
}
