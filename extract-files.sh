#!/bin/bash

SRC="$HOME/firmware_dump"
VENDOR_DIR="$HOME/android_vendor_tecno_KM7k"
PROP_FILE="proprietary-files.txt"
MK_FILE="$VENDOR_DIR/KM7k-vendor.mk"

echo "Magsisimula na ang extraction at pagbuo ng vendor makefile..."
mkdir -p "$VENDOR_DIR/proprietary"

# 1. Simulan ang KM7k-vendor.mk na may Soong Namespaces
cat << EOF > "$MK_FILE"
# KM7k-vendor.mk for Tecno KM7k (Auto-generated)
PRODUCT_SOONG_NAMESPACES += \\
    vendor/tecno/KM7k

EOF

# 2. Basahin ang proprietary-files.txt at kopyahin ang mga files
grep -v "^#" "$PROP_FILE" | grep -v "^$" | while read -r line; do
    FILE_PATH=$(echo "$line" | cut -d';' -f1 | cut -d'|' -f1 | sed 's/^-//' | xargs)
    FOUND=0
    
    for PART in "" "vendor/" "system/" "system/system/" "system_ext/" "product/" "odm/"; do
        if [ -f "$SRC/$PART$FILE_PATH" ]; then
            DEST_FILE="$VENDOR_DIR/proprietary/$FILE_PATH"
            mkdir -p "$(dirname "$DEST_FILE")"
            cp "$SRC/$PART$FILE_PATH" "$DEST_FILE"
            echo "Nakuha: $FILE_PATH"
            
            # Idagdag agad ang PRODUCT_COPY_FILES mapping sa KM7k-vendor.mk
            echo "PRODUCT_COPY_FILES += vendor/tecno/KM7k/proprietary/$FILE_PATH:$FILE_PATH" >> "$MK_FILE"
            
            FOUND=1
            break
        fi
    done
    
    if [ $FOUND -eq 0 ]; then
        echo "NAWAWALA: $FILE_PATH"
    fi
done

echo "===================================="
echo "Tapos na! Na-update na ang KM7k-vendor.mk at ang mga proprietary blobs."



