# Bad Apple

A desktop background video overlay that renders Bad Apple (or any configured video) using a silhouette shader on the Caelestia desktop surface.

Extracted from the built-in module in [ladybug-me/caelestia-kde](https://github.com/ladybug-me/caelestia-kde) into a standalone community plugin.

## Requirements

- Caelestia shell 2.3 or newer.
- QtMultimedia with gstreamer/ffmpeg backend for video playback.

## Configuration

In the Nexus Plugins page, open the settings for Bad Apple:

- **Media asset path** (`mediaPath`): Path to the video file or URL. Defaults to the bundled `badapple.mp4`. Supports `~/...` home paths, absolute paths `/...`, full URLs `file://...` or `https://...`, and plugin-relative filenames.
- **Play overlay** (`playing`): Toggle playback on/off dynamically. When paused, video decode and shader execution are completely unloaded to preserve CPU/GPU resources.
- **Enable audio** (`audioEnabled`): Toggle audio playback on or off. Audio automatically plays only on the primary screen in multi-monitor setups.
