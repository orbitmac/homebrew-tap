cask "orbit" do
  version "1.1.2"
  sha256 "afbd288c67b2e0e2d7e8cd0febcdf74864219fa1d3be046e139045a2db625d77"

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
