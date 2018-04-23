require 'rubygems'
require 'bundler/setup' # Releasy requires require that your application uses bundler.
require 'releasy'

Releasy::Project.new do
	name "Cookie Tower Defense"
	version "1.0.0"
	verbose # Can be removed if you don't want to see all build messages.

	executable "bin/run.rb"
	files ["app/**/*.rb", "fonts/**/*.*", "maps/**/*.*", "samples/**/*.*", "sprites/**/*.*"]
	exposed_files ["README.md"]
	add_link "https://ldjam.com/events/ludum-dare/41/$81969", "Ludum Dare Entry"
	exclude_encoding # Applications that don't use advanced encoding (e.g. Japanese characters) can save build size with this.

	# If unable to build on a Windows machine, :windows_wrapped is the only choice.
	add_build :windows_wrapped do
    wrapper "wrappers/ruby-1.9.3-p551-i386-mingw32.7z" # Assuming this is where you downloaded this file.
		executable_type :windows # Assuming you don't want it to run with a console window.
		exclude_tcl_tk # Assuming application doesn't use Tcl/Tk, then it can save a lot of size by using this.
		add_package :zip
	end
end
