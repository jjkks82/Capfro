#import <UIKit/UIKit.h>

// ---- تعطيل كشف Jailbreak ----
%hook IAPStoreManager
- (BOOL)isJailBreakDevice {
    return NO;
}
%end

// ---- تعطيل كشف حقن المكتبات (Injection Detection) ----
// الكلاسات المحتملة من النتائج: CommerceExportCheckInjection, ExportCheckInjectionResolver
%hook CommerceExportCheckInjection
- (BOOL)performCheck {
    return NO;
}
%end

%hook ExportCheckInjectionResolver
- (BOOL)resolve {
    return NO;
}
%end

// ---- تعطيل أي تحقق من التوقيع عبر SecKeyVerifySignature ----
// هذه دالة C، لكن يمكننا إحباطها عبر hook دالة الهدف التي تستدعيها
// سنفترض أن هناك كلاس وسيط مثل "CodeSignatureVerifier"
%hook CodeSignatureVerifier
- (BOOL)verifySignature {
    return YES; // دايماً ناجح
}
%end

// ---- تأمين إضافي: لو فيه دالة isEncrypted ترجع NO لتجنب مشاكل التشفير ----
%hook CapCut
- (BOOL)isEncrypted {
    return NO;
}
%end
