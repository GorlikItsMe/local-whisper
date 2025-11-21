# Local Whisper Docker API

Run OpenAI's Whisper speech-to-text model locally in a Docker container, with a simple Python API for file uploads and transcription.

---

## Features

- **No API keys required** – runs entirely on your machine.
- **Transcribe large files** – not limited by OpenAI's 25MB API restriction.
- **Simple HTTP API** – upload audio/video files and get JSON transcriptions.
- **No extra Python dependencies** – uses only Python standard library and Whisper CLI.

---

## Quick Start

### 1. Clone the repository

```sh
git clone https://github.com/jaypetersdotdev/local-whisper.git
cd local-whisper
```

### 2. Build the Docker image

```sh
docker compose build
```

### 3. Run the Docker container

```sh
docker compose up -d
```

- The API will be available at [http://localhost:5001/transcribe](http://localhost:5001/transcribe)

---

## Usage

### Transcribe an audio or video file

Send a POST request with your file as form-data (field name: `file`):

#### Using `curl`:

```sh
curl -F "file=@your-audio-file.mp3" http://localhost:5001/transcribe
```

#### Using n8n

- Use the "HTTP Request" node
- Method: `POST`
- URL: `http://localhost:5001/transcribe`
- Request Format: `Form-Data`
- Field Name: `file`
- Type: `File`
- Value: (reference to your binary file, e.g. `{{$binary.data}}`)

#### Response

You will receive a JSON object with the transcription and segment timings.

---

## Requirements

- Docker
- (No OpenAI API key required)
- Sufficient CPU and RAM for Whisper (large files/models require more resources)

---

## Notes

- This API is for local or trusted use only. The multipart parser is minimal and not hardened for public internet exposure.
- The default model is `small`. You can change this in `docker-compose.yml` using `MODEL` environment variable if you want to use a different Whisper model.
- The default language is `en`. You can change this in `docker-compose.yml` using `LANGUAGE` environment variable if you want to use a different language.

---

## Community & Support

- **YouTube channel:** [Jay Peters - @jaypetersdotdev](https://www.youtube.com/@jaypetersdotdev)
- **FREE workflows and resources:** [Learn Automation & AI](https://www.skool.com/learn-automation-ai/about?ref=1c7ba6137dfc45878406f6f6fcf2c316)

---

## License

MIT (or your preferred license)

---

## Contributing

Pull requests and issues welcome!
