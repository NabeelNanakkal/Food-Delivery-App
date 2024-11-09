class OnboardingContent{
  String image;
  String title;
  String description;
  OnboardingContent({required this.image, required this.title,required this.description});
}

List<OnboardingContent> content=[
  OnboardingContent(image: 'assets/images/screen1.png', title: 'Select from our Best Menu', description: 'Pick your food form our menu\n           more than 30 times'),
  OnboardingContent(image: 'assets/images/screen2.png', title: 'Easy and online payment', description: 'You can pay cash on delivery  and\n        card payment is available'),
  OnboardingContent(image: 'assets/images/screen3.png', title: 'Quick delivery at your\n            Doorstep', description: 'Deliver your food at\n      your Doorstep'),
];