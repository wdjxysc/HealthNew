//
//  XmlTool.h
//  HME
//
//  Created by 夏 伟 on 13-12-30.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XmlTool : NSObject<NSXMLParserDelegate>

@property(nonatomic,retain)NSString *currentElementName;
@property(nonatomic,retain)NSMutableDictionary *myDataMutableDictionary;
-(void) testXMLParse :(NSString *)xmlString;
@end
