import os
from google.colab import files

print("1. اضغط على الزر بالأسفل لرفع ملف الـ CapCut.ipa من جهازك:")
# سطر الرفع المباشر
uploaded = files.upload()

# الحصول على اسم الملف المرفوع تلقائياً
for file_name in uploaded.keys():
    if file_name.endswith('.ipa'):
        print(f"\n[+] تم رفع الملف بنجاح: {file_name}")
        
        # تغيير امتداد الملف إلى zip لفك ضغطه ومعاينته
        zip_name = file_name.replace('.ipa', '.zip')
        os.rename(file_name, zip_name)
        print(f"[+] تم تحويل الامتداد إلى زيب للتحضير: {zip_name}")
        
        print("\n2. جاري تجهيز رابط تحميل مباشر مؤقت للملف عبر سيرفر آمن...")
        # استخدام سيرفر transfer.sh لرفع الملف ونشر رابط تحميل مباشر لك ولـ GitHub
        print("[*] جاري الرفع، فضلاً انتظر ثواني...")
        os.system(f"curl --upload-file ./{zip_name} https://transfer.sh/{zip_name} > link.txt")
        
        # قراءة الرابط وعرضه
        with open("link.txt", "r") as f:
            download_url = f.read().strip()
        
        print("\n" + "="*50)
        print("🎯 هذا هو رابط الملف المنشور (جاهز للاستخدام):")
        print(download_url)
        print("="*50)
    else:
        print("\n❌ خطأ: يرجى التأكد من رفع ملف ينتهي بامتداد .ipa فقط!")