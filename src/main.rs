// src/main.rs

// Import the library crate.
use libcityx;

// Import additional modules from the standard library
use std::io;

fn main() {
    println!("Welcome to the cityx executable!");
    libcityx::greet();

    // Add user interaction
    println!("Enter your favorite city:");
    let mut input = String::new();
    io::stdin().read_line(&mut input).expect("Failed to read line");
    let city = input.trim();

    // Use a function from libcityx (assuming it exists)
    if let Some(population) = libcityx::get_city_population(city) {
        println!("The population of {} is approximately {}.", city, population);
    } else {
        println!("Sorry, we don't have information about {}.", city);
    }

    // Display a farewell message
    println!("Thank you for using cityx!");
}
