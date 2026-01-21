# ⚙️ Configs & Conventions

The Face Swap System is **config-driven**, meaning all experiment parameters—from model architecture to data splits—are defined in YAML files.

## 📂 Configuration Structure

Configs are located in `configs/face_swap/`.

| Config File | Purpose |
|-------------|---------|
| `baseline.yaml` | Standard training and evaluation setup. |
| `eval.yaml` | Evaluation-only configuration (requires a trained checkpoint). |
| `export.yaml` | Settings for ONNX/TensorRT export and benchmarking. |
| `infer.yaml` | Inference parameters (source/target paths). |
| `ablation_*.yaml` | Variations for ablation studies (e.g., channel pruning). |

## 🏷️ Naming Conventions

- **Experiments**: `<task>-<model>-<data>-<id>` (e.g., `swap-unet-lfw-baseline`)
- **Work Directories**: `work_dirs/<exp-name>-<timestamp>/`
- **Registry Keys**: `pkg.component.name` (e.g., `models.unet`, `datasets.lfw`)

## 📝 Anatomy of a Config

A typical configuration file includes the following sections.

### 1. Dataset (`LFWDataset`)
Defines the data source, split, and preprocessing.

```yaml
dataset:
  type: "registry.datasets.LFWDataset"
  root: "data/lfw/processed"
  manifest: "data/lfw/manifest.json"
  split: "train"
  augmentations:
    - type: "registry.augmentations.LightAugmentation"
      params: { p: 0.5 }
```

### 2. Model (`UNetFaceSwap`)
Specifies the model architecture and hyperparameters.

```yaml
model:
  type: "registry.models.UNetFaceSwap"
  params:
    channels: 64
    num_layers: 4
    norm_type: "batch"
```

### 3. Loss (`FaceSwapLoss`)
Defines the objective function, combining identity and reconstruction terms.

```yaml
loss:
  type: "registry.models.losses.FaceSwapLoss"
  weights:
    identity_weight: 1.0   # ArcFace distance
    recon_weight: 1.0      # L1 Reconstruction
    adv_weight: 0.1        # Adversarial (optional)
```

### 4. Runner
Controls the training loop (epochs, optimization).

```yaml
runner:
  type: "registry.runners.BaseRunner"
  epochs: 100
  optimizer: 
    type: "Adam"
    lr: 0.001
  scheduler:
    type: "StepLR"
    step_size: 30
```

## 🔁 Reproducibility

To ensure reproducible results:
- **Seeds**: Always set a `seed` in your config.
- **Artifacts**: Every run saves a copy of `config.yaml` and `config.py` in its `work_dir`.
- **Manifests**: Data splits are deterministic based on the manifest version.

## ➕ Adding New Configs

1. Create a new file in `configs/face_swap/`.
2. Reference components using their **registry keys** (avoid absolute paths).
3. Include all required fields (no hidden defaults).
4. Use `configs/face_swap/baseline.yaml` as a template.
