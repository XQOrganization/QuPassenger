//
//  CitySelectVC.m
//  QuPassenger
//
//  Created by 朱青 on 2017/9/30.
//  Copyright © 2017年 com.Qyueche. All rights reserved.
//

#import "CitySelectVC.h"
#import "MJNIndexView.h"
#import "RegexKitLite.h"
#import "QuDBManager.h"
#import "CitySelectButton.h"
#import "CitySelectCell.h"
#import "UITableView+FooterBlank.h"

#define APPEND_CITY_STRING @"开通"
#define STANDARD_STRING @"ABCDEFGHIJKLMNOPQRSTUVWXYZ"

@interface CitySelectVC ()<UITableViewDataSource,UITableViewDelegate,MJNIndexViewDataSource,UITextFieldDelegate,UISearchDisplayDelegate>


@property (nonatomic, strong) NSMutableString *alphaString;    //索引显示字符串
@property (nonatomic, strong) NSMutableArray *sectionArray;    //列表显示数

@property (nonatomic, strong) NSArray *crayons;                //保留原始数据结果

// MJNIndexView
@property (nonatomic, strong) MJNIndexView *indexView;

@property (nonatomic, weak) IBOutlet UITableView *tableView;

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
// search
@property (weak, nonatomic) IBOutlet UITableView *searchTableView;

@property (nonatomic, strong) NSMutableArray *searchResultAry;   //搜索结果数组
@property (nonatomic, strong) NSString *searchString;            //搜索关键字

@property (nonatomic, strong) NSString *pinYinSearchString;      //拼音搜索关键字

@end

@implementation CitySelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
  
    [self tableAttribute];
    
    [self.searchTextField setDelegate:self];
    [self.searchTextField setBackgroundColor:HEXCOLOR(@"f2f2f2")];
    [self.searchTextField setCornerRadius:4.0f AndBorder:0.0f borderColor:nil];
    [self.searchTextField setLeftContentMarginWithMargin:10.0f];
    
    [self.tableView setTableFooterViewBlank];
    [self.searchTableView setTableFooterViewBlank];
    
    //初始化索引条
    self.indexView = [[MJNIndexView alloc]initWithFrame:CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
    self.indexView.backgroundColor = [UIColor redColor];
    self.indexView.dataSource = self;
    [self indexTalbeAttributesForMJNIndexView];
    [self.view addSubview:self.indexView];
    
    //UITextFiled输入监听
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFiledEditChanged:) name:UITextFieldTextDidChangeNotification
                                              object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationSuccessNotification:) name:LOCATION_SUCCESS_NOTIFICATION object:nil];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"CitySelectCell" bundle:nil] forCellReuseIdentifier:@"CitySelectCell"];
    
    [self.searchTableView registerNib:[UINib nibWithNibName:@"CitySelectCell" bundle:nil] forCellReuseIdentifier:@"CitySelectCell"];
    
}

#pragma mark--城市选择后的跳转
- (void)citySelectWithCityModel:(QuCityModel *)model
{
    
//    [[UnitMetiodManager share] setSELECT_CIYT:model.cityName];
//    [[UnitMetiodManager share] setSELECT_CODE:model.areaCode];
//    [[UnitMetiodManager share] setPROVINCE_CODE:model.provinceCode];
//    [[UnitMetiodManager share] setCITY_CODE:model.cityCode];
//
//    if (ACCOUNT.accountInfo) {
//        //如果是切换的是相同城市，则无任何操作
//        if ([model.cityName isEqualToString:ACCOUNT.accountInfo.cityName]) {
//            if (self.navigationController)
//            {
//              [self performSelector:@selector(rollOutSideBar) withObject:nil afterDelay:0.1];
//              [self dismissViewControllerAnimated:NO completion:nil];
//            }
//            return;
//        }
//
//        ACCOUNT.accountInfo.cityName = model.cityName;
//        ACCOUNT.accountInfo.areaCode = model.areaCode;
//        ACCOUNT.accountInfo.ll_m=model.provinceCode;
//        [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
//        //ACCOUNT.accountInfo.ProvinceCode =model.provinceCode;
//
//    }
//
//
//    //保存
//    NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithCapacity:2];
//    [dic setObject:model.cityName forKey:AREA_CITY];
//    [dic setObject:model.areaCode forKey:AREA_CODE];
//    [dic setObject:model.provinceCode forKey:@"PROVINCE_CODE"];
//    if (model.cityCode.length > 0) {
//        [dic setObject:model.cityCode forKey:@"CITY_CODE"];
//    }
//    [[NSFloderManager share]writeDataToFloder:dic withKey:CITY_SELECT_KEY];
//
//    if (self.selectComplete) {
//        self.selectComplete(model);
//    }


    [self.navigationController popViewControllerAnimated:YES];
    
}

//table属性
- (void)tableAttribute
{
    
    [self refreshTable];
}

//设置indexview属性
- (void)indexTalbeAttributesForMJNIndexView
{
    //点击index tableview是否跟着一起滑动
    self.indexView.getSelectedItemsAfterPanGestureIsFinished = NO;
    self.indexView.font = [UIFont systemFontOfSize:10.0f];
    self.indexView.selectedItemFont = [UIFont systemFontOfSize:40.0f];
    self.indexView.backgroundColor = [UIColor clearColor];
    //遮蔽物
    self.indexView.curtainColor = nil;
    self.indexView.curtainFade = 0.0;
    self.indexView.curtainMoves = YES;
//    self.indexView.ergonomicHeight = NO;
    //距离上边距边缘
    self.indexView.upperMargin = 44.0;
    //距离下边距边缘
    self.indexView.lowerMargin = 44.0;
    //距离右边距边缘
    self.indexView.rightMargin = 10.0;
    self.indexView.itemsAligment = NSTextAlignmentCenter;
    //扩展幅度
    self.indexView.maxItemDeflection = 50.0;
    self.indexView.rangeOfDeflection = 5;
    //非选择字体颜色
    self.indexView.fontColor = [UIColor colorWithHexString:@"404040"];
    //选择字体颜色
    self.indexView.selectedItemFontColor = [UIColor blackColor];
    self.indexView.darkening = NO;
    self.indexView.fading = YES;
    
}

//添加开通城市
- (NSArray *)addSupportCity
{
    
    QuCityModel *model = [[QuCityModel alloc]init];
 
    model.cityName = @"苏州";
    model.cityCode = @"320500";
    model.provinceCode = @"3200000";
    
    NSArray *array = [NSArray arrayWithObject:model];
    
    return array;
}

//添加定位城市
- (NSArray *)addLocationCity
{
    
    QuCityModel *model = [[QuCityModel alloc]init];
    
    model.cityName = @"苏州";
    model.cityCode = @"320500";
    model.provinceCode = @"320000";
    
    NSArray *array = [NSArray arrayWithObject:model];
    
    return array;
}

//属性table
- (void)refreshTable
{
    
    NSMutableArray *rawCrayons = [[QuDBManager shareDataManger]getTheCityAreaCodeWithProvinceCode:nil];
    
    self.searchResultAry = rawCrayons;
    self.crayons = rawCrayons;
    
    self.alphaString = [[NSMutableString alloc]initWithCapacity:0];
    self.sectionArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    NSArray *ary = [self addLocationCity];
    //添加定位城市
    if ([QuLocationManager shareManager].latitude.length > 0) {
        
        [self.sectionArray addObject:ary];
        [self.alphaString appendString:@"定位"];

                
    }
    else{
        QuCityModel *modelLocation = [[QuCityModel alloc]init];
        if([QuLocationManager shareManager].isLocating){
            modelLocation.cityName = @"正在定位";
            
        }
        else{
            modelLocation.cityName = @"定位失败，请点击重试";
            
        }
        NSArray *ary = [NSMutableArray arrayWithObject:modelLocation];
        [self.sectionArray addObject:ary];
        [self.alphaString appendString:@"定位"];

        
    }
    
    //添加开通城市
    NSArray *supportAry = [self addSupportCity];
    if ([supportAry count] > 0) {
        [self.sectionArray addObject:supportAry];
        [self.alphaString appendString:@",开通"];
    }
    
    //添加地市
    [self.sectionArray addObjectsFromArray:[self sortFirstLettersInArray:rawCrayons]];

    [self.tableView reloadData];
    [self.tableView reloadSectionIndexTitles];
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:[self.sectionArray count] -1] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

//匹配拼音搜索
- (NSMutableArray *)fifiterPinYinSearchResultWithStr:(NSString *)str
{
    NSMutableArray *temAry = [NSMutableArray arrayWithCapacity:0];
    NSArray *array;
    //判断是否从原始或者结果搜索中搜索 如果现在搜索的关键字长度小于原来保存的搜索关键字长度 则取原始数组
    if (self.searchString.length < str.length && self.searchString.length > 0) {
        array = [NSArray arrayWithArray:self.searchResultAry];
    }
    else{
        array = [NSArray arrayWithArray:self.crayons];
    }
    for (NSObject *obj in array) {
        QuCityModel *model = (QuCityModel *)obj;
        
        //取名字首字母 如石家庄 则取出SJZ
        NSString *firstPinYinName = [PublicManager getFirsrPingyinString:model.cityName];
        //取名字全拼  如石家庄 则取出SHIJIAZHUANG
        NSString *fullPinYinName = [PublicManager getFullPinyinString:model.cityName];
        //以下key为搜索结果中匹配到的关键字高亮显示 如搜索sh 则石高亮显示 如搜索sj 则石家高亮显示
        //先判断全拼是否以搜索关键字开头
        if ([fullPinYinName hasPrefix:[str uppercaseString]]) {
            
            [temAry addObject:model];
        }
        else{
            //否则判断是否首字母以搜索关键字开头
            if ([firstPinYinName hasPrefix:[str uppercaseString]]) {
                
                [temAry addObject:model];
            }
        }
        
    }
    return temAry;
}

//匹配搜索结果
- (NSMutableArray *)fifiterSearchResultWithStr:(NSString *)str
{
    NSMutableArray *temAry = [NSMutableArray arrayWithCapacity:0];
    NSArray *array;
    //判断是否从原始或者结果搜索中搜索  如果现在搜索的关键字长度小于原来保存的搜索关键字长度 则取原始数组
    if (self.searchString.length < str.length && self.searchString.length > 0) {
        array = [NSArray arrayWithArray:self.searchResultAry];
    }
    else{
        array = [NSArray arrayWithArray:self.crayons];
    }
    for (QuCityModel *model in array) {
        if ([model.cityName hasPrefix:str]) {
            [temAry addObject:model];
        }
    }
    return temAry;
}

# pragma mark data predicate
//根据索引字符串取索引数组
- (NSString *) firstLetter: (NSInteger) section
{
    NSArray *ary = [self.alphaString componentsSeparatedByString:@","];
    return [ary objectAtIndex:section];
}

- (NSMutableArray *) sortFirstLettersInArray:(NSArray *)categoryArray
{
    //创建包含26数组的数组
    NSMutableArray *existingLetters = [NSMutableArray array];
    //初始化数组
    for (NSInteger i = 0; i < STANDARD_STRING.length; i++) {
        NSMutableArray *rowArrays = [NSMutableArray array];
        [existingLetters addObject:rowArrays];
    }
    //整合数组归类 把所有城市按首字母放到对应的数组中
    for (QuCityModel *model in categoryArray) {
        if ([model.cityName isEqualToString:@"长沙"]) {
            NSLog(@"%@",model);
        }
        NSString *name = model.cityName;
        NSString *firstPinYinName = [PublicManager getFullPinyinString:name];//名字首字母
        if (firstPinYinName.length > 0) {
            //找出首拼音字母并大写
            firstPinYinName = [[firstPinYinName substringToIndex:1]uppercaseString];
        }
        NSRange range = [STANDARD_STRING rangeOfString:firstPinYinName];
        [existingLetters[range.location] addObject:model];
    }
    
    //去处无数据的数组
    NSArray *tempAry = [[NSArray alloc]initWithArray:existingLetters];
    NSMutableArray *tempReturnAry = [[NSMutableArray alloc]initWithCapacity:[tempAry count]];
    for (NSArray *array in tempAry) {
        if (array.count > 0) {
            [tempReturnAry addObject:array];
            NSInteger index = [tempAry indexOfObject:array];
            //找到有数组所对应的字母
            NSString *str = [STANDARD_STRING substringWithRange:NSMakeRange(index, 1)];
            if (self.alphaString.length != 0) {
                [self.alphaString appendString:@","];
            }
            [self.alphaString appendString:str];
        }
    }
    if ([self.alphaString hasPrefix:@","]) {
        self.alphaString=(NSMutableString*)[self.alphaString substringFromIndex:1];
    }
    return tempReturnAry;
}

# pragma mark TableView datasource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([tableView isEqual:self.searchTableView]) {
        return 1;
    }
    return [self.sectionArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if ([tableView isEqual:self.searchTableView]) {
        
        return 0;
        
    }
    else{
        
        if([[self firstLetter:section] isEqualToString:@"定位"]){
            
            return 10;
            
        }
        
    }
    return 20;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([tableView isEqual:self.searchTableView]) {
        
        return 44;
        
    }
    else{
        
        if([[self firstLetter:indexPath.section] isEqualToString:@"开通"])
        {
            NSInteger btCount = [(NSMutableArray*)self.sectionArray[indexPath.section] count];
            
            float cellHight = 10+50*ceilf(btCount/3.0);
            return cellHight;
        }
        else
        {
            return 44;
            
        }
        
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchTableView]) {
        if (self.searchString.length == 0) {
            return 0;
        }
        return [self.searchResultAry count];
    }
    if([[self firstLetter:section] isEqualToString:@"开通"])
    {
        return 1;
    }
    else
    {
        return [(NSMutableArray*)self.sectionArray[section] count];
    }
    
}


- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([tableView isEqual:self.searchTableView]) {
        return nil;
    }

    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_SIZE.width, 20)];
    bgView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    UILabel *labelHeaderView = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, SCREEN_SIZE.width, 20)];
    labelHeaderView.font = [UIFont systemFontOfSize:13.0f];
    
    if ([[self firstLetter:section]isEqualToString:@"开通"]){
        labelHeaderView.text = [NSString stringWithFormat:@"开通城市"];
    }
    else if ([[self firstLetter:section]isEqualToString:@"定位"]){
        labelHeaderView.text = [NSString stringWithFormat:@" "];
        bgView.frame= CGRectMake(0, 0, 0.1f, 10);
        labelHeaderView.frame= CGRectMake(0, 0, 0.1f, 0.1f);
    }
    else
    {
        labelHeaderView.text = [NSString stringWithFormat:@"%@",[self firstLetter:section]];
        
    }
    
    labelHeaderView.backgroundColor = [UIColor colorWithHexString:@"#f2f2f2"];
    labelHeaderView.textColor = [UIColor colorWithHexString:@"#777777"];
    [bgView addSubview:labelHeaderView];
    
    return bgView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([tableView isEqual:self.searchTableView]) {
        
        CitySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CitySelectCell"];

        NSObject *obj = [self.searchResultAry objectAtIndex:indexPath.row];
        
        QuCityModel *model = (QuCityModel *)obj;
        
        cell.nameLabel.text = [NSString stringWithFormat:@"%@",model.cityName];
        [cell.subLabel setHidden:YES];
        
        return cell;
    }
    else
    {
        
        if([[self firstLetter:indexPath.section] isEqualToString:@"开通"]){
            
            static NSString *identifier = @"HeaderSelectCell";
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (cell == nil) {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            cell.contentView.backgroundColor = [UIColor clearColor];
            cell.backgroundColor = [UIColor clearColor];
            
            for (UIView *view in [cell.contentView subviews]) {
                [view removeFromSuperview];
            }
            
            NSInteger btnCount = [(NSMutableArray*)self.sectionArray[indexPath.section] count];
            
            [cell.contentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
            
            for(int i = 0;i<btnCount;i++){
                CitySelectButton *tempBtn = [CitySelectButton buttonWithType:UIButtonTypeCustom];
                tempBtn.frame = CGRectMake(20 + (i%3) * ((SCREEN_SIZE.width-60)/3 + 10), 10+50*(i/3), (SCREEN_SIZE.width-60)/3-10, 40);
                [tempBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                tempBtn.titleLabel.font = [UIFont systemFontOfSize:15.0f];
                [tempBtn setCornerRadius:4.0f AndBorder:1.0f borderColor:HEXCOLOR(@"dbdbdb")];
                NSArray *currentItems = self.sectionArray[indexPath.section];
                QuCityModel *model = currentItems[i];
                [tempBtn setTitle:model.cityName forState:UIControlStateNormal];
                tempBtn.backgroundColor = [UIColor whiteColor];
                [tempBtn addTarget:self action:@selector(headercityBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                tempBtn.btnIndexpath = [NSIndexPath indexPathForRow:i inSection:indexPath.section];
                [cell.contentView addSubview:tempBtn];
            }
            return cell;
        }
        else{
     
            CitySelectCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CitySelectCell"];

            QuCityModel *model = [self categoryNameAtIndexPath:indexPath];
            
            cell.nameLabel.text = [NSString stringWithFormat:@"%@",model.cityName];
            
            if ([[self firstLetter:indexPath.section] isEqualToString:@"定位"]) {
                [cell.subLabel setHidden:NO];
                [cell.subLabel setText:@"当前定位城市"];
            }
            else{
                [cell.subLabel setHidden:YES];
            }
           
            return cell;
            
            
        }
        
    }
    
}

#pragma mark--选择城市响应事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WS(weakSelf)
    
    QuCityModel *model;
    if ([tableView isEqual:self.searchTableView]) {
        NSObject *obj = [self.searchResultAry objectAtIndex:indexPath.row];
        
        model = (QuCityModel *)obj;
        
    }
    else{
        model = [self categoryNameAtIndexPath:indexPath];
    }
    if([tableView isEqual:self.tableView])
    {
        if([[self firstLetter:indexPath.section] isEqualToString:@"开通"]){
            return;
        }
        
        if ([[self firstLetter:indexPath.section] isEqualToString:@"定位"]) {
            
            if([model.cityName isEqualToString:@"定位失败，请点击重试"]){
                if ([CLLocationManager locationServicesEnabled] &&
                    ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse
                     || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways)) {
                        //定位功能可用，开始定位
                        [[QuLocationManager shareManager]startUpdatingLocationWithSuccess:^(TencentLBSLocation *lbsLocation) {
                            
                            [weakSelf.tableView reloadData];
                            
                        } fail:^{
                            
                        }];
                        
                    }
                else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusDenied){
                    
                    
                    [QuHudHelper qu_showMessage:@"定位未开启，请到设置中开启定位"];
                    
                }
            }
            else{
                
                [self citySelectWithCityModel:model];
                
            }

        }
        
        
    }

    
    
    
}

#pragma mark MJMIndexForTableView datasource methods
- (NSArray *)sectionIndexTitlesForMJNIndexView:(MJNIndexView *)indexView
{
    NSArray *results = [self.alphaString componentsSeparatedByString:@","];
    return results;
}


- (void)sectionForSectionMJNIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:index] atScrollPosition: UITableViewScrollPositionTop animated:self.indexView.getSelectedItemsAfterPanGestureIsFinished];
}

#pragma mark UITextFieldDelegate
- (void)textFiledEditChanged:(NSNotification *)obj
{
    UITextField *textField = (UITextField *)obj.object;
    
    NSString *toBeString = textField.text;
    
    if (textField == self.searchTextField) {
        if (toBeString.length == 0) {
            
            [self.searchTableView setHidden:YES];
            [textField resignFirstResponder];
        }
        else{
         
            [self.searchTableView setHidden:NO];
            [self.view bringSubviewToFront:self.searchTableView];
            
            NSString *string = toBeString.trim;
            
            if (string.length > 0) {
                //如果是汉字搜索
                if ([string isMatchedByRegex:@"[\u4e00-\u9fa5]"]){
                    self.searchResultAry = [self fifiterSearchResultWithStr:string];
                    self.pinYinSearchString = @"";
                }
                else{
                    self.searchResultAry = [self fifiterPinYinSearchResultWithStr:string];
                }
                
                self.searchString = string;
                
                [self.searchTableView reloadData];
            }
            
        }
        
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

#pragma mark building sectionArray for the tableView
- (QuCityModel *)categoryNameAtIndexPath: (NSIndexPath *)path
{
    NSArray *currentItems = self.sectionArray[path.section];
    QuCityModel *model = currentItems[path.row];
    return model;
}

- (void)headercityBtnClick:(CitySelectButton *)sender
{
    QuCityModel *model = [self categoryNameAtIndexPath:sender.btnIndexpath];

    [self citySelectWithCityModel:model];

}

- (IBAction)closeClickAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)locationSuccessNotification:(NSNotification *)notifi
{
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
