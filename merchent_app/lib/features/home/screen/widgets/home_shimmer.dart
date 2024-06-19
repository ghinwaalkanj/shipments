import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sizer/sizer.dart';
import 'package:shipment_merchent_app/common/widgets/custom_sized_box.dart';

class HomeShimmerWidget extends StatelessWidget {
  const HomeShimmerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            child: Row(
              children: [
                _buildShimmerContainer(width: 75.w, height: 6.h),
                SizedBox(
                  width: 2.w,
                ),
                _buildShimmerContainer(width: 15.w, height: 6.h),
              ],
            ),
          ),
          CustomSizedBox.itemSpacingVertical(),
          _buildShimmerText(width: 30.w, height: 2.h),
          CustomSizedBox.itemSpacingVertical(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildShimmerContainer(width: 40.w, height: 18.h),
              _buildShimmerContainer(width: 40.w, height: 18.h),
            ],
          ),
          CustomSizedBox.itemSpacingVertical(),
          _buildShimmerCarousel(),
          CustomSizedBox.itemSpacingVertical(),
          _buildShimmerText(width: 50.w, height: 2.h),
          CustomSizedBox.itemSpacingVertical(),
          _buildShimmerShipmentList(),
        ],
      ),
    );
  }

  Widget _buildShimmerContainer({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
    );
  }

  Widget _buildShimmerText({required double width, required double height}) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }

  Widget _buildShimmerCarousel() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Container(
        height: 20.h,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.sp),
        ),
      ),
    );
  }

  Widget _buildShimmerShipmentList() {
    return Column(
      children: List.generate(1, (index) {
        return Padding(
          padding: EdgeInsets.only(right: 2.w, bottom: 2.h),
          child: Container(
            height: 30.h,
            width: 90.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.sp),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 2.h, horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildShimmerText(width: 30.w, height: 2.h),
                          CustomSizedBox.textSpacingVertical(),
                          _buildShimmerText(width: 20.w, height: 2.h),
                        ],
                      ),
                      _buildShimmerContainer(width: 30.w, height: 5.h),
                    ],
                  ),
                  CustomSizedBox.itemSpacingVertical(height: 3),
                  _buildShimmerContainer(width: double.infinity, height: 5.h),
                  CustomSizedBox.itemSpacingVertical(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          _buildShimmerText(width: 10.w, height: 2.h),
                          CustomSizedBox.textSpacingVertical(),
                          _buildShimmerText(width: 20.w, height: 2.h),
                          CustomSizedBox.textSpacingVertical(),
                          _buildShimmerText(width: 15.w, height: 2.h),
                        ],
                      ),
                      Column(
                        children: [
                          _buildShimmerText(width: 10.w, height: 2.h),
                          CustomSizedBox.textSpacingVertical(),
                          _buildShimmerText(width: 20.w, height: 2.h),
                          CustomSizedBox.textSpacingVertical(),
                          _buildShimmerText(width: 15.w, height: 2.h),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
