import 'package:flutter/material.dart';

void main() => runApp(const ZaraApp());

class ZaraApp extends StatelessWidget {
  const ZaraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Georgia', // Un toque editorial para Zara
      ),
      home: const ZaraCatalogScreen(),
    );
  }
}

class ZaraCatalogScreen extends StatelessWidget {
  const ZaraCatalogScreen({super.key});

  // Datos de ejemplo usando imágenes de GitHub (placeholders confiables)
  final List<Map<String, String>> products = const [
    {
      'title': 'ABRIGO OVERSIZE',
      'price': '129.00 USD',
      'category': 'COLECCIÓN INVIERNO',
      'img': 'https://raw.githubusercontent.com/0612-web/imagenes-github/refs/heads/main/abrigo.jfif' // Sustituir por URLs de ropa
    },
    {
      'title': 'VESTIDO LENCERO',
      'price': '45.90 USD',
      'category': 'NEW COLLECTION',
      'img': 'https://raw.githubusercontent.com/0612-web/imagenes-github/refs/heads/main/vestido.jfif'
    },
    {
      'title': 'BLAZER ESTRUCTURA',
      'price': '89.95 USD',
      'category': 'LIMITED EDITION',
      'img': 'https://raw.githubusercontent.com/0612-web/imagenes-github/refs/heads/main/blazer.jfif'
    },
    {
      'title': 'PANTALÓN FLUIDO',
      'price': '39.90 USD',
      'category': 'BASICS',
      'img': 'https://raw.githubusercontent.com/0612-web/imagenes-github/refs/heads/main/pantalonzara.jfif'
    },
    {
      'title': 'BOTÍN PIEL',
      'price': '79.00 USD',
      'category': 'ACCESSORIES',
      'img': 'https://raw.githubusercontent.com/0612-web/imagenes-github/refs/heads/main/botin.jfif'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'ZARA',
          style: TextStyle(
            letterSpacing: 8,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search, color: Colors.black)),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 20),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ZaraProductCard(
            product: products[index],
            index: index,
          );
        },
      ),
    );
  }
}

class ZaraProductCard extends StatefulWidget {
  final Map<String, String> product;
  final int index;

  const ZaraProductCard({super.key, required this.product, required this.index});

  @override
  State<ZaraProductCard> createState() => _ZaraProductCardState();
}

class _ZaraProductCardState extends State<ZaraProductCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600 + (widget.index * 100)), // Animación escalonada
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _slideAnimation = Tween<Offset>(begin: const Offset(0.2, 0), end: Offset.zero)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          height: 160,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 15,
                offset: const Offset(0, 5),
              )
            ],
          ),
          child: Row(
            children: [
              // Imagen a la izquierda con fondo gris suave
              Container(
                width: 120,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F2F2),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(4),
                    bottomLeft: Radius.circular(4),
                  ),
                ),
                child: Image.network(
                  widget.product['img']!,
                  fit: BoxFit.contain,
                ),
              ),
              // Información a la derecha
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.product['category']!,
                        style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey[600],
                          letterSpacing: 1.5,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        widget.product['title']!,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 1.1,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        widget.product['price']!,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(right: 15),
                child: Icon(Icons.add_shopping_cart_outlined, size: 20, color: Colors.black54),
              )
            ],
          ),
        ),
      ),
    );
  }
}