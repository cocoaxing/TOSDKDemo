//
//  TOConstant.h
//  TOSDK
//
//  Created by TopOneAppleNo1 on 2020/2/21.
//  Copyright © 2020 TopOneAppleNo1. All rights reserved.
//

#import <UIKit/UIKit.h>
///////接口
UIKIT_EXTERN NSString *const TOSDK_Version;
UIKIT_EXTERN NSString *const TOSDK_Version_Name;
//生产测试标识
UIKIT_EXTERN BOOL const TO_RELEASE_FLAG;
//域名
UIKIT_EXTERN NSString *const AppDomain_Debug;
UIKIT_EXTERN NSString *const AppDomain_Release;
UIKIT_EXTERN NSString *const TO_Awqqc;
//子域名
UIKIT_EXTERN NSString *const SubAppDomain;
//秘钥
UIKIT_EXTERN NSString *const TO_SecretKey_Debug;
UIKIT_EXTERN NSString *const TO_SecretKey_Release;

UIKIT_EXTERN NSString *const FI_HQ_TX_ConfigList;

UIKIT_EXTERN NSString *const FI_QU_TX_SQ;

UIKIT_EXTERN NSString *const FI_HQ_YH_HB_Info;

UIKIT_EXTERN NSString *const FI_HQ_YH_HB_Info_List;

UIKIT_EXTERN NSString *const FI_HQ_TX_List;
//渠道Apph产品配置
UIKIT_EXTERN NSString *const FI_HQ_APP_ConfigInfo;
//用户信息数据
UIKIT_EXTERN NSString *const FI_GetSysUserInfo;
//用户身份ID绑定
UIKIT_EXTERN NSString *const FI_DoBindingUser;

UIKIT_EXTERN NSString *const FI_QU_JB_JL;

UIKIT_EXTERN NSString *const FI_QU_HB_LQ;

UIKIT_EXTERN NSString *const FI_GetJsonParam;
//初始化
UIKIT_EXTERN NSString *const FI_GetInitInfo;

UIKIT_EXTERN NSString *const FI_DoLogHis;

UIKIT_EXTERN NSString *const FI_DoCheckIn;

UIKIT_EXTERN NSString *const FI_DoDotAction;

UIKIT_EXTERN NSString *const FI_DoFeedbackInfo;

//存储
//用户id
UIKIT_EXTERN NSString *const TO_SYS_USER_ID;
//appId
UIKIT_EXTERN NSString *const TO_APP_ID;
//OPENID
UIKIT_EXTERN NSString *const TO_OPEN_ID;
//WX app id
UIKIT_EXTERN NSString *const TO_WX_APP_ID;
//wx secret key
UIKIT_EXTERN NSString *const TO_WX_SECRET_KEY;
//wx universal link
UIKIT_EXTERN NSString *const TO_WX_UNIVERSAL_LINK;
//jin bi
UIKIT_EXTERN NSString *const TO_STORE_GOLD;
//xin ren
UIKIT_EXTERN NSString *const TO_NEW_USER_FLAG;
//udid service
UIKIT_EXTERN NSString *const TO_UUID_SERVICE;
//udid key
UIKIT_EXTERN NSString *const TO_UUID_KEY;
UIKIT_EXTERN NSString *const TO_PRIVATE_POLICE;
UIKIT_EXTERN NSString *const TO_USER_TERM;
UIKIT_EXTERN NSString *const TO_TXWA_RULE;
UIKIT_EXTERN NSString *const TO_TXWA_TRAN_TIPS;
UIKIT_EXTERN NSString *const TO_TXWA_GONE_TIPS;
UIKIT_EXTERN NSString *const TO_TXWA_SIGNIN_TIPS;
UIKIT_EXTERN NSString *const TO_TRACE_ID;
UIKIT_EXTERN NSString *const TO_LOG_ENABLE;
UIKIT_EXTERN NSString *const TO_USE_SERVER;
UIKIT_EXTERN NSString *const TO_CURRENT_VC_CLASS;
UIKIT_EXTERN NSString *const TO_IMGS_RE;
UIKIT_EXTERN NSString *const TO_CAN_KAN;
UIKIT_EXTERN NSString *const TO_HONG_KAN;
UIKIT_EXTERN NSString *const TO_TITI;
UIKIT_EXTERN NSString *const TO_USER_NAME;
UIKIT_EXTERN NSString *const TO_USER_IMG_URL;
UIKIT_EXTERN NSString *const TO_USER_INFO;
UIKIT_EXTERN NSString *const TO_LEFT_RP;

UIKIT_EXTERN NSString *const TO_BB_LQ;
UIKIT_EXTERN NSString *const TO_BB_JB;
UIKIT_EXTERN NSString *const TO_BB_YE;
UIKIT_EXTERN NSString *const TO_BB_TX;
UIKIT_EXTERN NSString *const TO_BB_JE;
UIKIT_EXTERN NSString *const TO_BB_Q;
UIKIT_EXTERN NSString *const TO_BB_WX;
UIKIT_EXTERN NSString *const TO_BB_QB;
UIKIT_EXTERN NSString *const TO_BB_Y;
UIKIT_EXTERN NSString *const TO_BB_HB;
UIKIT_EXTERN NSString *const TO_BB_JL;
UIKIT_EXTERN NSString *const TO_BB_XJ;
UIKIT_EXTERN NSString *const TO_BB_ZH;
UIKIT_EXTERN NSString *const TO_BB_DL;
UIKIT_EXTERN NSString *const TO_BB_ZZ;
UIKIT_EXTERN NSString *const TO_BB_DZ;
UIKIT_EXTERN NSString *const TO_BB_YHK;
UIKIT_EXTERN NSString *const TO_BB_ISNEWUSER_TX;

UIKIT_EXTERN NSString *const TO_PP_TransferTips;
UIKIT_EXTERN NSString *const TO_PP_GoneMsg;
UIKIT_EXTERN NSString *const TO_PP_SiInMsg;
UIKIT_EXTERN NSString *const TO_PP_JB;
UIKIT_EXTERN NSString *const TO_PP_INC;
UIKIT_EXTERN NSString *const TO_PP_HeadImg;
UIKIT_EXTERN NSString *const TO_PP_Nickname;
UIKIT_EXTERN NSString *const TO_PP_OpenId;
UIKIT_EXTERN NSString *const TO_PP_UnionId;
UIKIT_EXTERN NSString *const TO_PP_LeftJB;
UIKIT_EXTERN NSString *const TO_PP_LeftRP;
UIKIT_EXTERN NSString *const TO_PP_NURP;
UIKIT_EXTERN NSString *const TO_PP_CurrentRP;

//打点
UIKIT_EXTERN NSString *const DO_WX_LOGIN_FAIL_SIGN;
UIKIT_EXTERN NSString *const DO_WX_LOGIN_FAIL_BOUND;
UIKIT_EXTERN NSString *const DO_IOS_COOR_CLICK;
UIKIT_EXTERN NSString *const DO_XJ_HB_LQ_CG_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_XR_HB_LQ_CG_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_XJ_HB_LQ_CG_POP;
UIKIT_EXTERN NSString *const DO_XR_HB_LQ_CG_POP;
UIKIT_EXTERN NSString *const DO_LJ_HB_CLOSE_BTN;
UIKIT_EXTERN NSString *const DO_LJ_HB_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_XJ_HB_CLOSE_BTN;
UIKIT_EXTERN NSString *const DO_XJ_HB_LQ_BTN;
UIKIT_EXTERN NSString *const DO_XR_HB_CLOSE_BTN;
UIKIT_EXTERN NSString *const DO_XR_HB_WX_LQ_BTN;
UIKIT_EXTERN NSString *const DO_XR_HB_POP;
UIKIT_EXTERN NSString *const DO_XJ_HB_POP;
UIKIT_EXTERN NSString *const DO_LJ_HB_POP;
UIKIT_EXTERN NSString *const DO_ME_LJTX_SIGN_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_ME_LJTX_NONELEFT_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_ME_LJTX_TX_CG_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_ME_LJTX_TX_WXDL_BTN;
UIKIT_EXTERN NSString *const DO_ME_XJHB_YEBZ_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_ME_TXJB_YEBZ_JXZQ_BTN;
UIKIT_EXTERN NSString *const DO_ME_LJTX_SIGN_POP;
UIKIT_EXTERN NSString *const DO_ME_LJTX_NONELEFT_POP;
UIKIT_EXTERN NSString *const DO_ME_LJTX_CG_POP;
UIKIT_EXTERN NSString *const DO_ME_WXDL_POP;
UIKIT_EXTERN NSString *const DO_ME_XJHB_YEBZ_POP;
UIKIT_EXTERN NSString *const DO_ME_TXJB_YEBZ_POP;
UIKIT_EXTERN NSString *const DO_ME_LJTX_BTN;
UIKIT_EXTERN NSString *const DO_ME_TXMX_BTN;
UIKIT_EXTERN NSString *const DO_ME_XJHB_BTN;
UIKIT_EXTERN NSString *const DO_ME_TXJB_BTN;
UIKIT_EXTERN NSString *const DO_ME_POP;




///活动类型
typedef enum : NSUInteger {
    TO_TYPE_NORMAL_TX = 1,
    TO_TYPE_CASH_TX = 2,
    TO_TYPE_RED_RECEIVE_NEW_USER = 3,
    TO_TYPE_RED_RECEIVE_NORMAL = 4
} TO_TYPE;
