# 📱 News App

Bu proje, Flutter kullanılarak geliştirilmiş basit bir **haber uygulamasıdır**.  
Amaç: API üzerinden farklı kategorilerde (finans, futbol, genel haberler, hava durumu, eczane vb.) güncel verileri çekmek, listelemek ve detay sayfalarında kullanıcıya sunmak. Uygulamanın amacı, tek bir mobil platform üzerinden günlük hayatla ilgili en temel bilgilere erişim sağlamaktır.

---

## 🚀 Özellikler

- 🌍 Güncel haberleri API üzerinden çekme
- 📰 Haberleri listeleme (başlık, açıklama, görsel)
- 📖 Haberin detay sayfasını görüntüleme
- 🌓 Koyu/Açık tema desteği
- 🌐 Çoklu dil desteği (TR / EN)
- 📂 Temiz mimari yapısı:
  - **core/** → ortak bileşenler (appBar, drawer vb.)
  - **features/news/** → haberlerle ilgili katmanlar
  - **data/** → API çağrıları, modeller
  - **presentation/** → arayüz sayfaları

---

## 📷 Ekran Görüntüleri

> 📌 Örnek ekran görüntüleri buraya eklenebilir (news list, detail, drawer, settings)

---

## 🛠️ Kullanılan Teknolojiler

- Flutter (Dart)
- Dio (HTTP istekleri için)

---

## 📦 Kurulum

1. Repoyu klonla:
   ```bash
   git clone https://github.com/bahasorkun/news_app.git
   ```
2. Proje dizinine gir:
   ```bash
   cd news_app
   ```
3. Paketleri yükle:
   ```bash
   flutter pub get
   ```
4. Uygulamayı çalıştır:
   ```bash
   flutter run
   ```

---

## 👨‍💻 Geliştirici Notları

Bu proje, staj sürecinde öğrenme amaçlı geliştirilmiştir.  
Amaç sadece **haberleri listelemek değil**, aynı zamanda Flutter’ın mimari yapısını öğrenmektir.
