import 'package:flutter/material.dart';
import 'package:shopsmart/widget/dummy_widget.dart';
import 'package:shopsmart/widget/navbar.dart';

class HotDeals extends StatelessWidget {
  const HotDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hot Deals',style: TextStyle(color: Colors.white),),backgroundColor: Colors.blue,),
      body: ListView(
        children: const [
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/shoes.jpg'),
            title: '50% Off on Shoes',
            price: '\₹2500',
            positiveReviewPercentage: 85.0,
            sampleReviews: [
              'Great quality, super comfortable!',
              'Fits perfectly and looks stylish!',
              'The material is durable and worth the price.',
              'Very lightweight, perfect for running!',
              'Delivery was quick, and the product exceeded expectations.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/watch.jpg'),
            title: 'Smartwatch Discount',
            price: '\₹10,000',
            positiveReviewPercentage: 90.0,
            sampleReviews: [
              'Battery life is amazing, lasts for days!',
              'Love the sleek design and premium feel.',
              'The health tracking features are super accurate.',
              'Perfect for workouts and daily use.',
              'Received on time, and setup was easy.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/laptop.jpg'),
            title: 'Laptop Deal',
            price: '\₹60,000',
            positiveReviewPercentage: 78.0,
            sampleReviews: [
              'Super fast performance, great for gaming!',
              'Perfect for work and multitasking.',
              'Battery lasts a full day on moderate use.',
              'The display quality is outstanding!',
              'Lightweight yet powerful, very satisfied!'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/headphones.jpg'),
            title: 'Wireless Noise-Canceling Headphones',
            price: '\₹2,500',
            positiveReviewPercentage: 92.0,
            sampleReviews: [
              'The noise cancellation is incredible, perfect for travel!',
              'Sound quality is crystal clear and bass is deep.',
              'Battery life exceeds advertised duration.',
              'Very comfortable for long listening sessions.',
              'The mobile app integration is seamless.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/camera.jpg'),
            title: 'Professional DSLR Camera Bundle',
            price: '\₹2,85,000',
            positiveReviewPercentage: 88.0,
            sampleReviews: [
              'Image quality is phenomenal, especially in low light.',
              'The included lenses are versatile and sharp.',
              'Great value for a professional camera bundle.',
              'Autofocus is lightning fast and accurate.',
              'Build quality feels premium and durable.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/tab.jpg'),
            title: 'Latest Gen Tablet with Stylus',
            price: '\₹25,000',
            positiveReviewPercentage: 86.0,
            sampleReviews: [
              'Perfect for digital art and note-taking!',
              'Display is bright and color accurate.',
              'Stylus feels natural with zero lag.',
              'Great for both work and entertainment.',
              'Battery easily lasts through a full workday.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/mug.jpg'),
            title: 'Smart Coffee Maker',
            price: '\₹8,000',
            positiveReviewPercentage: 83.0,
            sampleReviews: [
              'Love scheduling my morning coffee from my phone!',
              'Temperature control is precise and consistent.',
              'The app is intuitive and feature-rich.',
              'Coffee tastes great every single time.',
              'Easy to clean and maintain.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/speaker.jpg'),
            title: 'Smart Home Speaker System',
            price: '\₹4,500',
            positiveReviewPercentage: 89.0,
            sampleReviews: [
              'Room-filling sound with incredible clarity!',
              'Multi-room sync works flawlessly.',
              'Voice control is responsive and accurate.',
              'Setup was a breeze with the mobile app.',
              'Design looks elegant in any room.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/wwatch.jpg'),
            title: 'Advanced Fitness Tracker',
            price: '\₹3,500',
            positiveReviewPercentage: 87.0,
            sampleReviews: [
              'Tracks all my workouts with great accuracy!',
              'Sleep tracking features are comprehensive.',
              'Battery lasts for over a week easily.',
              'Waterproof performance is excellent.',
              'Health insights are actually useful.'
            ],
          ),
          DummyProductWidget(
            imageUrl: AssetImage('assets/images/bag.jpg'),
            title: 'Smart Travel Backpack',
            price: '\₹2000',
            positiveReviewPercentage: 91.0,
            sampleReviews: [
              'Perfect for tech-savvy travelers!',
              'Built-in USB charging is super convenient.',
              'Lots of well-designed compartments.',
              'Water-resistant material works great.',
              'Comfortable even when fully packed.'
            ],
          ),
        ],
      ),
      bottomNavigationBar: Navbar(),
    );
  }
}