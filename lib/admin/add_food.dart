import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_app/services/service.dart';
import 'package:food_app/widget/widget_support.dart';
import 'package:image_picker/image_picker.dart';
import 'package:random_string/random_string.dart';

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  String? value;
  final List<String> productTypes = ['Ice Cream', 'Burger', 'Pizza', 'Salad'];
  TextEditingController productNameController = TextEditingController();
  TextEditingController productPriceController = TextEditingController();
  TextEditingController productDetailsController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? selectedImage;

  Future<void> getImage() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No image selected')),
      );
    }
  }

  Future<void> uploadFoodItem() async {
  if (selectedImage != null &&
      productNameController.text.isNotEmpty &&
      productPriceController.text.isNotEmpty &&
      productDetailsController.text.isNotEmpty &&
      value != null) {
    try {
      final supabase = Supabase.instance.client;

      String productId = randomAlphaNumeric(10);

      final response = await supabase.storage.from('HalalFoodApp').upload(
            '$productId.jpg',
            selectedImage!,
          );

      final imageUrl = supabase.storage
          .from('HalalFoodApp')
          .getPublicUrl('$productId.jpg');

      Map<String, dynamic> addItem = {
        'image': imageUrl,
        'name': productNameController.text,
        'price': productPriceController.text,
        'details': productDetailsController.text,
      };

      await DatabaseMethods().addProductItem(addItem, value!).then((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );

        setState(() {
          selectedImage = null;
          productNameController.clear();
          productPriceController.clear();
          productDetailsController.clear();
          value = null;
        });
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error adding product: $e')),
      );
    }
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please fill all fields')),
    );
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new_outlined),
        title: Text(
          'Add Product',
          style: AppWidget.headLineTextStyle(),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Upload the product picture',
                  style: AppWidget.semiBoldTextStyle(),
                ),
              ),
              const SizedBox(height: 30.0),
              Center(
                child: GestureDetector(
                  onTap: getImage,
                  child: Material(
                    elevation: 8.0,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 150,
                      height: 150,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black38, width: 1.5),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: selectedImage == null
                          ? const Icon(Icons.camera_alt_outlined)
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.file(
                                selectedImage!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30.0),
              _buildTextField(
                label: 'Product Name',
                controller: productNameController,
                hintText: 'Enter name',
              ),
              const SizedBox(height: 10.0),
              _buildTextField(
                label: 'Product Price',
                controller: productPriceController,
                hintText: 'Enter price',
                prefixIcon: const Icon(Icons.attach_money),
              ),
              const SizedBox(height: 10.0),
              _buildTextField(
                label: 'Product Details',
                controller: productDetailsController,
                hintText: 'Enter details',
                maxLines: 6,
              ),
              const SizedBox(height: 10.0),
              Text(
                'Product Types',
                style: AppWidget.semiBoldText2Style(),
              ),
              const SizedBox(height: 5.0),
              _buildDropdown(),
              const SizedBox(height: 20.0),
              Center(
                child: ElevatedButton(
                  onPressed: uploadFoodItem,
                  style: ElevatedButton.styleFrom(
                    elevation: 10.0,
                    backgroundColor: Colors.black,
                    minimumSize: const Size(double.maxFinite, 50),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                  ),
                  child: Text(
                    'Add Product',
                    style: AppWidget.buttonBoldTextStyle(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    String? hintText,
    int maxLines = 1,
    Widget? prefixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppWidget.semiBoldText2Style(),
        ),
        const SizedBox(height: 5.0),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: hintText,
            prefixIcon: prefixIcon,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdown() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      width: double.maxFinite,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black38),
        borderRadius: BorderRadius.circular(5),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          items: productTypes
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item),
                  ))
              .toList(),
          onChanged: (value) => setState(() => this.value = value),
          hint: const Text('Select your type'),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Colors.black,
          ),
          value: value,
        ),
      ),
    );
  }
}
