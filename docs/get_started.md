# 🚀 Getting Started

This guide will help you set up the **Face Swap System**, prepare your environment, and run your first experiment.

## 🛠️ Prerequisites

- **OS**: Linux (Ubuntu 20.04+), macOS (13+), or Windows (WSL2 recommended)
- **Python**: 3.11+
- **Conda**: Miniconda or Anaconda recommended

## 📦 Installation

### 1. Clone the Repository

```bash
git clone https://github.com/your-org/face_swap.git
cd face_swap
```

### 2. Create Environment

We recommend using Conda to manage dependencies.

```bash
conda create -n face_swap python=3.11 -y
conda activate face_swap
```

### 3. Install Dependencies

Install the core requirements. For specific hardware (CPU vs GPU), see below.

```bash
pip install -r requirements.txt
```

**For CPU-only (macOS/Linux):**
```bash
# Optimized torch wheels for CPU
python -m pip install torch==2.3.1 torchvision==0.18.1 --index-url https://download.pytorch.org/whl/cpu
```

## 💾 Data Preparation (LFW)

The system is designed to work with the **Labeled Faces in the Wild (LFW)** dataset.

1. **Download & Align**:
   Use the provided script to download the dataset (via Kaggle) and perform face alignment.
   
   *Note: Requires `KAGGLE_USERNAME` and `KAGGLE_KEY` environment variables.*

   ```bash
   bash scripts/prepare_data.sh
   ```

   **What this does:**
   - Downloads LFW raw images to `data/lfw/raw/`.
   - Aligns faces using MTCNN to `data/lfw/processed/`.
   - Generates a manifest file `data/lfw/manifest.json`.

2. **Validate**:
   Ensure the data is correctly processed.

   ```bash
   bash scripts/validate_manifest.sh
   ```

## 🏃‍♂️ Running Your First Experiment

### 1. Training

Train the baseline model using the default configuration.

```bash
bash scripts/train.sh
```
*Config: `configs/face_swap/baseline.yaml`*

### 2. Evaluation

Evaluate the trained model's performance.

```bash
bash scripts/eval.sh
```
*Config: `configs/face_swap/eval.yaml`*

### 3. Inference

Run face swapping on a batch of images.

```bash
bash scripts/infer.sh
```
*Config: `configs/face_swap/infer.yaml`*

## 🚢 Next Steps

- **[Configuration Guide](configs.md)**: Learn how to customize experiments.
- **[Edge Deployment](export_edge.md)**: Export models to ONNX/TensorRT.
- **[Streaming](streaming.md)**: Set up real-time inference.