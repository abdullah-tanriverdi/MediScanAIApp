# MediScan AI App

## Medikal Görüntü İşleme Sınıflandırma Projesi

Bu proje, üç farklı medikal görüntü işleme sınıflandırma modelini içeren bir Flutter mobil uygulamasıdır. Modeller, katarakt tespiti, göz flusu ve akciğer çökmesi gibi hastalıkların tanılarını koymak için kullanılır. Aşağıda projemizin yapısı, kullanılan kütüphaneler ve teknik detaylar açıklanmıştır.

- [MediScan AI App Video Linki](https://youtube.com/shorts/klVm8yap8hk?feature=share)

## Uygulama Görselleri
<p align="center">
  <img src="assets/app_screen/home_screen.jpg" alt="Ana Sayfa" width="300" />
  <img src="assets/app_screen/cataract_screen.jpg" alt="Katarakt Sayfası" width="300" />
  <img src="assets/app_screen/flu_screen.jpg" alt="Flu Sayfası" width="300" />
  <img src="assets/app_screen/lung_screen.jpg" alt="Akciğer Sayfası" width="300" />
  <img src="assets/app_screen/lung_info.jpg" alt="Akciğer Bilgi Sayfası" width="300" />
  <img src="assets/app_screen/info_screen.jpg" alt="Bilgi Sayfası" width="300" />
</p>


## Kullanılan Teknolojiler

- Convolutional Neural Networks (CNN)
- TensorFlow
- Keras
- Python
- Flutter
- Dart

## Klasör Yapısı

### `lib/` Dizini

- `cataract_eye_screen.dart`: Katarakt tespiti için ekran.
- `cataract_info_screen.dart`: Katarakt hakkında bilgi ekranı.
- `flu_eye_screen.dart`: Göz flusu tespiti için ekran.
- `flu_info_screen.dart`: Göz flusu hakkında bilgi ekranı.
- `home_screen.dart`: Ana ekran.
- `info_screen.dart`: Genel bilgi ekranı.
- `lung_info_screen.dart`: Akciğer çökmesi hakkında bilgi ekranı.
- `lung_tomography_screen.dart`: Akciğer tomografisi tespiti için ekran.
- `main.dart`: Uygulamanın ana giriş noktası.

### Model Dosyaları

Projemizde kullanılan TensorFlow Lite modelleri, `assets/` dizininde yer almaktadır:

- `flu_eye_model.tflite`: Göz flusu tespiti için eğitilmiş model.
- `lung_tomography_model.tflite`: Akciğer çökmesi tespiti için eğitilmiş model.
- `cataract_eye_model.tflite`: Katarakt tespiti için eğitilmiş model.

## Kullandığımız Kütüphaneler

- `flutter_tflite: ^1.0.1`: TensorFlow Lite modellerini Flutter uygulamasına entegre etmek için kullanılır.
- `image_picker: ^0.8.9`: Kullanıcıdan resim almak için kullanılır.
- `url_launcher: ^6.3.1`: Uygulama içinde bağlantılar açmak için kullanılır.
- `package_info_plus: ^8.3.0`: Uygulama hakkında bilgi almak için kullanılır.
- `share_plus: ^11.0.0`: Uygulama içeriğini paylaşmak için kullanılır.

## Flutter - Dart sürümleri
- Flutter 3.29.3 • channel stable
- Dart 3.7.2

## Model Eğitimi ve Dönüştürme

Bu projede kullanılan modeller, `.h5` formatında eğitilmiş ve ardından TensorFlow Lite formatına (`.tflite`) dönüştürülmüştür. Aşağıdaki bağlantılardan modellerin eğitim sürecine ve kaynak kodlarına ulaşabilirsiniz:

- [Katarakt Tespiti Modeli](https://github.com/MehmetNurKavan/cataract_detection)
- [Akciğer Çökmesi Modeli](https://github.com/MehmetNurKavan/lung_collapse)

Bu modeller, Flutter için uygun hale getirilmek üzere dönüştürülüp projede kullanılmaktadır.

## flutter_tflite Kütüphanesindeki Hata Düzeltmesi

Projede kullanılan `flutter_tflite` kütüphanesinde bir hata ile karşılaşıldı ve bu hata düzeltildi. Kütüphanenin `flutter_tflite-1.0.1` sürümünde `android/build.gradle` dosyasındaki eksik `namespace` tanımı nedeniyle kütüphane çalışmamaktaydı. Bu hatayı düzeltmek için aşağıdaki kodu ekledik:

```gradle
android {
    namespace 'sq.flutter.tflite'
    //... diğer kodlar
}
```
Bu düzenlemeyle kütüphane sorunsuz bir şekilde çalıştırılacaktır.

## Proje Ekibi
- `Mehmet Nur KAVAN`: [LinkedIn Profili](https://www.linkedin.com/in/mehmet-nur-kavan-501608221/)
- `Abdullah Tanrıverdi`: [LinkedIn Profili](https://www.linkedin.com/in/abdullahttanriverdi/)
