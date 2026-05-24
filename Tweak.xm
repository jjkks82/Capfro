#import <substrate.h>
#import <objc/runtime.h>

#pragma mark - ==========================================
#pragma mark - AIGCVipManager — كل دوال VIP الأساسية
#pragma mark - ==========================================

%hook AIGCVipManager

// --- جميع الـ BOOL Properties ترجع YES ---
- (BOOL)isVIP { return YES; }
- (BOOL)isVip { return YES; }
- (BOOL)_isVip { return YES; }
- (BOOL)_isVIP { return YES; }

- (BOOL)isPro { return YES; }
- (BOOL)isProOn { return YES; }
- (BOOL)isVipHis { return YES; }
- (BOOL)isVipLimitFree { return YES; }
- (BOOL)isVipMaterialDraft { return YES; }
- (BOOL)isVipMemberQueryBlock { return YES; }
- (BOOL)isVipOrg { return YES; }
- (BOOL)isProtectSvipAvailable { return YES; }
- (BOOL)isPromotionalOffer { return YES; }
- (BOOL)isPromoteNewUser { return YES; }

// --- Product Mode نخليه NO عشان ما ينكشف ---
- (BOOL)isProductMode { return NO; }
- (BOOL)isProd { return NO; }

// --- vipStatus نجعله 1 (active) أو 2 (trial) ---
- (NSInteger)vipStatus { return 1; }

// --- منع تحديث الحالة ---
- (void)vipStatusChange { /* nothing */ }
- (void)vipStatusUpdate { /* nothing */ }
- (void)updateAllMaterialFeatureStatusWithVipStatus:(NSInteger)status { /* nothing */ }

// --- منع السينك مع السيرفر ---
- (void)syncVIPStatus { /* nothing */ }
- (void)syncVipMember { /* nothing */ }

// --- التحقق السحابي ---
- (BOOL)checkCloudLicense { return YES; }
- (BOOL)checkLocalLicense { return YES; }
- (BOOL)verifyToken { return YES; }
- (BOOL)validateSubscription { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - AdSubscriptionManager — الإعلانات والاشتراكات
#pragma mark - ==========================================

%hook AdSubscriptionManager

- (BOOL)isVIP { return YES; }
- (BOOL)isVip { return YES; }
- (BOOL)isPro { return YES; }
- (BOOL)hasPurchased { return YES; }
- (BOOL)isSubscribed { return YES; }
- (BOOL)isPremium { return YES; }
- (BOOL)isPaidUser { return YES; }
- (NSInteger)subscriptionStatus { return 1; } // Active

// منع التحقق من الإيصال
- (BOOL)validateReceipt { return YES; }
- (BOOL)verifyReceiptWithData:(id)data { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - VIPSubscriptionManager (إن وجد)
#pragma mark - ==========================================

%hook VIPSubscriptionManager

- (BOOL)isVIP { return YES; }
- (BOOL)isValidSubscription { return YES; }
- (BOOL)isSubscriptionActive { return YES; }
- (NSInteger)subscriptionStatus { return 1; }

%end

#pragma mark - ==========================================
#pragma mark - SubscriptionManager (العام)
#pragma mark - ==========================================

%hook SubscriptionManager

- (BOOL)isSubscribed { return YES; }
- (BOOL)hasActiveSubscription { return YES; }
- (BOOL)isPremiumUser { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - WatermarkGenerator — العلامة المائية
#pragma mark - ==========================================

%hook WatermarkGenerator

// خاصية تفعيل العلامة — نخليها NO
- (BOOL)isWatermarkEnabled { return NO; }

// دالة التوليد — نلغيها
- (void)generate { /* nothing — لا توليد */ }
- (void)generateWatermark { /* nothing */ }

// لو كانت ترجع CALayer — نخليها nil
- (id)generateWatermarkLayer { return nil; }
- (id)generateWatermarkLayerWithVideoSize:(CGSize)size { return nil; }

// أي Bool خاص بالعلامة المائية
- (BOOL)shouldApplyWatermark { return NO; }
- (BOOL)canRemoveWatermark { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - ExportManager — التصدير
#pragma mark - ==========================================

%hook ExportManager

- (BOOL)canExport4K { return YES; }
- (BOOL)canExport60fps { return YES; }
- (BOOL)canExportWithoutWatermark { return YES; }
- (BOOL)canExportHighBitrate { return YES; }
- (BOOL)isExportRestricted { return NO; }
- (BOOL)hasExportPermission { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - TemplateManager — القوالب
#pragma mark - ==========================================

%hook TemplateManager

- (BOOL)canUsePremiumTemplate { return YES; }
- (BOOL)isTemplatePremium { return NO; }  // كل القوالب تصير مجانية
- (BOOL)isTemplateVIP { return NO; }
- (BOOL)isTemplatePro { return NO; }
- (BOOL)hasAccessToAllTemplates { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - EffectsManager — التأثيرات
#pragma mark - ==========================================

%hook EffectsManager

- (BOOL)isEffectPremium { return NO; }
- (BOOL)isEffectPro { return NO; }
- (BOOL)isEffectVIP { return NO; }
- (BOOL)canUseProEffect { return YES; }
- (BOOL)canUsePremiumEffect { return YES; }
- (BOOL)hasUnlimitedEffectAccess { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - LicenseManager — الترخيص
#pragma mark - ==========================================

%hook LicenseManager

- (BOOL)isVIP { return YES; }
- (BOOL)isPro { return YES; }
- (BOOL)isLicenseValid { return YES; }
- (BOOL)checkLicense { return YES; }
- (BOOL)verifyLicense { return YES; }

%end

#pragma mark - ==========================================
#pragma mark - الـ Constructor — تأكيد التفعيل
#pragma mark - ==========================================

%ctor {
    NSLog(@"[CapCutVIP] Tweak loaded successfully!");
    
    // حاول نمسك الكلاسات ونتأكد إنها موجودة
    Class vipClass = objc_getClass("AIGCVipManager");
    Class adClass = objc_getClass("AdSubscriptionManager");
    Class licenseClass = objc_getClass("LicenseManager");
    
    if (vipClass) {
        NSLog(@"[CapCutVIP] ✅ AIGCVipManager found and hooked");
    } else {
        NSLog(@"[CapCutVIP] ❌ AIGCVipManager NOT found — check class name");
        // محاولة إيجاد الكلاس بالاسم الكامل الـ Swift-mangled
        Class swiftVipClass = objc_getClass("_TtC14LVEditorEffect14AIGCVipManager");
        if (swiftVipClass) {
            NSLog(@"[CapCutVIP] ✅ Found via Swift mangled name!");
        }
    }
    
    if (adClass) NSLog(@"[CapCutVIP] ✅ AdSubscriptionManager found");
    if (licenseClass) NSLog(@"[CapCutVIP] ✅ LicenseManager found");
    
    // تأكيد للمستخدم
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"🔓 CapCut VIP Unlocked" 
                                                                       message:@"All premium features activated!\n✓ All effects\n✓ All templates\n✓ No watermark\n✓ 4K Export\n✓ No ads" 
                                                                preferredStyle:UIAlertControllerStyleAlert];
        
        UIViewController *rootVC = [UIApplication sharedApplication].keyWindow.rootViewController;
        if (rootVC) {
            [rootVC presentViewController:alert animated:YES completion:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
                    [alert dismissViewControllerAnimated:YES completion:nil];
                });
            }];
        }
    });
}
