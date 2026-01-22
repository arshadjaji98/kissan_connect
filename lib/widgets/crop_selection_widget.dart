// lib/widgets/crop_selection_widget.dart
import 'package:flutter/material.dart';
import 'package:kissan_connect_app_2/l10n/app_localizations.dart';

class CropSelectionWidget extends StatefulWidget {
  final Function(List<String>)? onCropsSelected;
  final List<String>? initialSelectedCrops;

  const CropSelectionWidget({
    super.key,
    this.onCropsSelected,
    this.initialSelectedCrops,
  });

  @override
  State<CropSelectionWidget> createState() => _CropSelectionWidgetState();
}

class _CropSelectionWidgetState extends State<CropSelectionWidget> {
  late List<String> _selectedCrops;

  final List<String> _cropKeys = [
    'wheat',
    'rice',
    'cotton',
    'sugarcane',
    'maize',
    'vegetables',
  ];

  String _getLocalizedCropName(AppLocalizations localizations, String key) {
    switch (key) {
      case 'wheat':
        return localizations.wheat;
      case 'rice':
        return localizations.rice;
      case 'cotton':
        return localizations.cotton;
      case 'sugarcane':
        return localizations.sugarcane;
      case 'maize':
        return localizations.maize;
      case 'vegetables':
        return localizations.vegetables;
      default:
        return key; // fallback
    }
  }

  @override
  void initState() {
    super.initState();
    // Initialize with initialSelectedCrops if provided, otherwise default to ["wheat"]
    _selectedCrops = List.from(widget.initialSelectedCrops ?? ["wheat"]);

    // Ensure at least one crop is always selected
    if (_selectedCrops.isEmpty) {
      _selectedCrops = ["wheat"];
    }

    // Notify parent about initial selection
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.onCropsSelected != null) {
        widget.onCropsSelected!(_selectedCrops);
      }
    });
  }

  void _toggleCropSelection(String cropKey) {
    setState(() {
      if (_selectedCrops.contains(cropKey)) {
        _selectedCrops.remove(cropKey);
      } else {
        _selectedCrops.add(cropKey);
      }

      // Ensure at least one crop is always selected
      if (_selectedCrops.isEmpty) {
        _selectedCrops.add("wheat");
      }

      // Notify parent about selection changes
      if (widget.onCropsSelected != null) {
        widget.onCropsSelected!(_selectedCrops);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Crop selection grid - 3 columns
          GridView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 2.5,
            ),
            itemCount: _cropKeys.length,
            itemBuilder: (context, index) {
              final cropKey = _cropKeys[index];
              final cropName = _getLocalizedCropName(localizations, cropKey);
              final isSelected = _selectedCrops.contains(cropKey);

              return GestureDetector(
                onTap: () {
                  _toggleCropSelection(cropKey);
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF4CAF50) : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF4CAF50)
                          : Colors.grey[300]!,
                      width: 1.5,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      cropName,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.zero,
            child: Text(
              localizations.selectMultipleCrops,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
