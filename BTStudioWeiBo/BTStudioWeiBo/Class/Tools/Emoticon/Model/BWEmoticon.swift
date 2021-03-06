//
//  BWEmoticon.swift
//  BTStudioWeiBo
//
//  Created by hadlinks on 2019/4/22.
//  Copyright © 2019 BTStudio. All rights reserved.
//

import UIKit

/// 表情模型
@objcMembers class BWEmoticon: NSObject {
    
    /// 表情类型 -- false: 图片表情  true: emoji
    var type = false
    
    /// 表情字符串(简体中文) -- 用于发送给服务器(以节省流量)
    var chs: String?
    
    /// 表情字符串(繁体中文)
    var cht: String?
    
    /// 表情图片的名称 -- 用于本地图文混排
    var png: String?
    
    /// 表情gif图片的名称
    var gif: String?
    
    /// emoji的十六进制编码
    var code: String? {
        didSet {
            guard let code = code else { return }
            
            // 1. 创建字符扫描器,并从code字符串中扫描出十六进制数
            let scanner = Scanner(string: code)
            var result: UInt32 = 0
            scanner.scanHexInt32(&result)
            
            // 2. 使用UInt32数值生成一个UTF8字符
            guard let unicode = UnicodeScalar(result) else { return }
            let c: Character = Character(unicode)
            
            // 3. UTF8字符 转 字符串
            emoji = String(c)
        }
    }
    
    /// emoji字符串
    var emoji: String?
    
    /// 表情图片所在的目录
    var directory: String?
    
    /// 图片表情对应的图片 (计算型属性)
    var image: UIImage? {
        // 判断表情类型
        // 1. emoji
        if type {
            return nil
        }
        // 2. 图片表情
        guard let directory = directory,
            let png = png,
            let path = Bundle.main.path(forResource: "BWEmoticon", ofType: "bundle"),
            let bundle = Bundle(path: path) else {
                return nil
        }
        
        let image = UIImage(named: "\(directory)/\(png)", in: bundle, compatibleWith: nil)
        
        return image
    }
    
    /// 表情的使用次数
    var times: Int = 0
    
    override var description: String {
        return yy_modelDescription()
    }
    
    
    /// 将当前的图片转换成图片属性文本
    ///
    /// - Parameter font: 文本字体
    /// - Returns: 图片属性文本
    func imageText(font: UIFont) -> NSAttributedString {
        // 1. 判断图片是否存在
        guard let image = image else {
            return NSAttributedString(string: "")
        }
        
        // 2. 创建文本附件
        let hight = font.lineHeight
        let attachment = BWEmoticonAttachment()
        attachment.image = image
        attachment.bounds = CGRect(x: 0, y: -4, width: hight, height: hight)
        // 记录图片对应的文本
        attachment.chs = chs
        
        // 3. 返回图片属性文本
        let attributedString = NSAttributedString(attachment: attachment)
        
        // 4. 设置图片属性文本的字体属性
        let attributedStringM = NSMutableAttributedString(attributedString: attributedString)
        attributedStringM.addAttributes([NSAttributedString.Key.font: font], range: NSMakeRange(0, 1))
        
        // 5. 返回图片属性文本
        return attributedStringM
    }
}
