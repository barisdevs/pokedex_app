# Proje Değişiklik Notları

## 1. Service Yapısı Ayrıldı

Eski:
Tek `fetchPokemon()` metodu vardı ve liste/detay mantığı tam ayrılmamıştı.

Yeni:
`fetchPokemonPage({limit, offset})` ve `fetchPokemonDetail(String name)` metotları oluşturuldu.

Neden değiştirdik:
Liste ve detay sayfasının servis sorumluluklarını ayırmak için. Ana sayfa pagination ile liste verisini alıyor, detay sayfası ise kendi detay verisini ayrı servis çağrısıyla alıyor.

---

## 2. Liste Servisi PokemonListItem Döndürüyor

Eski:
Liste servisi `Pokemon` modeli döndürüyordu.

Yeni:
Liste servisi `PokemonListItem` modeli döndürüyor.

Neden değiştirdik:
Ana sayfa sadece `name` ve `image` bilgisine ihtiyaç duyuyor. Detay bilgileri `PokemonDetail` modeliyle ayrı servis çağrısından alınıyor. Böylece liste ve detay model sorumlulukları ayrılmış oldu.

---

## 3. PokemonPage Modeli Güncellendi

Eski:
`PokemonPage` içinde `List<Pokemon>` kullanılıyordu.

Yeni:
`PokemonPage` içinde `List<PokemonListItem>` kullanıldı.

Neden değiştirdik:
Ana sayfada detay modeli değil, sadece liste kartı için gereken `name` ve `image` bilgisi kullanılmalı. Bu yüzden pagination sonucu `PokemonListItem` listesi döndürüyor.

---

## 4. PokemonListItem Modeli Eklendi

Eski:
Ana sayfadaki kartlar için `Pokemon` modeli kullanılıyordu.

Yeni:
Ana sayfa kartları için `PokemonListItem` modeli oluşturuldu.

Neden değiştirdik:
Liste sayfası ile detay sayfasının veri ihtiyacı aynı değil. Liste için sadece `name` ve `image` yeterliyken, detay sayfası daha fazla bilgiye ihtiyaç duyar. Bu yüzden model sorumluluklarını ayırmak için `PokemonListItem` modeli eklendi.

---

## 5. Detay Sayfasına Sadece Pokemon Adı Gönderildi

Eski:
Detay sayfasına ana sayfadaki `Pokemon` nesnesi gönderiliyordu.

Yeni:
Detay sayfasına sadece `pokemonName` gönderiliyor ve detay sayfası kendi API isteğini yapıyor.

Neden değiştirdik:
Detay sayfasının ID, height, weight, types, abilities ve stats gibi gerçek detay verilerini ayrı servisten çekmesi gerekiyordu.

---

## 6. PokemonDetailPage Servis Çağıracak Hale Getirildi

Eski:
`PokemonDetailPage` ana sayfadan gelen `Pokemon` nesnesini kullanıyordu.

Yeni:
`PokemonDetailPage` sadece `pokemonName` alıyor ve kendi içinde `fetchPokemonDetail()` servisini çağırıyor.

Neden değiştirdik:
Detay sayfasının kendi verisini ayrı endpoint üzerinden çekmesi gerekiyor. Böylece ID, height, weight, types, abilities ve stats gibi gerçek detay bilgileri gösterilebilir.

---

## 7. Detay Servisi Eklendi

Eski:
Detay sayfası ana sayfadan gelen veriyi gösteriyordu.

Yeni:
`fetchPokemonDetail(String name)` metodu eklendi.

Neden değiştirdik:
Detay sayfasında gerçek detay bilgilerini göstermek için seçilen Pokemon’un detayını ayrı API isteğiyle çekmemiz gerekiyor.

---

## 8. PokemonDetail ve PokemonStat Modelleri Oluşturuldu

Eski:
Detay sayfasında ayrı bir detay modeli yoktu. Ana sayfadan gelen Pokemon modeli kullanılıyordu.

Yeni:
`PokemonDetail` ve `PokemonStat` modelleri oluşturuldu.

Neden değiştirdik:
Detay sayfasında ID, height, weight, types, abilities ve stats gibi daha fazla bilgi gösterileceği için ayrı bir detay modeline ihtiyaç vardı.

---

## 9. Detay Sayfası Zenginleştirildi

Eski:
Detay sayfasında sadece Pokemon adı ve resmi gösteriliyordu.

Yeni:
Detay sayfasında ID, height, weight, types, abilities ve stats bilgileri gösterildi.

Neden değiştirdik:
Kullanıcının seçtiği Pokemon hakkında daha detaylı bilgi görmesi için detay sayfası zenginleştirildi.

---

## 10. Pagination Servisi Eklendi

Eski:
`fetchPokemon()` metodu vardı ve sadece PokeAPI’nin varsayılan ilk Pokemon listesini getiriyordu.

Yeni:
`fetchPokemonPage({limit, offset})` metodu eklendi.

Neden değiştirdik:
Pagination yapabilmek için kaç Pokemon getirileceğini ve kaç Pokemon atlanacağını kontrol etmemiz gerekiyordu. Bu yüzden limit ve offset kullanan yeni servis yapısına geçtik.

---

## 11. Pagination Kontrolleri Eklendi

Eski:
Ana sayfada sadece ilk Pokemon listesi gösteriliyordu ve sayfa değiştirme kontrolü yoktu.

Yeni:
Ana sayfaya Previous / Next butonları ve aktif sayfa bilgisi eklendi.

Neden değiştirdik:
PokeAPI’de 1000’den fazla Pokemon olduğu için hepsini tek seferde göstermek doğru değildi. Limit ve offset kullanarak Pokemonları sayfa sayfa göstermek için pagination yapısı eklendi.

---

## 12. nextPage ve previousPage Metotları Eklendi

Eski:
Sayfa değiştirme metodu yoktu. Uygulama sadece ilk verileri gösteriyordu.

Yeni:
`nextPage()` ve `previousPage()` metotları eklendi.

Neden değiştirdik:
Kullanıcının sonraki ve önceki Pokemon sayfalarına geçebilmesi için `offset` ve `currentPage` değerlerini değiştiren metotlara ihtiyaç vardı.

---

## 13. totalPage Hesaplaması Güvenli Hale Getirildi

Eski:
`totalCount` daha API’den gelmeden sayfa sayısı hesaplanıyordu.

Yeni:
`totalCount` 0 ise geçici olarak 1 gösteriliyor.

Neden değiştirdik:
Uygulama ilk açılırken `totalCount` henüz dolmadığı için NaN hatası oluşmasını engellemek için güvenli kontrol ekledik.

---

## 14. Loading Mesajı Eklendi

Eski:
Loading sırasında sadece dönen yuvarlak gösteriliyordu.

Yeni:
Dönen yuvarlak ile birlikte "Pokemonlar yükleniyor..." yazısı eklendi.

Neden değiştirdik:
Kullanıcının yükleme durumunu daha net anlaması için loading mesajı eklendi.

---

## 15. Loading Daha Görünür Hale Getirildi

Eski:
Loading vardı ama API hızlı cevap verdiği için kullanıcı çoğu zaman göremiyordu.

Yeni:
Veri çekme başlamadan önce `isLoading` true yapıldı. Kısa bir gecikme ile loading görünür hale getirildi.

Neden değiştirdik:
Kullanıcının veri yüklenirken uygulamanın çalıştığını anlaması için loading göstergesi daha belirgin hale getirildi.

---

## 16. GridView Kullanımı

Eski:
`ListView.builder` kullanılıyordu ve Pokemonlar alt alta listeleniyordu.

Yeni:
`GridView.builder` kullanıldı.

Neden değiştirdik:
Pokemon kartlarının daha görsel ve kart hissine uygun görünmesi için GridView tercih edildi.

---

## 17. Hata Yönetimi Eklendi

Eski:
API hatası veya internet problemi olduğunda kullanıcıya net bir mesaj gösterilmiyordu.

Yeni:
`try-catch` ve `statusCode` kontrolleri eklendi.

Neden değiştirdik:
İnternet yoksa veya API hata dönerse uygulamanın çökmesini engellemek ve kullanıcıya anlamlı hata mesajı göstermek için.

---

## 18. Empty State Eklendi

Eski:
Detay verisi gelmezse ayrı bir kontrol yoktu.

Yeni:
"Pokemon detayı bulunamadı." mesajı eklendi.

Neden değiştirdik:
Veri boş gelirse kullanıcıya boş ekran göstermek yerine anlamlı mesaj göstermek için.

---

## 19. Future.wait Kullanımı

Eski:
Pokemon detay istekleri sırayla çekiliyordu.

Yeni:
Ana sayfadaki Pokemon kartları için gerekli detay istekleri `Future.wait` ile paralel hale getirildi.

Neden değiştirdik:
Liste endpoint’i sadece `name` ve `url` döndürüyor. Kartlarda görsel göstermek için her Pokemon’un detay URL’sine istek atmak gerekiyor. Bu istekleri sırayla yapmak yavaş olacağı için `Future.wait` kullanıldı.

Detay sayfasında `Future.wait` kullanılmadı çünkü orada sadece tek Pokemon için tek detay isteği atılıyor.

---

## 20. AppBar Logosuyla Güncellendi

Eski:
AppBar’da sadece Pokedex yazısı vardı.

Yeni:
AppBar’a Pokemon logosu eklendi.

Neden değiştirdik:
Uygulamanın görsel olarak daha güzel ve Pokemon temasına uygun görünmesi için.