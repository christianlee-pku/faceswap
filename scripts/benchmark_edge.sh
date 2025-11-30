#!/usr/bin/env bash
set -euo pipefail
export PYTHONPATH="${PYTHONPATH:-src}"
CONFIG=${1:-"configs/face_swap/export.yaml"}
CKPT=${2:-"work_dirs/face_swap/lfw-unet-baseline-001/checkpoints/epoch_01.pt"}
EXPORT_DIR=${3:-"work_dirs/exports/lfw-unet-baseline-001"}
TARGET=${4:-"jetson"}
python -m interfaces.cli benchmark-edge --config "$CONFIG" --checkpoint "$CKPT" --export-dir "$EXPORT_DIR" --target "$TARGET"
