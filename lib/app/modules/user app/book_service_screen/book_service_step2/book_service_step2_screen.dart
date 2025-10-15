import 'package:cleaning_app/app/modules/user%20app/book_service_screen/book_service_step1/book_service_step1_screen_controller.dart';
import 'package:cleaning_app/app/utils/app_export.dart';
import 'book_service_step2_screen_controller.dart';

class BookServiceStep2Screen extends StatelessWidget {
  BookServiceStep2Screen({super.key});

  final bookServiceStep1Controllerr = Get.find<BookServiceStep1ScreenController>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookServiceStep2ScreenController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColours.white,
          appBar: AppStyle.appBarStyle(controller.appBarTitle.value),
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.05),
              child: SingleChildScrollView(
                // padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppStyle.heightPercent(context, 1.5)),

                    // Title
                    _buildTitle(),

                    SizedBox(height: AppStyle.heightPercent(context, 0.5)),

                    // Subtitle
                    _buildSubtitle(),

                    SizedBox(height: AppStyle.heightPercent(context, 1)),

                    // Add-ons grid
                    _buildAddOnsGrid(controller),

                    SizedBox(height: AppStyle.heightPercent(context, 2)),

                    // Information banner
                    _buildInfoBanner(),

                    SizedBox(height: AppStyle.heightPercent(context, 10)), // Space for fixed footer
                  ],
                ),
              ),
            ),
          ),
          
          // Fixed footer
          bottomNavigationBar: _buildFooter(controller,context,bookServiceStep1Controllerr),
        );
      },
    );
  }


  Widget _buildTitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Step indicator
        Text(
          'Step 2 of 4',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontFamily: AppFonts.fontFamily,
          ),
        ),

        SizedBox(height: 5),
        
        // Main title
        const Text(
          AppStrings.popularAddOns,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColours.black,
            fontFamily: AppFonts.fontFamily,
          ),
        ),
      ],
    );
  }

  Widget _buildSubtitle() {
    return const Text(
      AppStrings.peopleAlsoAdded,
      style: TextStyle(
        fontSize: 16,
        color: AppColours.black,
        fontFamily: AppFonts.fontFamily,
      ),
    );
  }

  Widget _buildAddOnsGrid(BookServiceStep2ScreenController controller) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: controller.addOnServices.length,
      itemBuilder: (context, index) {
        final addOn = controller.addOnServices[index];
        return _buildAddOnCard(addOn, controller);
      },
    );
  }

  Widget _buildAddOnCard(AddOnService addOn, BookServiceStep2ScreenController controller) {
    final isSelected = controller.isAddOnSelected(addOn.id);
    
    return Container(
      decoration: BoxDecoration(
        color: AppColours.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? AppColours.appColor : Colors.grey[300]!,
          width: isSelected ? 2 : 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container
          Expanded(
            flex: 2,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    color: Colors.grey[200],
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Image.asset(
                      addOn.image,
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: Colors.grey[300],
                          child: const Icon(
                            Icons.spa,
                            color: AppColours.appColor,
                            size: 40,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                
                // Add button
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => controller.toggleAddOn(addOn.id),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: isSelected ? AppColours.appColor : Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        isSelected ? Icons.check : Icons.add,
                        color: isSelected ? AppColours.white : AppColours.appColor,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          // Content
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    addOn.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColours.black,
                      fontFamily: AppFonts.fontFamily,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),

                  const SizedBox(height: 4),

                  // Learn More link
                  GestureDetector(
                    onTap: () {
                      // TODO: Show add-on details
                    },
                    child: const Text(
                      AppStrings.learnMore,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColours.appColor,
                        fontFamily: AppFonts.fontFamily,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),

                  // const Spacer(),

                  // Price
                  Row(
                    children: [
                      Text(
                        'AED ${addOn.price.toInt()}',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColours.black,
                          fontFamily: AppFonts.fontFamily,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'AED ${addOn.originalPrice.toInt()}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[500],
                          fontFamily: AppFonts.fontFamily,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoBanner() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColours.appColor,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.info_outline,
              color: AppColours.white,
              size: 16,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              AppStrings.theDurationOfTheSessionMayChangeBasedOnYourSelection,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
                fontFamily: AppFonts.fontFamily,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BookServiceStep2ScreenController controller,BuildContext context, BookServiceStep1ScreenController bookStep1Controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Total section
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  AppStrings.total,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                    fontFamily: AppFonts.fontFamily,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Obx(() => Text(
    'AED ${controller.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontFamily: AppFonts.fontFamily,
                      ),
                    )),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: (){
                        bookStep1Controller.showBookingSummaryBottomSheet(context);
                      },
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: Colors.black,
                        size: 24,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 16),

          // Next button
          SizedBox(
            height: AppStyle.heightPercent(context, 5),
            width: AppStyle.widthPercent(context, 30),
            child: AppButton(onPressed: (){
              Get.toNamed(AppRoutes.bookServiceStep3,arguments: controller.appBarTitle);
            }, title: AppStrings.next,),
          ),
        ],
      ),
    );
  }
}
