# ❓ Frequently Asked Questions (FAQ)

## General

### **Q: Why are some output metrics 0.0 or placeholders?**
**A:** This happens if optional dependencies (like `lpips`, `facenet-pytorch`, or `trtexec`) are not installed. The system degrades gracefully by skipping these metrics rather than crashing. Install the full requirements to see all metrics.

### **Q: Can I run this on Windows?**
**A:** Yes, we recommend using **WSL2** (Windows Subsystem for Linux) for the best compatibility, especially for shell scripts. Native Windows support is possible but not actively tested.

## Configuration & Customization

### **Q: How do I change the model architecture?**
**A:** Modify the `model` section in your YAML config. You can switch between registered models (e.g., `UNet` vs. `ResNet`) by changing the `type` field.

### **Q: How do I ensure my experiments are reproducible?**
**A:** 
1. Always set a `seed` in your config.
2. Use the same `manifest.json` (dataset version).
3. The system automatically saves the used config and code snapshot in `work_dirs/`.

## Performance

### **Q: How do I benchmark edge FPS?**
**A:** Use the `scripts/benchmark_edge.sh` script. It runs the exported model and measures pure inference latency. For real-world results, run this on the target device (e.g., Jetson Nano).

### **Q: Why is ONNX export failing?**
**A:** Ensure your checkpoint path is correct and that the model contains no dynamic control flow (unless scripted). Check the `opset_version` in `export.yaml`.