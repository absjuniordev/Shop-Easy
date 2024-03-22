import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/model/provider/product.dart';
import 'package:shop/model/provider/product_list.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({Key? key}) : super(key: key);

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _priceFocus = FocusNode();
  final _descriptionFocus = FocusNode();
  final _imageUrlFocus = FocusNode();
  final _imageUrlController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _formData = <String, Object>{};
  bool _isLoadin = false;

  @override
  void initState() {
    super.initState();
    _imageUrlFocus.addListener(updateImage);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_formData.isEmpty) {
      final arg = ModalRoute.of(context)?.settings.arguments;
      //recebendo o transporte

      if (arg != null) {
        final product = arg as Product;

        _formData['id'] = product.id;
        _formData['name'] = product.name;
        _formData['price'] = product.price;
        _formData['description'] = product.description;
        _formData['imageUrl'] = product.imageUrl;

        _imageUrlController.text = product.imageUrl;
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _priceFocus.dispose();
    _descriptionFocus.dispose();

    _imageUrlFocus.removeListener(updateImage);
    _imageUrlFocus.dispose();
  }

  void updateImage() {
    setState(() {});
  }

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    setState(() {
      _isLoadin = true;
    });

    Provider.of<ProductList>(
      context,
      listen: false,
    ).saveProduct(_formData).then((value) {
      setState(() => _isLoadin = false);
      Navigator.of(context).pop();
    });
  }

  bool isValidateImageUrl(String url) {
    bool isValidate = Uri.tryParse(url)?.hasAbsolutePath ?? false;
    bool endsWithFile = url.toLowerCase().endsWith('.png') ||
        url.toLowerCase().endsWith('.jpg') ||
        url.toLowerCase().endsWith('.jpeg');
    return isValidate && endsWithFile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Formulário de Produto'),
        actions: [
          IconButton(
            onPressed: _submitForm,
            icon: const Icon(
              Icons.save,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: _isLoadin
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    TextFormField(
                      initialValue: _formData['name']?.toString(),
                      decoration: const InputDecoration(labelText: 'Nome'),
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_priceFocus);
                      },
                      onSaved: (name) => _formData['name'] = name ?? '',
                      validator: (_name) {
                        final name = _name ?? '';

                        if (name.trim().isEmpty) {
                          return 'Insira um nome';
                        }
                        if (name.trim().length < 3) {
                          return 'Nome deverá conter no minimo 3 letras ';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['price']?.toString(),
                      decoration: const InputDecoration(labelText: 'Preço'),
                      textInputAction: TextInputAction.next,
                      focusNode: _priceFocus,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(_descriptionFocus);
                      },
                      onSaved: (price) =>
                          _formData['price'] = double.parse(price ?? '0'),
                      validator: (_price) {
                        final priceString = _price ?? '';
                        final price = double.tryParse(priceString) ?? -1;

                        if (price <= 0) {
                          return 'Informe um preço valido';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      initialValue: _formData['description']?.toString(),
                      decoration: const InputDecoration(labelText: 'Descrição'),
                      focusNode: _descriptionFocus,
                      keyboardType: TextInputType.multiline,
                      maxLines: 3,
                      onSaved: (description) =>
                          _formData['description'] = description ?? '',
                      validator: (_description) {
                        final description = _description ?? '';

                        if (description.trim().isEmpty) {
                          return 'Descrição é obrigatória.';
                        }
                        if (description.trim().length < 10) {
                          return 'Descrição deverá conter no minimo 10 letras ';
                        }
                        return null;
                      },
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: const InputDecoration(
                                labelText: 'Url da Imagem'),
                            keyboardType: TextInputType.url,
                            textInputAction: TextInputAction.done,
                            focusNode: _imageUrlFocus,
                            controller: _imageUrlController,
                            onSaved: (imageUrl) =>
                                _formData['imageUrl'] = imageUrl ?? '',
                            onFieldSubmitted: (_) {
                              _submitForm();
                            },
                            validator: (_imageUrl) {
                              final imageUrl = _imageUrl ?? '';
                              if (!isValidateImageUrl(imageUrl)) {
                                return 'Informe uma Url valida';
                              }
                              return null;
                            },
                          ),
                        ),
                        Container(
                          height: 100,
                          width: 100,
                          margin: const EdgeInsets.only(
                            top: 10,
                            left: 10,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: _imageUrlController.text.isEmpty
                              ? const Text('Informe a Url')
                              : Image.network(_imageUrlController.text),
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
