#!/bin/bash
# Usage: ./build-gallery.sh lemans
# Place originals in: uploads/lemans/originals/

GALLERY="$1"
SOURCE_DIR="uploads/$GALLERY/originals"
OUT_DIR="uploads/$GALLERY"

mkdir -p "$OUT_DIR/thumbs" "$OUT_DIR/previews" "$OUT_DIR/watermarked"

for img in "$SOURCE_DIR"/*.{jpg,jpeg,png}; do
  filename=$(basename "$img")

  # Generate thumbnail (square crop)
  convert "$img" -resize 300x300^ -gravity center -extent 300x300 "$OUT_DIR/thumbs/$filename"

  # Generate preview (blurry placeholder)
  convert "$img" -resize 30% -blur 0x8 "$OUT_DIR/previews/$filename"

  # Generate watermarked full image (resized)
  convert "$img" -resize 1600x1600 -gravity southeast -draw "image Over 0,0 0,0 'watermark.png'" "$OUT_DIR/watermarked/$filename"
done