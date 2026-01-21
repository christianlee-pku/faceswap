# 📡 Streaming & REST API

The system provides real-time capabilities via a streaming pipeline and a REST API.

## 🌐 REST API

The API is built with **FastAPI** and supports batch processing, training control, and streaming.

### Start the Server

```bash
uvicorn src.interfaces.rest:app --host 0.0.0.0 --port 8000
```

### Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `POST` | `/face-swap/batch` | Process a batch of images. |
| `POST` | `/face-swap/stream` | Real-time stream processing. |
| `GET` | `/reports/{run_id}` | Retrieve metrics and graphs for a run. |
| `POST` | `/face-swap/train` | Trigger a training run. |

## 🌊 Streaming Pipeline

The streaming pipeline (`src/pipelines/streaming.py`) is optimized for low-latency processing.

### Usage Example

```bash
curl -X POST http://localhost:8000/face-swap/stream \
  -H "Content-Type: application/json" \
  -d '{
    "config": "configs/face_swap/baseline.yaml", 
    "frames": ["path/to/frame1.jpg", "path/to/frame2.jpg"]
  }'
```

### Features
- **Latency Tracking**: Logs per-frame processing time.
- **FPS Monitoring**: Real-time throughput calculation.
- **Temporal Smoothing**: (Planned) Reduces jitter between frames.

## 🚧 Development Status

- **Current**: Functional prototype with frame counting and latency logging.
- **Planned**:
  - Real-time video protocol (RTSP/WebRTC) support.
  - Hardware-accelerated decoding/encoding.
  - Output URL generation for processed streams.