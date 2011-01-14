//
//  FemininaViewController.m
//  Feminina
//
//  Created by Patricia Daibes.
//  Modified by Cassio Diego Campos.
//  Copyright Favime 2010. All rights reserved.
//

#import "FemininaViewController.h"

@implementation FemininaViewController


@synthesize datePicker;
@synthesize atualData;
@synthesize proximaData;
@synthesize ovulacao;
@synthesize qtdCiclo;
@synthesize proximoPeriodo;
@synthesize atualPeriodo;
@synthesize proximaOvulacao;


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		
    }
    return self;
}

-(IBAction)backgroundClick:(id)sender {
	[qtdCiclo resignFirstResponder];
}

-(IBAction)about:(id)sender {
	
	[self.view addSubview:about];
	
}

-(IBAction)aboutBack:(id)sender {

	[about removeFromSuperview];
}


-(IBAction)buttonPressed {
	//captura a data selecionada no picker
	NSDate *selected = [datePicker date];
	
	//start by retrieving day, weekday, month and year components for selected date
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDateComponents *selectedComponents = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:selected];
	NSInteger theDay = [selectedComponents day];
	NSInteger theMonth = [selectedComponents month];
	NSInteger theYear = [selectedComponents year];
	
	//now build a NSDate object for the input date using these components
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setDay:theDay]; 
	[components setMonth:theMonth]; 
	[components setYear:theYear];
	NSDate *thisDate = [gregorian dateFromComponents:components];
	[components release];
	
	//captura o numero de dias do ciclo (default = 28); e converte para inteiro usando intValue
	NSString *getCiclo = qtdCiclo.text;
	ciclo = [getCiclo intValue];
	
	//now build a NSDate object for next date (soma o numero de dias do ciclo a data inicial do ultimo periodo)
	NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
	[offsetComponents setDay:ciclo];
	NSDate *nextDate = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
	
	
	[offsetComponents setDay:14];
	NSDate *ovulation = [gregorian dateByAddingComponents:offsetComponents toDate:thisDate options:0];
	[offsetComponents release];
	
	[gregorian release];
	
	/*formatando as datas em MM/dd/YY */
	NSDateFormatter *atualDateFormatter = [[NSDateFormatter alloc] init];
	[atualDateFormatter setDateStyle:NSDateFormatterShortStyle];
	NSString *selectedDateFormatted = [atualDateFormatter stringFromDate:selected];
	atualData.text = selectedDateFormatted;
	atualPeriodo = selectedDateFormatted;
	
	NSDateFormatter *proximaDateFormatter = [[NSDateFormatter alloc] init];
	[proximaDateFormatter setDateStyle:NSDateFormatterShortStyle];
	NSString *nextDateFormatted = [proximaDateFormatter stringFromDate:nextDate];
	proximaData.text = nextDateFormatted;
	proximoPeriodo = nextDateFormatted;
	
	
	NSDateFormatter *ovulacaoDateFormatter = [[NSDateFormatter alloc] init];
	[ovulacaoDateFormatter setDateStyle:NSDateFormatterShortStyle];
	NSString *nextOvulationFormatted = [ovulacaoDateFormatter stringFromDate:ovulation]; 
	ovulacao.text = nextOvulationFormatted;
	proximaOvulacao = nextOvulationFormatted; 
	
	
	[atualDateFormatter release];
	[proximaDateFormatter release];
	[ovulacaoDateFormatter release];
	
}


-(IBAction)sendEmail {
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
	controller.mailComposeDelegate = self;
	[controller setSubject:NSLocalizedString(@"[Feminina] My next period",@"Titulo do email")];
	NSString *emailBody = [[NSString alloc] initWithFormat:NSLocalizedString(@"Last period: %@ \nNext period: %@ \nOvulation: %@ \n\nThanks for choosing Feminina. Please, send us your feedback on the App Store.",@"Mensagem do corpo do email"),atualPeriodo,proximoPeriodo,proximaOvulacao];
	[controller setMessageBody:emailBody isHTML:NO];
	[self presentModalViewController:controller animated:YES];
	[emailBody release];
	[controller release];
}


-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
	[self becomeFirstResponder];
	// Notifies users about errors associated with the interface
	switch (result)
	{
		case MFMailComposeResultCancelled:
			break;
		case MFMailComposeResultSaved:
			break;
		case MFMailComposeResultSent:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Export",@"Titulo do alerta") message:NSLocalizedString(@"Your e-mail has been sent", @"Mensagem do alerta")
														   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
			break;
		case MFMailComposeResultFailed:
			break;
			
		default:
		{
			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"Export",@"Titulo do alerta") message:NSLocalizedString(@"Sending failed!", @"Mensagem do alerta")
														   delegate:self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
			[alert show];
			[alert release];
		}
			
			break;
	}	
	[self dismissModalViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//inicia o picker com a data atual
    NSDate *now = [[NSDate alloc] init];
	[datePicker setDate:now animated:YES];
	[now release];
	
	[super viewDidLoad];
}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {

}


- (void)dealloc {
	
	[datePicker release];
	[atualData release];
	[proximaData release];
	[ovulacao release];
	[qtdCiclo release];
	[atualPeriodo release];
	[proximaOvulacao release];
	[proximoPeriodo release];
	[about release];
    [super dealloc];
}

@end

