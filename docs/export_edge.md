# ⚡ Export & Edge Deployment

This guide covers exporting trained models to **ONNX** and **TensorRT** for high-performance inference on edge devices (e.g., NVIDIA Jetson).

## 🎯 Goals

- **Portability**: Run models without PyTorch dependencies (via ONNX Runtime).
- **Performance**: Optimize for low latency and high throughput (via TensorRT).
- **Benchmarking**: Accurately measure FPS and latency on target hardware.

## 🛠️ Prerequisites

- **Host**: PyTorch (CPU sufficient for export).
- **Target**: `trtexec` (part of TensorRT), `onnxruntime`.

## 📦 ONNX Export

Export a trained checkpoint to ONNX format.

- **Class**: `src.exporters.onnx_exporter.ONNXExporter`
- **Script**: `bash scripts/export.sh`
- **Config**: `configs/face_swap/export.yaml`

**Process:**
1. Loads the checkpoint (e.g., `best.pth`).
2. Traces the model using `torch.onnx.export`.
3. Verifies the output graph structure.
4. Output: `model.onnx` in the specified export directory.

## 🚀 TensorRT Conversion

Convert the ONNX model to a TensorRT engine (`.trt`) for maximum performance on NVIDIA GPUs.

- **Class**: `src.exporters.tensorrt_exporter.TensorRTExporter`
- **Script**: `bash scripts/trt.sh`
- **Config**: `configs/face_swap/trt.yaml`

**Process:**
1. Validates `trtexec` availability in `$PATH`.
2. Constructs the build command (precision, workspace size).
3. Compiles the ONNX graph into a hardware-specific engine.
4. Output: `model.trt`

**Note**: TensorRT engines are **hardware-specific**. You must build them on the target device (e.g., on the Jetson Nano itself).

## ⏱️ Edge Benchmark

Measure inference performance (Latency & FPS).

- **Script**: `bash scripts/benchmark_edge.sh`
- **Backends**: 
  - `pytorch` (native)
  - `onnxruntime` (CPU/CUDA)
  - `tensorrt` (if engine exists)

**Metrics:**
- `Latency (ms)`: End-to-end time per batch.
- `FPS`: Frames per second at configured resolution (default 720p).
- **Output**: `benchmark.json`

## 🧪 Verification

### ONNX Runtime
The `src.exporters.onnxruntime_runner.Runner` utility validates the exported ONNX model by running a sample inference pass and comparing outputs against the PyTorch baseline (if available).

### Packaging for Deployment
When deploying to edge, package the following:
1. `model.onnx` (or `model.trt`)
2. `benchmark.json` (performance baseline)
3. `sample_input.jpg` (for sanity checks)

## ⚠️ Known Issues

- **Opset Version**: Ensure your ONNX Opset version matches the target runtime support (default: 11).
- **FP16**: Use FP16 mode in TensorRT for significant speedups on Jetson Orin/Xavier.
