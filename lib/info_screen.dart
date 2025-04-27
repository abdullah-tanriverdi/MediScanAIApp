import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

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
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,

            children: [

              Center(

                child: const Text(
                  'Information About Artificial Intelligence Predictions',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              const SizedBox(height: 16),


              Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: Colors.teal.shade50,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                    child: const Text(
                      'These diagnoses are predictions made by an artificial intelligence model trained on specific data. '
                          'Artificial intelligence makes these predictions based on large datasets, but the accuracy of the model depends on the quality of the data used.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.6,
                      ),
                    )

                ),
              ),
              const SizedBox(height: 20),


              Row(
                children: [
                  const Icon(
                    Icons.warning_amber_outlined,
                    color: Colors.red,
                    size: 30,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: const Text(
                      "Important: It is strongly recommended to consult a specialist doctor for a definitive diagnosis in the case of such diseases. "
                          "Artificial intelligence is only an assisting tool, and for a real diagnosis, you must consult a healthcare professional.",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.red,
                        fontWeight: FontWeight.w500,
                        height: 1.6,
                      ),
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
