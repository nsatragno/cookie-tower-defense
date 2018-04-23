require 'rubygems'
require 'bundler/setup' # Releasy requires require that your application uses bundler.
require 'releasy'

Releasy::Project.new do
  name "Cookie Tower Defense"
  version "1.0.0"
  verbose # Can be removed if you don't want to see all build messages.

  executable "bin/run.rb"
  files ["app/**/*.rb", "fonts/**/*.*", "maps/**/*.*", "samples/**/*.*", "music/**/*.*", "sprites/**/*.*"]
  exposed_files ["README.md"]
  add_link "https://ldjam.com/events/ludum-dare/41/$81969", "Ludum Dare Entry"
  exclude_encoding # Applications that don't use advanced encoding (e.g. Japanese characters) can save build size with this.

  # If building on a Windows machine, :windows_folder and/or :windows_installer are recommended.
  add_build :windows_folder do
    #icon "media/icon.ico"
    executable_type :windows # Assuming you don't want it to run with a console window.
    add_package :exe # Windows self-extracting archive.
  end
end
