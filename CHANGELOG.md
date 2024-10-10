# Changelog

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Added
- LoggerModule for error logging
- TileManagerModule for handling tile model loading and replacement
- Integration with Matter ECS (matter-ecs/matter@0.8.3) for game logic
- Roact integration (roblox/roact@1.4.0) for UI components
- Base64 encoding/decoding support (reselim/base64@3.0.0)
- Signal and event handling (sleitnick/signal@2.0.1)
- Resource management with Trove (sleitnick/trove@1.3.0)
- Promise handling (evaera/promise@4.0.0)
- Backend server setup with actix-web
- Discord integration with serenity
- Asynchronous runtime with tokio
- Configuration management with config and serde_yaml
- UUID generation support
- HTTP client functionality with reqwest

### Changed
- Integrated LoggerModule with TileManagerModule for improved error handling
- Enhanced tile management system with new TileManagerModule functionality
- Updated project structure to include cityx-backend, cityx-client, and cityx-renderer
- Implemented shared dependencies across workspace members

### Improved
- Overall application stability and performance with the addition of LoggerModule
- Tile model management efficiency through TileManagerModule implementation
- Error handling with thiserror and anyhow
- Build optimization for release profile with LTO and reduced codegen units

## [0.1.0] - 2023-10-26
### Added
- Initial project setup
- Main logic
- Game logic implementation
- Ether logic implementation
- Module Loader implementation
- Tile Module implementation
- Player Module implementation
- Chunk management module implementation
- Basic server configuration (address: 127.0.0.1, port: 8080)
- Game settings including graphics, audio, network, and controls configurations
- Test place setup for CityX

### Changed
- Improved Player Module based on Tile Module pattern and best practices
- Integrated Logger module into Player Module for error handling

### Deprecated

### Removed

### Fixed

### Security
- Implemented private package setting for increased security