use std::fs;
use toml_edit::Document;
//#Wczytaj konfigurację z citix.toml w kodzie Rust: Użyj biblioteki takiej jak toml_edit lub serde_toml, aby wczytać konfigurację z citix.toml w swoim kodzie Rust (np. w pliku main.rs backendu).
fn main() {
    // Wczytaj zawartość pliku citix.toml
    let config_content = fs::read_to_string("citix.toml").expect("Nie udało się wczytać pliku konfiguracyjnego");

    // Parsuj plik TOML
    let config: Document = config_content.parse().expect("Nieprawidłowy format pliku konfiguracyjnego");

    // Odczytaj wartości konfiguracji
    let server_address = config["server"]["address"].as_str().unwrap_or("127.0.0.1");
    let server_port = config["server"]["port"].as_integer().unwrap_or(8080);

    // ... dalsza część kodu
}
