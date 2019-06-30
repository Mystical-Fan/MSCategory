//
//  UICollectionView+EmptyData.h
//  com.westar.pdzw
//
//  Created by Fan on 2018/4/18.
//  Copyright © 2018年 Fan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionView (EmptyData)

- (void)collectionViewDisplayWitMsg:(NSString *) message ifNecessaryForRowCount:(NSUInteger) rowCount;

- (void)collectionViewDisplayWitImgName:(NSString *)imageName ifNecessaryForRowCount:(NSUInteger)rowCount;

@end
