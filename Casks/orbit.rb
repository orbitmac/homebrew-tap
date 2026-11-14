cask "orbit" do
  version "1.1.1"
  sha256 "1fb46b2f74d6ad2f4229ab6facf0ad6bbf79cc36b6428da105e27224c0e3510c"

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
