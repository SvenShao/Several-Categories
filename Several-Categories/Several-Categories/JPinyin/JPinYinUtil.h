//
//  JPinYinUtil.h
//  JuuJuu
//
//  Created by xiaoguang.huang on 11-6-26.
//  Copyright 2011 长沙果壳. All rights reserved.
//

#import <Foundation/Foundation.h>

//带声调的拼音（比如曾祖父:[ceng2,zeng1]）
extern NSArray *pinYinWithTone(unichar ch_chr);

//带声调的拼音（如果遇到！@#￥%等非26个字母皆为#）
extern NSArray *pinYinWithToneOnlyLetter(unichar chr);

//不带声调的拼音（比如曾祖父:[ceng,zeng]）
extern NSArray *pinYinWithoutTone(unichar ch_chr);

//不带声调的拼音（如果遇到！@#￥%等非26个字母皆为#）
extern NSArray *pinYinWithoutToneOnlyLetter(unichar chr);