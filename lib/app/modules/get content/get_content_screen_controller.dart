import 'dart:convert';

import 'package:cleaning_app/app/utils/app_url.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class GetContentScreenController extends GetxController {
  // Observable variables
  var contentType = ''.obs;
  var title = ''.obs;
  var content = ''.obs;
  var lastUpdated = ''.obs;
  var isLoading = true.obs;
  var htmlContent = ''.obs;

  Future<void> getContentApi() async {
    try {

      isLoading.value = true;

      final response = await http.get(
        Uri.parse(AppUrl.getContent),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print("${htmlContent.value} htmlgggg");

        if (data['success'] == true &&
            data['content_arr'] != null &&
            data['content_arr'].isNotEmpty) {
          htmlContent.value = data['content_arr'][0]['content'];
          print("✅ HTML Content Loaded Successfully");
        } else {
          htmlContent.value = "<p>No content found</p>";
        }
      } else {
        htmlContent.value = "<p>Failed to load content</p>";
      }
    } catch (e) {
      htmlContent.value = "<p>Error: $e</p>";
    } finally {
      isLoading.value = false;
    }
  }


  @override
  void onInit() {
    super.onInit();
    _loadContent();
    // getContentApi();
  }

  void _loadContent() {
    // Get the content type from arguments
    final args = Get.arguments as Map<String, dynamic>?;
    
    if (args != null) {
      contentType.value = args['type'] ?? 'about';
    } else {
      contentType.value = 'about';
    }

    // Load content based on type
    _loadContentData();
    
    // Simulate loading delay
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
    });
  }

  void _loadContentData() {
    switch (contentType.value) {
      case 'privacy':
        _loadPrivacyPolicy();
        break;
      case 'terms':
        _loadTermsAndConditions();
        break;
      case 'about':
        _loadAboutUs();
        break;
      default:
        _loadAboutUs();
    }
  }

  void _loadPrivacyPolicy() {
    title.value = 'Privacy Policy';
    lastUpdated.value = '12/10/2025';
    content.value = '''
**Introduction**

Welcome to Cleaning App. We are committed to protecting your personal information and your right to privacy. This Privacy Policy explains how we collect, use, disclose, and safeguard your information when you use our mobile application.

**Information We Collect**

We collect information that you provide directly to us, including:

• Personal Information: Name, email address, phone number, profile picture
• Professional Information: Work experience, certifications, skills, ratings
• Location Data: Current location for job assignments and navigation
• Financial Information: Bank account details for payment processing
• Communication Data: Messages sent through our platform

**How We Use Your Information**

We use the information we collect to:

• Provide and maintain our services
• Process your job assignments and payments
• Send you notifications about jobs and updates
• Improve our application and user experience
• Prevent fraud and ensure security
• Comply with legal obligations

**Information Sharing**

We may share your information with:

• Customers who book your services
• Payment processors for salary disbursement
• Service providers who assist our operations
• Law enforcement when required by law

We do not sell your personal information to third parties.

**Data Security**

We implement appropriate security measures to protect your information from unauthorized access, alteration, or destruction. However, no method of transmission over the internet is 100% secure.

**Your Rights**

You have the right to:

• Access and update your personal information
• Request deletion of your data
• Opt-out of marketing communications
• Object to data processing
• Request data portability

**Data Retention**

We retain your information for as long as your account is active or as needed to provide services. You may request deletion of your account at any time.

**Children's Privacy**

Our services are not intended for users under 18 years of age. We do not knowingly collect information from children.

**Changes to Privacy Policy**

We may update this Privacy Policy from time to time. We will notify you of any changes by posting the new Privacy Policy on this page and updating the "Last Updated" date.

**Contact Us**

If you have questions about this Privacy Policy, please contact us:

Email: privacy@cleaningapp.com
Phone: +1 (800) 123-4567
Address: 123 Main Street, City, State, ZIP Code

By using our application, you agree to the collection and use of information in accordance with this Privacy Policy.
''';
  }

  void _loadTermsAndConditions() {
    title.value = 'Terms & Conditions';
    lastUpdated.value = '12/10/2025';
    content.value = '''
**Agreement to Terms**

By accessing and using the Cleaning App, you accept and agree to be bound by the terms and conditions outlined below. If you do not agree, please discontinue use immediately.

**Eligibility**

To use our services as a cleaner, you must:

• Be at least 18 years of age
• Have legal authorization to work
• Possess relevant skills and experience
• Pass background verification checks
• Maintain valid certifications where required

**User Accounts**

When you create an account, you agree to:

• Provide accurate and complete information
• Maintain the security of your password
• Accept responsibility for all activities under your account
• Notify us immediately of unauthorized access
• Not share your account with others

**Service Agreement**

As a cleaner using our platform:

• You are an independent contractor, not an employee
• You set your own working hours and availability
• You must complete jobs professionally and on time
• You agree to our quality standards
• You will maintain appropriate insurance

**Job Acceptance and Completion**

• Once you accept a job, you commit to completing it
• Cancellations should be made with at least 4 hours notice
• Repeated cancellations may result in account suspension
• You must arrive on time and complete work as specified
• Customer satisfaction is paramount

**Payment Terms**

• Payments are processed weekly via direct deposit
• Service fees are deducted from your earnings
• You are responsible for your own taxes
• Disputes must be raised within 7 days
• Bonus incentives are subject to performance criteria

**Code of Conduct**

You agree to:

• Treat customers with respect and professionalism
• Maintain confidentiality of customer information
• Use appropriate language and behavior
• Follow all safety protocols
• Report any issues or concerns promptly

**Ratings and Reviews**

• Customers can rate and review your services
• Ratings affect your visibility and job opportunities
• Consistently low ratings may lead to account review
• You may respond to reviews professionally
• Fake reviews are prohibited

**Prohibited Activities**

You may not:

• Use the platform for fraudulent purposes
• Harass or discriminate against customers
• Accept payment outside the platform
• Share customer contact information
• Engage in illegal activities

**Intellectual Property**

All content, features, and functionality of the app are owned by us and protected by copyright, trademark, and other laws. You may not reproduce or distribute any content without permission.

**Liability and Indemnification**

• We are not liable for disputes between you and customers
• You indemnify us against claims arising from your services
• Our liability is limited to the amount paid in fees
• We do not guarantee continuous, uninterrupted service

**Termination**

We may suspend or terminate your account if you:

• Violate these terms
• Engage in fraudulent activity
• Receive consistently poor ratings
• Fail to complete assigned jobs
• Pose a safety risk

**Changes to Terms**

We reserve the right to modify these terms at any time. Continued use after changes constitutes acceptance of the new terms.

**Dispute Resolution**

Any disputes will be resolved through:

• First, good faith negotiation
• Then, binding arbitration if necessary
• Disputes are governed by applicable state law

**Contact Information**

For questions about these Terms and Conditions:

Email: legal@cleaningapp.com
Phone: +1 (800) 123-4567

**Acknowledgment**

By using this app, you acknowledge that you have read, understood, and agree to be bound by these Terms and Conditions.
''';
  }

  void _loadAboutUs() {
    title.value = 'About Us';
    lastUpdated.value = '12/10/2025';
    content.value = '''
**Welcome to Cleaning App**

Cleaning App is a leading platform connecting professional cleaners with customers who need reliable cleaning services. We're revolutionizing the cleaning industry by making it easier, more efficient, and more rewarding for everyone involved.

**Our Mission**

Our mission is to empower cleaning professionals by providing them with a steady stream of job opportunities, fair compensation, and the tools they need to build successful careers. We believe that quality cleaning services should be accessible to everyone, and that cleaners deserve respect, fair pay, and flexible working conditions.

**What We Offer**

**For Cleaners:**
• Flexible work schedules - you choose when and where you work
• Competitive pay with weekly direct deposits
• Performance-based incentives and bonuses
• Professional development and training resources
• Insurance coverage for peace of mind
• Simple, intuitive app for managing your work
• Direct communication with customers
• Fair dispute resolution process

**Our Values**

**Trust**
We build trust through transparency, reliability, and consistent quality. Every cleaner on our platform is verified and background-checked.

**Respect**
We treat everyone with dignity and respect - cleaners, customers, and partners alike. Professional service is a two-way street.

**Excellence**
We strive for excellence in everything we do, from the quality of our technology to the support we provide our community.

**Fairness**
We believe in fair compensation, fair treatment, and fair opportunities for all our cleaners.

**Innovation**
We continuously improve our platform using the latest technology to make your work easier and more efficient.

**Our Story**

Founded in 2020, Cleaning App was born from a simple observation: the cleaning industry needed modernization. Traditional agencies took large commissions, cleaners had little flexibility, and customers struggled to find reliable service.

We built Cleaning App to solve these problems. By leveraging technology, we've created a platform that benefits everyone:

• Cleaners earn more and have more control
• Customers get quality service at fair prices
• The entire process is transparent and efficient

**Our Growth**

Since our launch, we've:

• Connected over 50,000 professional cleaners
• Facilitated over 1 million cleaning jobs
• Expanded to 150+ cities nationwide
• Maintained a 4.8-star average rating
• Paid out over \$100 million to cleaners

**Our Technology**

Our app features:

• Smart job matching algorithms
• Real-time GPS navigation
• Secure in-app messaging
• Automated payment processing
• Performance analytics and insights
• 24/7 customer support
• Multi-language support

**Our Commitment to Cleaners**

We're committed to:

• Providing steady work opportunities
• Offering competitive compensation
• Creating a supportive community
• Investing in your professional development
• Listening to your feedback
• Continuously improving our platform

**Safety First**

Your safety is our priority:

• All customers are verified
• Emergency support is available 24/7
• Safety guidelines and training provided
• Insurance coverage for job-related incidents
• Secure payment processing

**Community**

Join our growing community of professional cleaners:

• Connect with fellow cleaners
• Share tips and best practices
• Access exclusive training resources
• Participate in community events
• Benefit from group discounts on supplies

**Recognition Programs**

We celebrate our top performers:

• Monthly cleaner of the month awards
• Performance-based bonuses
• Priority job assignment for top-rated cleaners
• Annual excellence awards
• Referral bonuses

**Environmental Responsibility**

We encourage eco-friendly practices:

• Recommendations for green cleaning products
• Tips for reducing waste
• Sustainable cleaning techniques
• Partnerships with eco-friendly brands

**Looking Forward**

We're constantly evolving and improving. Upcoming features include:

• Enhanced training modules
• Advanced scheduling tools
• Expanded insurance options
• Career progression pathways
• Retirement savings programs

**Join Our Team**

We're more than just an app - we're a community of professionals working together to raise the standard of cleaning services. Whether you're a seasoned professional or just starting your career, we provide the tools, support, and opportunities you need to succeed.

**Contact Us**

We love hearing from our cleaners!

Email: info@cleaningapp.com
Phone: +1 (800) 123-4567
Support: support@cleaningapp.com
Website: www.cleaningapp.com

Follow us on social media:
• Facebook: @CleaningApp
• Instagram: @CleaningApp
• Twitter: @CleaningApp
• LinkedIn: Cleaning App

**Thank You**

Thank you for being part of the Cleaning App family. Your professionalism, dedication, and hard work make our platform successful. We're honored to support your career and look forward to growing together.

Together, we're building the future of professional cleaning services.
''';
  }

  void refreshContent() {
    isLoading.value = true;
    Future.delayed(const Duration(milliseconds: 500), () {
      isLoading.value = false;
      Get.snackbar(
        'Refreshed',
        'Content has been updated',
        snackPosition: SnackPosition.BOTTOM,
      );
    });
  }
}
