# 💾 Data & Manifests

This guide details how the system handles the **LFW (Labeled Faces in the Wild)** dataset, from downloading to alignment and manifestation.

## 🗂️ Directory Structure

The system expects the following data layout:

```text
data/
└── lfw/
    ├── raw/              # Original downloads
    │   └── <person>/
    │       └── <image>.jpg
    ├── processed/        # Aligned & cropped images
    │   └── <person>/
    │       └── <image>.jpg
    └── manifest.json     # Dataset metadata and splits
```

## 🔄 Data Pipeline

### 1. Download & Ingestion
The pipeline uses the Kaggle API to fetch the LFW dataset.
- **Input**: `data/lfw/raw/` (plus `pairs.txt` files).
- **Command**: `bash scripts/prepare_data.sh`

### 2. Alignment (Preprocessing)
- **Method**: MTCNN (Multi-task Cascaded Convolutional Networks).
- **Crop Size**: 160x160 pixels (default).
- **Fallback**: If no face is detected, the raw image is resized and copied to `processed/` to maintain dataset integrity.
- **Logging**: Progress is logged every ~200 images.

### 3. Manifest Generation
A `manifest.json` file is generated to track dataset state.
- **Content**:
  - `version`: Dataset version string.
  - `items`: List of images with ID, path, and checksum.
  - `splits`: Recommended train/val/test splits (80/10/10).
  - `checksums`: For data integrity verification.

## 🧪 Validation

Always validate your dataset after preparation.

```bash
bash scripts/validate_manifest.sh
```

**Checks Performed:**
- Existence of all files referenced in the manifest.
- Checksum verification (if enabled).
- Split consistency.

## 🧩 Splits

The default split strategy is consistent across runs to ensure fair comparisons:
- **Train**: 80%
- **Validation**: 10%
- **Test**: 10%

## 🎨 Augmentations

Augmentations are registered components applied dynamically during training.

- **Class**: `registry.augmentations.LightAugmentation`
- **Features**: 
  - Color Jitter (brightness/contrast)
  - Horizontal Flip
  - Gaussian Blur (mild)
- **Determinism**: Random seeds are fixed during training for reproducibility.
