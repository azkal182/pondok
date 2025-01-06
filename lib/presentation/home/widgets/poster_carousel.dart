import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pondok/presentation/home/blocs/poster_bloc.dart';
import 'package:shimmer/shimmer.dart';

class PosterCarousel extends StatelessWidget {
  const PosterCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: BlocBuilder<PosterBloc, PosterState>(
        builder: (context, state) {
          List<Widget> items;

          // Placeholder items (5 item angka)
          List<int> list = [1, 2, 3, 4, 5];

          switch (state.runtimeType) {
            case PosterLoading:
              items = list.map((item) => _buildPlaceholderItem()).toList();
              break;

            case PosterLoaded:
              final posterState = state as PosterLoaded;
              items = posterState.posters
                  .map((poster) => _buildPosterItem(poster.url))
                  .toList();
              break;

            default:
              items = list.map((item) => _buildPlaceholderItem()).toList();
          }

          return CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 3.0,
              autoPlayAnimationDuration: const Duration(seconds: 1),
              autoPlayInterval: const Duration(seconds: 10),
              viewportFraction: 0.9,
            ),
            items: items,
          );
        },
      ),
    );
  }

  Widget _buildPosterItem(String url) {
    return AspectRatio(
      aspectRatio: 3.0,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: const Color(0xFFD9D9D9),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        clipBehavior: Clip.hardEdge,
        child: Image.network(
          url,
          fit: BoxFit.fill,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(child: Icon(Icons.error, color: Colors.red));
          },
        ),
      ),
    );
  }

  Widget _buildPlaceholderItem() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: AspectRatio(
        aspectRatio: 3.0,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7),
            color: const Color(0xFFD9D9D9),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    );
  }
}
