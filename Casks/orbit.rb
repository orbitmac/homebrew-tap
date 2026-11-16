cask "orbit" do
  version "1.1.1"
  sha256 "132aa8c8d56bba66d93faf4bfd753ca7f546fff08122b5064fce8ecf5df72def"

  url "https://orbitmac.com/downloads/Orbit-#{version}.dmg"
  name "Orbit"
  desc "Menu bar toolkit: window switcher, clipboard history, screen capture and system monitor"
  homepage "https://orbitmac.com"

  auto_updates true
  depends_on macos: :sonoma

  app "Orbit.app"

  zap trash: [
    "~/Library/Application Support/Orbit",
    "~/Library/Preferences/com.facudelima.Orbit.plist",
  ]
end
