# Pokedex App

Flutter ile geliştirilmiş, PokeAPI üzerinden veri çeken basit bir Pokedex uygulamasıdır.

## 🚀 Özellikler

- Pokemon verilerini API'den çekme
- Pokemon görsellerini listeleme
- Dinamik liste kullanımı
- Kart tasarımı
- Detay sayfası (tıklanınca açılır)

---

## 🛠️ Kullanılan Teknolojiler

- Flutter
- Dart
- HTTP (API istekleri)
- PokeAPI

---

## 📌 Flutter Tarafında Yapılan İyileştirmeler

1. İsimlendirme düzenlendi  
   - Türkçe/İngilizce karışıklığı giderildi  
   - Daha anlamlı method ve değişken isimleri kullanıldı  

2. Anlamsız widget isimleri kaldırıldı  
   - MyWidget yerine anlamlı isimler kullanıldı  

3. Tip güvenliği sağlandı  
   - List<dynamic> yerine List<Pokemon> kullanıldı  

4. Veri modeli oluşturuldu  
   - Pokemon model sınıfı yazıldı  
   - fromJson ile veri parse edildi  

5. API performansı artırıldı  
   - Sıralı istekler yerine Future.wait ile paralel istek yapıldı  

6. Hata yönetimi eklendi  
   - try-catch kullanıldı  
   - HTTP statusCode kontrolü yapıldı  

7. Loading durumu eklendi  
   - CircularProgressIndicator ile kullanıcıya geri bildirim verildi  

8. Widget yapısı düzeltildi  
   - MaterialApp root seviyeye taşındı  

9. Service katmanı oluşturuldu  
   - API işlemleri ayrı sınıfa alındı  

10. API yapısı incelendi  
   - limit / offset mantığı öğrenildi  

11. Detay sayfası eklendi  
   - Kartlara tıklanınca PokemonDetailPage açılıyor  

---

## 📌 Not

Bu proje geliştirilirken yapay zekadan destek alınmıştır.  
Ancak kullanılan tüm kodlar anlaşılmaya çalışılarak uygulanmıştır ve öğrenme odaklı ilerlenmiştir.

---

