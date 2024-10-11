// src/lib.rs
//! Library crate for the cityx project.
//!
//! CityX is a framework for building and simulating urban environments.
//! It provides a modular architecture with backend, renderer, and core components
//! to facilitate the creation of complex city simulations.
//!
//! # Main components
//!
//! - `Backend`: Handles low-level operations and system interactions.
//! - `Renderer`: Manages the visual representation of the city.
//! - `Core`: Implements the main simulation logic and city dynamics.
//!
//! # Usage
//!
//! To use CityX, create an instance of the `CityX` struct, initialize it,
//! and then run the main loop:
//!
//! 
//! use cityx::CityX;
//!
//! fn main() -> Result<(), Box<dyn std::error::Error>> {
//!     let mut city = CityX::new()?;
//!     city.init()?;
//!     city.run()?;
//!     Ok(())
//! }
//! 
use std::error::Error;

mod backend;
mod renderer;
mod core;

pub use backend::Backend;
pub use renderer::Renderer;
pub use core::Core;

/// The main CityX struct that holds all components
pub struct CityX {
    backend: Backend,
    renderer: Renderer,
    core: Core,
}

impl CityX {
    /// Create a new instance of CityX
    pub fn new() -> Result<Self, Box<dyn Error>> {
        Ok(Self {
            backend: Backend::new()?,
            renderer: Renderer::new()?,
            core: Core::new()?,
        })
    }

    /// Initialize the CityX framework
    pub fn init(&mut self) -> Result<(), Box<dyn Error>> {
        self.backend.init()?;
        self.renderer.init()?;
        self.core.init()?;
        Ok(())
    }

    /// Run the main loop of CityX
    pub fn run(&mut self) -> Result<(), Box<dyn Error>> {
        loop {
            self.backend.update()?;
            self.renderer.update()?;
            self.core.update()?;

            if self.should_exit() {
                break;
            }
        }
        Ok(())
    }

    /// Check if the application should exit
    fn should_exit(&self) -> bool {
        // Implement exit condition
        false
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_cityx_creation() {
        let cityx = CityX::new();
        assert!(cityx.is_ok());
    }
}
pub fn greet() {
    println!("Greetings from the cityx library!");
}
