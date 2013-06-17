//
//  DAFriendViewController.h
//  tribe
//
//  Created by 李 林 on 2012/11/27.
//  Copyright (c) 2012年 dac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TribeSDK/TribeSDKHeader.h>
#import "DABaseViewController.h"

@interface DAMemberViewController : DABaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchDisplayDelegate, UISearchBarDelegate>
{
    NSArray			*listContent;			// The master content.
	NSMutableArray	*filteredListContent;	// The content filtered as a result of a search.
	
	// The saved state of the search UI if a memory warning removed the view.
    NSString		*savedSearchTerm;
    NSInteger		savedScopeButtonIndex;
    BOOL			searchWasActive;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;



@property (nonatomic, retain) NSArray *listContent;
@property (nonatomic, retain) NSMutableArray *filteredListContent;

@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *barFilterIco;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *barFilter;

- (IBAction)barFilterOnClick:(id)sender;
- (IBAction)barFilterIcoOnClick:(id)sender;
@end
