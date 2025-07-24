
# 🩸 Kan Bankası Yönetim Sistemi (Blood Bank Management System)

## 📌 Proje Tanımı
Kan Bankası Yönetim Sistemi, kan bağış sürecinin uçtan uca takibini, stok yönetimini ve hastane taleplerinin karşılanmasını sağlayan kapsamlı bir SQL tabanlı veri tabanı projesidir. Sistem, bağışçı kayıtlarından hastane taleplerine kadar tüm süreçleri entegre bir şekilde yönetir.

Bu sistem; hem bağışçıların durumunu izlemeyi, hem de kan talep eden hastanelerin ihtiyaçlarına hızlı ve güvenli yanıt vermeyi amaçlar. Aynı zamanda kritik kan gruplarının stok takibi ve otomasyon desteği ile gerçek hayattaki kriz yönetimi senaryolarını da destekler.

## 🗂️ Kullanılan Tablolar
- **Donors**: Bağışçılara ait kimlik bilgileri, yaş, kan grubu ve bulaşıcı hastalık durumu gibi kritik bilgileri içerir.
- **Recipients**: Kan alıcılarının isim, yaş ve kan grubu bilgilerini içerir.
- **Hospitals**: Hastanelerin adı, adresi ve iletişim bilgileri tutulur.
- **BloodUnits**: Bağışçıdan alınan her bir kan ünitesine dair stok kaydı (tarih, son kullanım, kullanılabilirlik, kontaminasyon).
- **Requests**: Hastaneler tarafından yapılan kan talebi kayıtlarını içerir.

## 🔧 Ana Özellikler
- 💉 **Bağış Kaydı**: Donör kaydı ile birlikte otomatik olarak BloodUnits tablosuna bağış eklenir.
- ⏳ **Stok Takibi**: Her kan grubu için kullanılabilir, temiz ve tarihi geçmemiş kan üniteleri hesaplanır.
- 📊 **Talep-Karşılaştırma**: Hastanelerden gelen talepler ile stok durumu karşılaştırılarak “Yeterli/Yetersiz” bilgisi üretilir.
- ⚠️ **Kritik Stok Uyarısı**: Nadir bulunan kan gruplarında stok 5’in altına düştüğünde uyarı üretir.
- 👥 **Donör Performans İzleme**: Son 3-6 ayda en aktif ve güvenilir bağışçılar listelenir.
- 📈 **Hastane Bazlı Talepler**: Hangi hastanenin hangi kan grubuna ne kadar talepte bulunduğu analiz edilir.
- 🔁 **Trigger Kullanımı**: Donör eklendiğinde BloodUnits tablosuna otomatik olarak stok kaydı eklenir.
- 🧠 **View Tanımı**: Kritik stok durumu gibi analizler view aracılığıyla merkezi olarak erişilebilir hale getirilmiştir.

## 🔍 Örnek SQL Sorguları
- Mevcut temiz ve süresi geçmemiş kan stoğunu listele
- Talep ve stokları karşılaştırarak hangi kan grubunda eksiklik olduğunu belirle
- En son 3 ay içinde bağış yapan donörleri sırala
- Aynı kişinin kaç defa bağış yaptığını analiz et
- En çok bağış yapan 5 kişiyi getir (son 6 ay)
- Kullanılmış veya kontamine kan ünitelerini listele
- Hastane bazlı talepleri ve stok durumu özetle
- Kritik kan gruplarının (O-, AB-, A-, B-) stok analizini yap

## 🔐 Güvenlik ve Kalite
- 🔄 **Trigger sistemi**, bağışçı eklendiğinde kan ünitesini otomatik olarak üretir.
- ✅ **Veri Kalitesi Kontrolleri**: Bağışçı yaş sınırı, kan miktar limiti, kontaminasyon ve kullanım durumu dikkate alınır.
- 📆 **Tarih kontrollü filtreleme**: Son kullanım tarihi geçmiş üniteler sistem dışı kabul edilir.

## 💾 Sistem Gereksinimi
- Microsoft SQL Server veya T-SQL destekleyen veritabanı sistemleri
- `GETDATE()`, `DATEADD()` gibi fonksiyonların desteklendiği SQL ortamı

## 📑 Rapor Özeti

| Başlık | Değer |
|--------|-------|
| Toplam Donör Sayısı | 20 |
| Toplam Kan Ünitesi | 20 |
| Talep Edilen Kan Üniteleri | ~50 |
| Kullanılabilir Temiz Kan | 15-18 |
| Kritik Stokta Olan Gruplar | O-, AB-, A-, B- |
| Güvenilir Donör Sayısı (2+ Temiz Bağış) | 4-6 |
| Otomatik Stok Güncelleme (Trigger) | ✔️ |
| Kritik Stok Görünümü (View) | ✔️ |

---

Bu sistem, gerçek dünyadaki sağlık uygulamalarına uygun olarak optimize edilmiş, bağış ve stok takibi açısından veri tabanı temelli stratejik karar destek altyapısı sunar.

