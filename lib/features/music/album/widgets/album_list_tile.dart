import 'dart:io';

import 'package:classipod/core/constants/app_palette.dart';
import 'package:classipod/core/constants/assets.dart';
import 'package:classipod/core/extensions/build_context_extensions.dart';
import 'package:classipod/features/music/album/models/album_model.dart';
import 'package:flutter/cupertino.dart';

class AlbumListTile extends StatelessWidget {
  final AlbumModel albumDetails;
  final bool isSelected;
  final bool showArtistName;
  final bool isAllSongsAlbum;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const AlbumListTile({
    super.key,
    required this.albumDetails,
    required this.isSelected,
    this.isAllSongsAlbum = false,
    this.showArtistName = true,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        height: 54,
        width: double.infinity,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border:
                isSelected
                    ? null
                    : const Border(
                      bottom: BorderSide(
                        color: AppPalette.lightDeviceFrameGradientColor1,
                      ),
                    ),
            gradient:
                isSelected
                    ? const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppPalette.selectedTileGradientColor1,
                        AppPalette.selectedTileGradientColor2,
                      ],
                    )
                    : null,
          ),
          child: Row(
            children: [
              if (isAllSongsAlbum)
                const SizedBox(
                  height: 54,
                  width: 54,
                  child: ColoredBox(
                    color: CupertinoColors.black,
                    child: Center(
                      child: Icon(
                        CupertinoIcons.music_note_2,
                        size: 40,
                        color: AppPalette.selectedTileGradientColor2,
                      ),
                    ),
                  ),
                ),
              if (!isAllSongsAlbum)
                Image(
                  image:
                      (albumDetails.albumArtPath != null)
                          ? albumDetails.isOnDevice()
                              ? FileImage(File(albumDetails.albumArtPath!))
                              : NetworkImage(albumDetails.albumArtPath!)
                          : const AssetImage(Assets.defaultAlbumCoverImage),
                  errorBuilder:
                      (_, _, _) => Image.asset(
                        Assets.defaultAlbumCoverImage,
                        fit: BoxFit.fitWidth,
                      ),
                  height: 54,
                  width: 54,
                ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      albumDetails.albumName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            isSelected
                                ? CupertinoColors.white
                                : CupertinoColors.black,
                      ),
                      maxLines: 1,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      showArtistName
                          ? albumDetails.albumArtistName
                          : context.localization.nSongs(
                            albumDetails.albumSongs.length,
                          ),
                      style: TextStyle(
                        color:
                            isSelected
                                ? CupertinoColors.white
                                : AppPalette.hintTextColor,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(
                  CupertinoIcons.right_chevron,
                  color: CupertinoColors.white,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
