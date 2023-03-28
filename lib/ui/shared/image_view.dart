import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:news_app_xcenter_tech/ui/shared/spinning_lines.dart';
import 'package:news_app_xcenter_tech/utils/extension_functions.dart';

class NetworkImageView extends StatelessWidget {
  final String? url;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final IconData? errorIcon;
  final BorderRadius? borderRadius;
  final Color? color;
  final BlendMode? colorBlendMode;

  const NetworkImageView({
    Key? key,
    this.url,
    this.width,
    this.height,
    this.fit,
    this.errorIcon,
    this.borderRadius,
    this.color,
    this.colorBlendMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0.0),
        child: url != null && url!.isNotEmpty
            ? theme.linuxPlatform
                ? Image.network(
                    url!,
                    width: width,
                    height: height,
                    fit: fit,
                    color: color,
                    colorBlendMode: colorBlendMode,
                    loadingBuilder: (_, child, ice) =>
                        _placeholderContainer(theme),
                    errorBuilder: (_, obj, err) => _errorContainer(theme),
                  )
                : CachedNetworkImage(
                    imageUrl: url!,
                    width: width,
                    height: height,
                    fit: fit,
                    color: color,
                    colorBlendMode: colorBlendMode,
                    errorWidget: (_, url, err) => _errorContainer(theme),
                    placeholder: (_, url) => _placeholderContainer(theme),
                  )
            : _errorContainer(theme),
      ),
    );
  }

  /// Error Container
  Widget _errorContainer(ThemeData theme) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.dividerColor,
        borderRadius: borderRadius ?? BorderRadius.circular(0.0),
      ),
      child: Center(
        child: Icon(
          errorIcon ?? Icons.image,
          color: theme.hintColor,
          size: width != null
              ? width! / 2
              : height != null
                  ? height! / 2
                  : null,
        ),
      ),
    );
  }

  /// Placeholder or Loading Container
  Widget _placeholderContainer(ThemeData theme) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.hintColor.withOpacity(0.1),
        borderRadius: borderRadius ?? BorderRadius.circular(0.0),
      ),
      alignment: Alignment.center,
      child: Center(
        child: SpinningLines(
          color: theme.colorScheme.primary,
          itemCount: 1,
          duration: const Duration(
            milliseconds: 1500,
          ),
          size:
              width != null && height != null && width! <= 500 && height! <= 500
                  ? width! > height!
                      ? height! * 0.25
                      : width! * 0.25
                  : width != null
                      ? width! * 0.2
                      : height != null
                          ? height! * 0.2
                          : 36.0,
          lineWidth: 3.0,
        ),
      ),
    );
  }
}

/// Widget for local image
class LocalImageView extends StatelessWidget {
  final String? path;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final BorderRadius? borderRadius;
  final IconData? errorIcon;
  final Color? color;
  final BlendMode? colorBlendMode;

  const LocalImageView({
    Key? key,
    required this.path,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
    this.errorIcon,
    this.color,
    this.colorBlendMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(0.0),
        child: path != null && path!.isNotEmpty
            ? path!.contains("assets/images/")
                ? Image.asset(
                    path!,
                    width: width,
                    height: height,
                    fit: fit,
                    errorBuilder: (_, obj, err) => _errorContainer(theme),
                    color: color,
                    colorBlendMode: colorBlendMode,
                  )
                : kIsWeb
                    ? Image.network(
                        path!,
                        width: width,
                        height: height,
                        fit: fit,
                        errorBuilder: (_, obj, err) => _errorContainer(theme),
                        color: color,
                        colorBlendMode: colorBlendMode,
                      )
                    : Image.file(
                        File(path!),
                        width: width,
                        height: height,
                        fit: fit,
                        errorBuilder: (_, obj, err) => _errorContainer(theme),
                        color: color,
                        colorBlendMode: colorBlendMode,
                      )
            : _errorContainer(theme),
      ),
    );
  }

  /// Error Container
  Widget _errorContainer(ThemeData theme) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: theme.dividerColor,
        borderRadius: borderRadius ?? BorderRadius.circular(0.0),
      ),
      child: Center(
        child: Icon(
          errorIcon ?? Icons.image,
          color: theme.hintColor,
          size: width != null
              ? width! / 2
              : height != null
                  ? height! / 2
                  : null,
        ),
      ),
    );
  }
}
