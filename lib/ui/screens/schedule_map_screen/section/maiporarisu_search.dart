import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class MaiporarisuSearch extends ConsumerWidget {
  MaiporarisuSearch({
    super.key,
    required this.destinationPosition,
    required this.onDestinationPositionChanged,
  });
  LatLng destinationPosition;
  final Function(LatLng) onDestinationPositionChanged;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController controller = TextEditingController();

    String getGoogleApiKey() {
      if (Platform.isAndroid) {
        return dotenv.env['GOOGLE_API_ANDROID']!;
      } else if (Platform.isIOS) {
        return dotenv.env['GOOGLE_API_IOS']!;
      } else {
        return dotenv.env['GOOGLE_API_WEB']!;
      }
    }

    return GooglePlaceAutoCompleteTextField(
      textEditingController: controller,
      googleAPIKey: getGoogleApiKey(),
      inputDecoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
        hintText: '場所を検索',
        hintStyle: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        fillColor: Color.alphaBlend(
          Theme.of(context).colorScheme.primary.withOpacity(0.08),
          Theme.of(context).colorScheme.background,
        ),
        filled: true,
      ),
      debounceTime: 400,
      countries: const ['jp'],
      isLatLngRequired: true,
      getPlaceDetailWithLatLng: (prediction) {
        destinationPosition = LatLng(
          double.tryParse(prediction.lat!) ?? 0,
          double.tryParse(prediction.lng!) ?? 0,
        );
        if (kDebugMode) {
          debugPrint('destinationPosition: $destinationPosition');
        }
        onDestinationPositionChanged(destinationPosition);
      },
      itemClick: (prediction) {
        controller.text = prediction.description ?? '';
        controller.selection = TextSelection.fromPosition(
          TextPosition(offset: prediction.description?.length ?? 0),
        );
      },
      seperatedBuilder: const Divider(),
      // OPTIONAL// If you want to customize list view item builder
      itemBuilder: (context, index, prediction) {
        return Container(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              const Icon(Icons.location_on),
              const SizedBox(
                width: 6,
              ),
              Expanded(
                child: Text(
                  '${prediction.structuredFormatting?.mainText} \n ${prediction.structuredFormatting?.secondaryText}',
                ),
              ),
            ],
          ),
        );
      },
      isCrossBtnShown: true,
    );
  }
}
