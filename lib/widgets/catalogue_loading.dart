import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CatalogueLoading extends StatelessWidget {
  const CatalogueLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.pink.shade50,
      enabled: true,
      direction: ShimmerDirection.ltr,
      child: GridView.builder(
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 8,
          mainAxisExtent: 300,
        ),
        itemCount: 20,
        itemBuilder: (context, index) => Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 0.1,
              color: Colors.grey.shade500,
            ),
          ),
          child: Stack(
            children: [
              Column(
                children: [
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      border: Border.all(
                        width: 0.1,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: 160,
                right: 8,
                child: Container(
                  width: 83,
                  height: 32,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey.shade100,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
