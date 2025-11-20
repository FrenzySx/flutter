import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/button.dart';
import 'package:shop_app/components/drawer.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/models/shop.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  void removeItemFromCart(BuildContext context, Product product) {
    showDialog(
      barrierColor: Theme.of(context).colorScheme.surface,
      barrierDismissible: true,
      context: context,
      builder: (context) => AlertDialog(
        content: Text(
          'Remove this item from your cart ?',
          textAlign: .center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.grey[700],
          ),
        ),

        actions: [
          Row(
            mainAxisAlignment: .spaceEvenly,
            children: [
              MaterialButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),

              MaterialButton(
                onPressed: () {
                  Navigator.pop(context);

                  context.read<Shop>().removeFromCart(product);
                },
                child: Text('Yes'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void payButtonPressed(BuildContext context) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.info,
      animType: AnimType.scale,
      // Stil Ayarları
      title: 'Confirm Payment',
      desc: 'Do you want to proceed with the payment?',
      titleTextStyle: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
      ),

      // İptal Butonu
      btnCancelText: 'Cancel',
      btnCancelColor: Theme.of(context).colorScheme.primary,
      btnCancelOnPress: () {
        // Sadece diyaloğu kapatır, bir şey yapmaz
      },

      // Öde Butonu
      btnOkText: 'Pay Now!',
      buttonsTextStyle: TextStyle(color: Colors.black),
      btnOkColor: Theme.of(context).colorScheme.primary,
      btnOkOnPress: () {
        // 1. ADIM: Önce ödeme başarı animasyonunu göster
        AwesomeDialog(
          context: context,
          dialogType: DialogType.success, // Yeşil onay animasyonu
          animType: AnimType.bottomSlide,
          title: 'Payment Successful!',
          desc: 'Your items are on the way.',
          //autoHide: const Duration(seconds: 3), // 3 saniye sonra kapansın
          // Diyalog kapandığında yapılacaklar
          onDismissCallback: (type) {
            // 2. ADIM: Sepeti temizle (Opsiyonel)
            context.read<Shop>().clearCart();

            // 3. ADIM: Kullanıcıyı ana sayfaya gönder ve geçmişi sil
            Navigator.pushNamedAndRemoveUntil(
              context,
              '/intro_page',
              (route) => false,
            );
          },
        ).show();
      },
    ).show();
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<Shop>().cart;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          'Cart',
          style: TextStyle(
            color: Theme.of(context).colorScheme.inversePrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
              itemBuilder: (context, index) {
                final item = cart[index];
                final shop = context.read<Shop>();
                final quantity = context.watch<Shop>().quantityOf(item);

                return ListTile(
                  title: Text(item.name),
                  subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        onPressed: () => quantity > 1
                            ? shop.removeFromCart(item)
                            : removeItemFromCart(context, item),
                        icon: const Icon(Icons.remove),
                      ),
                      Text('$quantity'),
                      IconButton(
                        onPressed: () => shop.addToCart(item),
                        icon: const Icon(Icons.add),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(50),
            child: Column(
              children: [
                Text(
                  'Total: \$${context.watch<Shop>().total.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 15),
                MyButton(
                  onTap: cart.isEmpty ? null : () => payButtonPressed(context),
                  child: const Text('Pay Now'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
