import 'package:flutter/material.dart';
import 'package:flutter_tflite/flutter_tflite.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as devtools;
import 'lung_info_screen.dart';
import 'info_screen.dart';

class LungTomographyScreen extends StatefulWidget {
  const LungTomographyScreen({super.key});

  @override
  State<LungTomographyScreen> createState() => _LungTomographyScreenState();
}

class _LungTomographyScreenState extends State<LungTomographyScreen> {
  File? filepath;
  String label = '';
  double confidence = 0.0;

  //Modelin yüklenmesi
  Future<void> _tfLteInit() async {
    await Tflite.loadModel(
      model: "assets/lung_tomography_model.tflite", //model parametresi
      labels: "assets/lung_labels.txt", // model etiketleri
      numThreads: 1, // performans için kullanacağı thread
      isAsset: true, // modelin assets klasöründen yüklendiğini belirtir
      useGpuDelegate: false, // true -> gpu , false -> cpu
    );
  }

  //Galeriden fotoğraf seçme işlemi
  pickImageGallery() async {
    final ImagePicker picker = ImagePicker(); //imagepickerden nesne oluşturuldu
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
    ); //galeriden resim seçilmesi ve de pathi tutar

    if (image == null) return; // seçilmezse biter

    var imageMap = File(image.path); // dosya yolu alınır

    setState(() {
      filepath = imageMap; //ui güncelleme
    });

    //TensorFlow Lite modelini çalıştırmak için
    var recognitions = await Tflite.runModelOnImage(
      path: image.path, //yol
      imageMean: 0.0, //std normalize etmek için
      imageStd: 255.0, //std normalize etmek için
      numResults: 4, //kaç tahmin yapılacağı
      threshold: 0.2, //confidence
      asynch: true, // asenkron
    );

    //tahminin null olma durumu
    if (recognitions == null) {
      devtools.log("Recognitions Is Null");
      return;
    }

    devtools.log(recognitions.toString());

    //güncelleme
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  //cameradan resim çekilmesi
  pickImageCamera() async {
    final ImagePicker picker = ImagePicker(); //imagepickerden nesne oluşturuldu
    final XFile? image = await picker.pickImage(
      source: ImageSource.camera,
    ); //cameradan resim çekilmesi ve de pathi tutar

    if (image == null) return; // seçilmezse biter

    var imageMap = File(image.path); // dosya yolu alınır

    setState(() {
      filepath = imageMap; //ui güncelleme
    });

    //TensorFlow Lite modelini çalıştırmak için
    var recognitions = await Tflite.runModelOnImage(
      path: image.path, //yol
      imageMean: 0.0, //std normalize etmek için
      imageStd: 255.0, //std normalize etmek için
      numResults: 2, //kaç tahmin yapılacağı
      threshold: 0.2, //confidence
      asynch: true, // asenkron
    );

    //tahminin null olma durumu
    if (recognitions == null) {
      devtools.log("Recognitions Is Null");
      return;
    }

    devtools.log(recognitions.toString());

    //güncelleme
    setState(() {
      confidence = (recognitions[0]['confidence'] * 100);
      label = recognitions[0]['label'].toString();
    });
  }

  //widget sona erdiğinde tflite kapatılır
  @override
  void dispose() {
    super.dispose();
    Tflite.close();
  }

  //widget ilk kez oluşturulduğunda modelin yüklenmesi için
  @override
  void initState() {
    super.initState();
    _tfLteInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          'MediScan AI',
          style: TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal.shade700,
        elevation: 6,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30),
            bottomRight: Radius.circular(30),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.health_and_safety_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => InfoScreen()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (filepath != null)
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOut,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      colors: [Colors.teal.shade700, Colors.teal.shade800],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        offset: const Offset(0, 4),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Image.file(
                        filepath!,
                        height: 300,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              "Label: $label",
                              style: Theme.of(
                                context,
                              ).textTheme.titleLarge!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1.5,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "Confidence: ${confidence.toStringAsFixed(2)}%",
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                color: Colors.grey[200],
                                letterSpacing: 1.2,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              else
                Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: 300,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.asset(
                          "assets/background.png",
                          height: 300,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No Image Has Been Selected Yet.",
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Colors.grey[600],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              const SizedBox(height: 24),
              Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: pickImageGallery,
                    icon: const Icon(
                      Icons.image_outlined,
                      size: 24.0,
                      color: Colors.red,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Select From Gallery",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.red.shade700.withOpacity(
                        0.38,
                      ),
                      disabledBackgroundColor: Colors.red.shade700.withOpacity(
                        0.12,
                      ),
                      side: BorderSide(color: Colors.red.shade700, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0, // Gölgeleme kaldırıldı
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),
                  const SizedBox(height: 16),

                  ElevatedButton.icon(
                    onPressed: pickImageCamera,
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 24.0,
                      color: Colors.red,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Take Photo",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.red.shade700.withOpacity(
                        0.38,
                      ),
                      disabledBackgroundColor: Colors.red.shade700.withOpacity(
                        0.12,
                      ),
                      side: BorderSide(color: Colors.red.shade700, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      minimumSize: Size(double.infinity, 50),
                    ),
                  ),

                  const SizedBox(height: 16),
                  ElevatedButton.icon(
                    onPressed: () {
                      // Sağlık bilgisi sayfasına yönlendiriyoruz
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  const LungInfoScreen(), // Sağlık bilgisi sayfası
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      size: 24.0,
                      color: Colors.red,
                    ),
                    label: const Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.0,
                        horizontal: 10.0,
                      ),
                      child: Text(
                        "Get Information",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      disabledForegroundColor: Colors.red.shade700.withOpacity(
                        0.38,
                      ),
                      disabledBackgroundColor: Colors.red.shade700.withOpacity(
                        0.12,
                      ),
                      side: BorderSide(color: Colors.red.shade700, width: 2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 10.0,
                      ),
                      textStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      minimumSize: Size(
                        double.infinity,
                        50,
                      ), // Butonun minimum boyutu
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
