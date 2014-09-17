//
//  XmlTool.m
//  HME
//
//  Created by 夏 伟 on 13-12-30.
//  Copyright (c) 2013年 夏 伟. All rights reserved.
//

#import "XmlTool.h"

@implementation XmlTool

//开始解析前，可以做一些初始话的工作
- (void)parserDidStartDocument:(NSXMLParser *)parser
{
    self.myDataMutableDictionary = [[NSMutableDictionary alloc]init];
    self.currentElementName = [[NSString alloc]init];
}


//解析到一个开始tag，开始tag中可能会有properpies，例如<book catalog="Programming">
//所有的属性都储存在attributeDict中
- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    self.currentElementName = elementName;
    if ([elementName isEqual:@"Success"]) {
//        NSString *catalog =  [attributeDict objectForKey:@"catalog"];
//        NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    }
//    else if ([bookTags containsObject:elementName])
//    {
//        
//    }
}


//这时处理例如<title lang="en">C++ Programming Language</title>的情况
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string
{
    NSRange range = [string rangeOfString:@"\n"];
    if(range.length == 0){
        [self.myDataMutableDictionary setObject:string forKey:self.currentElementName];
    }
    NSLog(@"%@",string);
}

//处理到一个结束tag
- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
{
    
}

//xml解析结束 
- (void)parserDidEndDocument:(NSXMLParser *)parser
{
    NSLog(@"%@", self.myDataMutableDictionary);
}

-(void) testXMLParse :(NSString *)xmlString
{
//    NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"test.xml" ofType:nil inDirectory:nil];
//    
//    NSData *strData = [NSData dataWithContentsOfFile:xmlPath];
    
    NSLog(@"%@",xmlString);
    NSData *strData = [xmlString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithData:strData];
    [xmlParser setDelegate:self];
    BOOL result = [xmlParser parse];
    if (!result) {
        NSLog(@"The error is %@", [xmlParser parserError]);
    }
    //[xmlParser release];
}

@end
