import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/core/utils/app_colors.dart';
import 'package:tasks/src/core/utils/app_text_theme.dart';
import 'package:tasks/src/core/utils/gaps.dart';
import 'package:tasks/src/models/trip_model.dart';
import 'package:intl/intl.dart';

class TripCard extends StatelessWidget {
  final Trip trip;
  const TripCard({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(16),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: trip.coverImage,
              fit: BoxFit.cover,
              placeholder: (context, url) => SizedBox(
                height: 150,
                width: 164,
                child: Center(
                  child: CircularProgressIndicator(color: AppColors.grey100),
                ),
              ),
              errorWidget: (context, _, __) => CachedNetworkImage(
                imageUrl:
                    'https://www.shutterstock.com/image-vector/your-media-placeholder-simulate-photo-260nw-2115837101.jpg',
                fit: BoxFit.fill,
                width: 32,
                height: 32,
              ),
            ),
          ),
          // Image.network(
          //   trip.coverImage,
          //   fit: BoxFit.cover,
          //   width: double.infinity,
          //   height: double.infinity,
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.all(16),
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: .6),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Icon(Icons.more_horiz_rounded, color: AppColors.white),
              ),
            ],
          ),
          Align(
            alignment: AlignmentGeometry.bottomLeft,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.only(
                bottom: 16,
                right: 16,
                left: 16,
                top: 30,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xff262626),
                    Color(0xff262626),
                    Color(0xff262626),
                    Color(0xff262626),
                    Color(0xff262626).withValues(alpha: .9),
                    // Color(0xff262626).withValues(alpha: .2),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      border: Border.all(color: Color(0xffC25F30)),
                    ),
                    decoration: BoxDecoration(
                      color: Color(0xffC25F30).withValues(alpha: .1),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          trip.status,
                          style: AppTheme.bodyLargeTextStyle.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                        AppGaps.wGap10,
                        Icon(Icons.keyboard_arrow_down, color: AppColors.white),
                      ],
                    ),
                  ),
                  AppGaps.hGap16,
                  Text(
                    trip.title,
                    style: AppTheme.bodyLargeSemiboldTextStyle.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                  AppGaps.hGap6,
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month_rounded,
                        color: Color(0xff999999),
                      ),
                      AppGaps.wGap6,
                      Text(
                        '5 Nights (${formattedDateRange(trip.dates.start, trip.dates.end)})',
                        style: TextStyle(color: Color(0xff999999)),
                      ),
                    ],
                  ),
                  AppGaps.hGap12,
                  Divider(color: Colors.grey[800]),
                  AppGaps.hGap12,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Overlapping Avatars
                      SizedBox(
                        height: 36,
                        width: 60,
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            if (trip.participants.isNotEmpty) ...[
                              for (
                                int i = 0;
                                i < trip.participants.length;
                                i++
                              ) ...[
                                Positioned(
                                  left: i * 22, // overlap effect
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundImage: NetworkImage(
                                        trip.participants[i].avatarUrl,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: (i + 1) * 22, // overlap effect
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.black,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundColor: Colors.grey[800],
                                      child: Text(
                                        '+${trip.participants.length - 3}',
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],

                              // Positioned(
                              //   left: 3 * 22,
                              //   child: CircleAvatar(
                              //     radius: 18,
                              //     backgroundColor: Colors.black,
                              //     child: CircleAvatar(
                              //       radius: 16,
                              //       backgroundColor: Colors.grey[800],
                              //       child: Text(
                              //         '+${trip.participants.length - 3}',
                              //         style: const TextStyle(
                              //           color: Colors.white,
                              //           fontSize: 12,
                              //           fontWeight: FontWeight.w600,
                              //         ),
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ],
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '5 unfinished tasks',
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
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
}

String formattedDateRange(String startDate, String endDate) {
  try {
    final start = DateFormat('dd-MM-yyyy').parse(startDate);
    final end = DateFormat('dd-MM-yyyy').parse(endDate);
    final sameYear = start.year == end.year;

    final startStr = DateFormat('MMM d').format(start); // Jan 16
    final endStr = DateFormat('MMM d').format(end); // Jan 20

    return sameYear
        ? '$startStr – $endStr, ${start.year}'
        : '${DateFormat('MMM d, yyyy').format(start)} – ${DateFormat('MMM d, yyyy').format(end)}';
  } catch (e) {
    return '$startDate – $endDate';
  }
}
