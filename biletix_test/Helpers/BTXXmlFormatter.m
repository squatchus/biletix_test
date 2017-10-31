//
//  BTXXmlFormatterr.m
//  biletix_test
//
//  Created by Sergey Mazulev on 10/30/17.
//  Copyright © 2017 Sergey Mazulev. All rights reserved.
//

#import "BTXXmlFormatter.h"
#import <libxml/tree.h>

@implementation BTXXmlFormatter

+ (NSString *)prettyPrinted:(NSString *)xml {
    const char *utf8String = [xml UTF8String];
    xmlDocPtr rawXmlDoc = xmlReadMemory(utf8String, (int)strlen(utf8String), NULL, NULL, XML_PARSE_NOCDATA | XML_PARSE_NOBLANKS);
    xmlNodePtr root = xmlDocGetRootElement(rawXmlDoc);
    xmlNodePtr rootXmlNode = xmlCopyNode(root, 1);
    xmlFreeDoc(rawXmlDoc);
    NSString *prettyString = nil;
    xmlBufferPtr dumpBuffer = xmlBufferCreate();
    rawXmlDoc = NULL;
    int rootLevel = 0;
    int prettyPrintedFormat = 1;
    int result = xmlNodeDump(dumpBuffer, rawXmlDoc, rootXmlNode, rootLevel, prettyPrintedFormat);
    if (result > -1) {
        prettyString = [[NSString alloc] initWithBytes:(xmlBufferContent(dumpBuffer)) length:(NSUInteger)(xmlBufferLength(dumpBuffer)) encoding:NSUTF8StringEncoding];
    }
    xmlBufferFree(dumpBuffer);
    NSCharacterSet *whitespaces = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [prettyString stringByTrimmingCharactersInSet:whitespaces];
}

@end
