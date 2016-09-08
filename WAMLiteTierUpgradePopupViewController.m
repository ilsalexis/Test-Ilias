//
//  WAMLiteTierUpgradePopupViewController.m
//  WorkAngel
//
//  Created by Ilias Alexopoulos on 24/03/2016.
//  Copyright © 2016 WorkAngel Technology. All rights reserved.
//

#import "WAMLiteTierUpgradePopupViewController.h"
#import "ConstraintPack.h" //NEVER USE THIS CONSTRAINTS PACK
#import "ALView+WAM.h"
#import "UIColor+WAMColours.h"
#import "UIFont+WAMFont.h"
#import "WAMNavigationBarView.h"

@interface WAMLiteTierUpgradePopupViewController () <
                                                    UIScrollViewDelegate
                                                    >
@property (nonatomic) BOOL showViewForUpgrade;
@property (nonatomic, strong) NSMutableArray *autolayoutConstraints;
@property (nonatomic, strong) WAMNavigationBarView *navBarView;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView *headerImageView;


@end

@implementation WAMLiteTierUpgradePopupViewController

#pragma mark - Initialization

- (instancetype)initWithUpgradeStatus:(BOOL)showViewForUpgrade
{
    self = [self init];
    if (self) {
        _showViewForUpgrade = showViewForUpgrade;
        _autolayoutConstraints = [NSMutableArray array];

    }
    
    return self;
}

#pragma mark - View Life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorTheme].bg_main;
    [self.view addSubview:self.navBarView];
    [self.view addSubview:self.scrollView];

    InstallConstraints(self.autolayoutConstraints, LayoutPriorityRequired, NSStringFromClass([self class]));

}

#pragma mark - Getters

- (UIScrollView *)scrollView
{
    if (_scrollView) {
        return _scrollView;
    }
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    [_scrollView addSubview:self.headerImageView];
    //[_scrollView addSubview:self.tableView];
    
    PREPCONSTRAINTS(_scrollView);
    [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_LEFT(self.view, _scrollView, 0.0f)]; // x
    [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_TOP(self.navBarView, _scrollView, 64.0f)]; // y
    [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_RIGHT(self.view, _scrollView, 0.0f)]; // w
    [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_BOTTOM(self.view, _scrollView, 0.0f)]; // h
    
    return _scrollView;
}

-(UIImageView *)headerImageView{
    if (!_headerImageView) {
    _headerImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    _headerImageView.contentMode = UIViewContentModeScaleAspectFit;
        [_headerImageView setImage:[UIImage imageNamed:@"illu_premium"]];
        PREPCONSTRAINTS(_headerImageView);
    [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_TOP(self.scrollView, _headerImageView, 0)];
        [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_CENTERX(self.scrollView, _headerImageView, 0)];
    }

return _headerImageView;
}


- (WAMNavigationBarView *)navBarView
{
    if (!_navBarView) {
        _navBarView = [[WAMNavigationBarView alloc] initWithFrame:CGRectZero];
        _navBarView.backgroundColor = [UIColor colorTheme].bg_navigation_bar;
        _navBarView.titleLabel.text = self.showViewForUpgrade?NSLocalizedString(@"WAMLiteTierUpgradeTitle", nil):NSLocalizedString(@"WAMLiteTierDowngradeTitle",nil) ;
        _navBarView.titleLabel.font = [UIFont fontTheme].headline_semibold;

        
        [_navBarView.leftButton setTitleColor:[UIColor colorTheme].text_action forState:UIControlStateNormal];
        [_navBarView.leftButton setImage:[UIImage imageNamed:@"ic_close"] forState:UIControlStateNormal];
        [_navBarView.leftButton addTarget:self action:@selector(p_cancelButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
        
        CGFloat navBarHeight = 64;
        
        PREPCONSTRAINTS(_navBarView);
       
        [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_TOP(self.view, _navBarView, 0)];
        [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_LEFT(self.view, _navBarView, 0)];
        [self.autolayoutConstraints addObject:CONSTRAINT_ALIGNING_PAIR_RIGHT(self.view, _navBarView, 0)];
        [self.autolayoutConstraints addObject:CONSTRAINT_SETTING_HEIGHT(_navBarView, navBarHeight)];
        
    }
    
    return _navBarView;
}

#pragma mark - Private methods

- (void)p_cancelButtonPressed:(UIBarButtonItem *)sender
{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    } else if (self.presentingViewController) {
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];


}

@end
