import 'package:flutter/material.dart';

class RatingBox extends StatelessWidget {
  final String label;
  final int rating;
  final void Function(int)? onRatingSelected;  // OPCIONAL

  const RatingBox({
    super.key,
    required this.label,
    required this.rating,
    this.onRatingSelected,  // OPCIONAL
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Row(
          children: List.generate(
            5,
                (index) {
              final starIndex = index + 1;
              return GestureDetector(
                onTap: onRatingSelected != null
                    ? () => onRatingSelected!(starIndex)
                    : null,
                child: Icon(
                  starIndex <= rating ? Icons.star : Icons.star_border,
                  color: Colors.amber,
                  size: 20,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
