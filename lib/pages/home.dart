import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomNavbar(),
      body: Column(
        children: [
          Expanded(child: CustomCarousel()), // Carousel in body
          // Other body content here
        ],
      ),
      bottomNavigationBar: CustomFooter(), // Footer at the bottom
    );
  }
}

class CustomNavbar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () {
          // Add menu open logic here
        },
      ),
      title: Row(
        children: [
          Image.network('https://flowbite.com/docs/images/logo.svg', height: 32),
          SizedBox(width: 8),
          Text('Flowbite', style: TextStyle(color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Home', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {},
          child: Text('About', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Services', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Pricing', style: TextStyle(color: Colors.black)),
        ),
        TextButton(
          onPressed: () {},
          child: Text('Contact', style: TextStyle(color: Colors.black)),
        ),
      ],
    );
  }
}

class CustomCarousel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 400,
        autoPlay: true,
        enlargeCenterPage: true,
      ),
      items: [
        'https://docs.images/carousel/carousel-1.svg',
        'https://docs/images/carousel/carousel-2.svg',
        'https://docs/images/carousel/carousel-3.svg',
        'https://docs/images/carousel/carousel-4.svg',
        'https://docs/images/carousel/carousel-5.svg'
      ].map((item) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 5.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5.0),
            child: Image.network(item, fit: BoxFit.cover, width: 1000),
          ),
        );
      }).toList(),
    );
  }
}

class CustomFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueGrey[800],
      padding: EdgeInsets.all(20.0),
      child: Column(
        children: [
          Text('Flowbite', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          Text('© 2024 All Rights Reserved', style: TextStyle(color: Colors.white70)),
        ],
      ),
    );
  }
}