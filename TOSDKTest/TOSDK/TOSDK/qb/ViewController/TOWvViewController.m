//
//  TOWvViewController.m
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/27.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import "TOWvViewController.h"
#import "TOHeader.h"
#import "UIImage+Extension.h"
#import "UIView+TOExtension.h"
#import "NSString+Extension.h"


@interface TOWvViewController ()
@end

#define LeftMargin 15

@implementation TOWvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //顶部导航背景
    UIImageView *topNaviIv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, TO_Width, TOPVIEWHEIGHT)];
    topNaviIv.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:topNaviIv];
    UIImage *img = [UIImage imageInBundleWithName:@"状态栏.png" class:[self class]];
    topNaviIv.image = img;
    
    //标题
    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, STATUSHEIGHT + 2, TO_Width, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.font = [UIFont systemFontOfSize:20];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = self.title;
    [self.view addSubview:titleLabel];
    
    //返回按钮
    UIImage *backImg = [UIImage imageInBundleWithName:@"返回.png" class:[self class]];
    UIButton *backBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backBtn.frame = CGRectMake(LeftMargin, STATUSHEIGHT + 2, 20, 40);
    [backBtn setImage:backImg forState:(UIControlStateNormal)];
    [backBtn addTarget:self action:@selector(clickBack) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_shoot_turnback_w"] style:(UIBarButtonItemStylePlain) target:self action:@selector(clickBack)];
    
    NSString *policy = @"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /></head><body><div style=\"width:60%;margin:0 auto;padding:0 auto\"><h3 style=\"text-align:center\">隐私政策</h3><br /><br /><b>以此声明对用户隐私保护的许诺。隐私声明正在不断改进中，随着服务范围的扩大，会随时更新隐私声明。我们欢迎您随时查看隐私声明。<br /><br />隐私政策<br />【注意】尊重用户个人隐私是我们的一项基本政策。<br />为保障用户（下称“用户”）的隐私权、规范对用户个人信息的利用，特制定本政策。<br />请用户仔细阅读以下全部内容。如用户不同意本政策的任意内容，请不要注册或使用服务，否则将视为自愿接受本协议的全部约定。<br />如用户注册通过，即表示用户与我们已达成协议，自愿接受本政策的所有内容。此后，用户不得以未阅读本政策的内容作任何形式的抗辩。<br /><br /><br />“隐私”是指用户在注册帐号时提供给我们的个人身份信息，包括用户注册资料中手机号码、用户身份信息等。我们一贯积极地采取技术与管理等合理措施保障用户帐号的安全、有效； 我们将善意使用收集的信息，采取各项有效且必要的措施以保护您的隐私安全，并使用商业上合理的安全技术措施来保护您的隐私不被未经授权的访问、使用或泄漏。<br /><br /><br /><br />为服务用户的目的，我们可能通过使用用户的个人信息向用户提供服务，包括但不限于向用户发出产品和服务信息，或者与我们合作伙伴共享信息以便他们向用户发送其相关产品和服务的信息，我们共享您的信息时，我们会督促关联公司、联盟成员、合作伙伴或其他受信任的第三方供应商、服务商及代理商遵守隐私政策并要求其采取相关的保密和安全措施来处理上述信息。我们可能会与第三方合作向用户提供相关的网络服务，在此情况下，如该第三方同意承担与我们同等的保护用户隐私的责任，则我们有权将用户的注册资料等提供给该第三方。在不透露单个用户隐私资料的前提下，我们有权对整个用户数据库进行分析并对用户数据进行商业上的利用。<br /><br />我们承诺将善意使用其个人信息，我们将不会以任何其他方公开用户注册资料的中手机号码、收货地址等个人身份信息，但下列情况除外：<br />（1）用户或用户监护人授权我们披露的；<br />（2）根据法律的有关规定，或者行政或司法机构的要求，基于法定程序向第三方或者行政、司法机构披露的；<br />（3）同玩科技为了维护自己合法权益而向用户提起诉讼或者仲裁时；<br />（4）为提供你所要求的产品和服务，而必须和第三方分享用户的个人信息；<br />（5）如果用户出现违反中国有关法律或者互联网政策的情况，需要向第三方披露 ；<br />（6）其他同玩科技根据法律和平台政策认为合适的披露。<br />为服务用户的目的，我们将会获取用户手机上的应用列表，用户确认并同意同玩科技的该项行为，在此我们承诺不会将用户的该项信息非法使用，进行合理使用并严格遵守上述规定保护用户的该项隐私。<br />使用说明您在使用本软件及服务过程中，可能需要提供一些必要的信息，例如手机号码等。若国家法律法规或政策有特殊规定的，您需要提供真实的身份信息。若您提供的信息不完整，则无法使用本服务或在使用过程中受到限制。<br />一般情况下，您可随时浏览自己提交的信息，但出于安全性和身份识别的考虑，您可能无法修改注册时提供的初始信息及其他验证信息。<br />我们非常重视对未成年人个人信息的保护。</div></body></html>";
    
    NSString *userAgree = @"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /></head><body><div style=\"width:60%;margin:0 auto;padding:0 auto\"><h3 style=\"text-align:center\">用户协议</h3><br /><br /><b>本服务协议是由用户（您）与我们签订，双方遵照执行。<br /><br />移动应用APP所提供的各项服务和内容的所有权和运作权均归我们所有。如果您在本网站及其移动应用上访问、使用我们的产品或服务（以上统称为“服务”），您便接受了以下服务协议，请仔细阅读以下内容并确保正确理解，在您执行注册、支付、账户关联，或购买等任何操作之前，请仔细阅读以下协议，本服务协议对您及软件均具有法律效力。如果您不同意以下任何内容，请立刻停止访问本网站或使用本网站服务。<br />1. 服务条款的确认和接纳软件的所有权和经营管理权归我们所有。<br />用户必须同意接受指定的服务条款并完成相应的流程，才能成为用户，并获得软件的使用权。<br />2. 服务开通及终止<br />（1）用户接受指定的服务条款并完成相应的程序后（例如，点击按钮上书写“同意《用户协议》”或类似文字，且页面上同时列明了本协议的内容或者可以有效展示本协议内容的链接；或您下载、安装、获取激活、登录含服务内容的软件并使用服务），便成为合法用户。<br />（2）用户若有任何违反本协议或相关法规的规定，我们有权视用户的行为性质，在不事先通知用户的情况下，采取包括但不限于中断使用许可、限制使用、中止或终止软件服务、追究法律责任等措施，若因此造成我们或他人损失的，用户应予赔偿。<br /><br />3. 服务条款的修改<br />我们有权在必要时对软件的相关服务条款（包括但不限于本服务条款）进行修改，包括但不限于对软件的服务规则进行调整。用户若需继续使用软件服务，视为对前述修改的接受、认可。<br />4. 关于用户资料<br />我们重视对用户的隐私保护，用户向为您提供身份的资料后，可能不时收到消息推送、电子邮件及直销邮件，内含推广产品或服务等资料。若用户不想收到此等资料，请致函我们客服中心。<br />5. 用户的账号，密码和安全性<br />用户应妥善保管账号和密码，同时对账号和密码安全承担完全责任。每个用户都要对其在软件中的所有内容负完全责任。用户若发现有自己的账号被他人非法使用或存在安全漏洞的情况，应立即通知我们<br />6. 服务风险制度<br />使用软件服务的用户自行承担全部风险。我们不对提供的服务作任何明示或暗示的保证，同时亦不对商业性的隐含担保，特定目的和不违反规定的适当担保作限制。包括：不担保服务一定能满足用户的要求，不担保服务不会中断，及对服务的及时性、安全性、出错或文件丢失的发生不承担任何赔偿责任。<br />7. 保障<br />用户同意保障和维护全体用户和软件的利益，并承诺独立承担由自身行为导致的一切后果及损失。<br />8. 结束服务<br />用户须明白，本服务仅依其当前所呈现的状况提供，本服务涉及到互联网及移动通讯等服务，可能会受到各个环节不稳定因素的影响。因此服务存在因上述不可抗力、计算机病毒或黑客攻击、系统不稳定、用户所在位置、用户关机、GSM网络、互联网络、通信线路、政策法规原因等造成的服务中断或不能满足用户要求的风险。开通服务的用户须承担以上风险，软件和合作公司对服务之及时性、安全性、准确性不作担保，对因此导致用户不能发送和接受阅读消息、或传递错误，个人设定之时效、未予储存或其他问题不承担任何责任。<br />如步软件的系统发生故障影响到本服务的正常运行，我们承诺在第一时间内与相关单位配合，及时处理进行修复。但用户因此而产生的经济损失，我们不承担责任。此外，我们保留不经事先通知为维修保养、升级或其他目的暂停本服务任何部分的权利。<br />用户若反对任何服务条款、或对后来的条款修改有异议，或对软件公司提供的服务不满，用户可选择：<br />9. 服务条款的确认和接纳<br />用户确认已仔细阅读了本服务条款，接受我们软件服务条款全部内容，成为软件的正式用户。用户在享受我们软件服务时必须完全、严格遵守本服务条款。<br />10. 声明<br />我们有权解释相关条款。用户同意：我们为了保障公司业务发展和调整的自主权，我们有权无需通知用户而随时修改、中止、中断或终止给用户提供的服务，若因步我们的前述行为造成用户或他人损失的，我们无需承担任何赔偿等责任。<br />为服务用户的目的，同玩科技将会获取用户手机上的应用列表，用户确认并同意同玩科技的该项行为，在此同玩科技承诺不会将用户的该项信息非法使用，进行合理使用并严格遵守上述规定保护用户的该项隐私。<br /><br /><h4>使用说明</h4>您在使用本软件及服务过程中，可能需要提供一些必要的信息，例如手机号码等。若国家法律法规或政策有特殊规定的，您需要提供真实的身份信息。若您提供的信息不完整，则无法使用本服务或在使用过程中受到限制。<br />11. 适用法律<br />本服务条款的解释，效力及纠纷的解决，适用于中华人民共和国大陆地区法律、法规。若用户和我们之间发生任何纠纷或争议，首先应友好协商解决，协商不成的，用户在此完全同意将纠纷或争议提交我们所在地广州市海珠区人民法院管辖。<br /><br />12. 其他<br />用户对服务之任何部分或本服务条款的任何部分之意见及建议可通过客户服务部门与我们联系。<br /></div></body></html>";
    
    NSString *tx = _NSStringFromBbString(TO_BB_TX);
    NSString *xj = _NSStringFromBbString(TO_BB_XJ);
    NSString *wx = _NSStringFromBbString(TO_BB_WX);
    NSString *zz = _NSStringFromBbString(TO_BB_ZZ);
    NSString *qb = _NSStringFromBbString(TO_BB_QB);
    NSString *q = _NSStringFromBbString(TO_BB_Q);
    NSString *je = _NSStringFromBbString(TO_BB_JE);
    NSString *dz = _NSStringFromBbString(TO_BB_DZ);
    NSString *yhk = _NSStringFromBbString(TO_BB_YHK);
    NSString *rule = [NSString stringWithFormat:@"<html><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\"><meta name=\"viewport\" content=\"width=device-width,initial-scale=1\" /></head><body><div style=\"width:60%%;margin:0 auto;padding:0 auto\"><h3 style=\"text-align:center\">%@规则</h3><br /><br /><br />1.%@将在1-3个工作日审批%@，请耐心等待<br /><br />2.%@%@将通过%@直接%@给您，%@需要要求您绑定的%@号已通过实名认证并有绑定有效的%@等证件，如%@号未满足上述要求将会导致%@失败，请在%@前确认绑定%@的情况<br /><br />3.%@到账查询：打开%@，我的-%@-零%@-零%@明细，%@的明细，即为成功%@<br /><br />4.我们仅支持可选%@%@额度的提现，更多的使用我们APP将会更快达到我们的%@额度，也希望您在我们的APP中玩得开心<br /><br />5.1个用户只能绑定1个%@号、设备、手机号、身份证<br /><br />6.存在作弊行为的用户，我们有权审核为不通过</div></body></html>", tx, tx, dz, tx, xj, wx, zz, zz, wx, wx, yhk, tx, tx, wx, wx, wx, qb, q, q, tx, dz, tx, je, tx, wx];
    
    NSString *attStr = rule;
    if (self.type == 1) {
        attStr = policy;
    }
    if (self.type == 2) {
        attStr = userAgree;
    }
    NSAttributedString *att = [[NSAttributedString alloc]initWithData:[attStr dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute : NSHTMLTextDocumentType} documentAttributes:nil error:nil];
    UITextView *tv = [[UITextView alloc]initWithFrame:CGRectMake(0, TOPVIEWHEIGHT, TO_Width, TO_Height - TOPVIEWHEIGHT)];
    tv.editable = NO;
    tv.selectable = NO;
    tv.attributedText = att;
    [self.view addSubview:tv];
    
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)clickBack {
    [self.navigationController popViewControllerAnimated:YES];
    if (self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

@end
