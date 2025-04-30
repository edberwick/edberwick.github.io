#!/bin/bash
# Usage: ./build-gallery.sh lemans

GALLERY="$1"
SOURCE_DIR="uploads/$GALLERY/originals"
OUT_DIR="uploads/$GALLERY"

mkdir -p "$OUT_DIR/thumbs" "$OUT_DIR/previews" "$OUT_DIR/watermarked"
echo "📸 Building gallery for $GALLERY"

shopt -s nullglob  # Avoid errors if no matches
for img in "$SOURCE_DIR"/*.{jpg,jpeg,png,JPG,JPEG,PNG}; do
  filename=$(basename "$img")

  echo "Processing $filename"

  # Thumbnail (crop)
  magick "$img" -resize 300x300 "$OUT_DIR/thumbs/$filename"

  # Preview (blurry placeholder)
  magick "$img" -resize 30% -blur 0x8 "$OUT_DIR/previews/$filename"

  # Watermarked full image
  magick "$img" -resize 1600x1600 -gravity center -draw "image Over 0,0 0,0 'watermark.png'" "$OUT_DIR/watermarked/$filename"
done
shopt -u nullglob

echo "✅ Done!"