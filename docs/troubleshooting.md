# 🔧 Troubleshooting

Common issues and solutions for the Face Swap System.

## 📦 Dependencies

### `ModuleNotFound: No module named 'torch'`
**Cause**: PyTorch is not installed.
**Fix**:
```bash
# CPU
python -m pip install torch==2.3.1 torchvision==0.18.1 --index-url https://download.pytorch.org/whl/cpu
```

### `trtexec not found`
**Cause**: TensorRT is missing or not in `$PATH`.
**Fix**: Install TensorRT (NVIDIA developer account required) and add `bin/` to your PATH.

### Metrics Missing (LPIPS/ArcFace)
**Cause**: Optional dependencies `lpips` or `facenet-pytorch` are missing.
**Fix**:
```bash
pip install lpips facenet-pytorch
```
*Note: The system will fall back to placeholder metrics if these are absent.*

## 💾 Data & Manifests

### Manifest Errors
**Error**: `FileNotFoundError: .../processed/...`
**Fix**:
1. Run `bash scripts/validate_manifest.sh`.
2. If invalid, regenerate the dataset: `bash scripts/prepare_data.sh`.

## 🚢 Export & Inference

### ONNX Export Failure
**Cause**: Model architecture uses operations not supported by the selected ONNX opset.
**Fix**: Check `configs/face_swap/export.yaml` and try increasing the `opset_version` (e.g., to 14 or 17).

### Streaming Output Empty
**Cause**: The streaming pipeline currently defaults to logging-only mode.
**Fix**: Update `src/pipelines/streaming.py` to enable frame writing if visual output is required.

## 🔍 CI/CD

### MyPy Failures
**Cause**: Missing type stubs or optional dependencies.
**Fix**: Ensure all dev dependencies are installed or add `# type: ignore` for external libraries without stubs.