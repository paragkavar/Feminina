//
//  FemininaViewController.h
//  Feminina
//
//  Created by Patricia Daibes.
//  Modified by Cassio Diego Campos.
//  Copyright Favime 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface FemininaViewController : UIViewController <MFMailComposeViewControllerDelegate> {
	IBOutlet UIDatePicker *datePicker;
	IBOutlet UILabel *proximaData;
	IBOutlet UILabel *atualData;
	IBOutlet UILabel *ovulacao;
	IBOutlet UITextField *qtdCiclo;
	IBOutlet UIView   *about;
	
	NSString *proximoPeriodo;
	NSString *atualPeriodo; 
	NSString *proximaOvulacao;
	int ciclo;
}

@property(nonatomic,retain) UIDatePicker *datePicker;
@property(nonatomic,retain) UILabel *atualData;
@property(nonatomic,retain) UILabel *proximaData;
@property(nonatomic,retain) UILabel *ovulacao;
@property(nonatomic,retain) UITextField *qtdCiclo;
@property(nonatomic,retain) NSString *proximoPeriodo;
@property(nonatomic,retain) NSString *atualPeriodo;
@property(nonatomic,retain) NSString *proximaOvulacao;

-(IBAction)buttonPressed;
-(IBAction)backgroundClick:(id)sender;
-(IBAction)about:(id)sender;
-(IBAction)aboutBack:(id)sender;
-(IBAction)sendEmail;

@end

