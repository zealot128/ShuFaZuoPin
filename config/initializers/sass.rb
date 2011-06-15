
Sass::Engine::DEFAULT_OPTIONS[:load_paths].tap do |load_paths|
  load_paths << "#{Rails.root}/app/assets/stylesheets"
  load_paths << "#{Gem.loaded_specs['compass'].full_gem_path}/frameworks/compass/stylesheets"
  load_paths << "#{Gem.loaded_specs['fancy-buttons'].full_gem_path}/lib/stylesheets"
  load_paths << "#{Gem.loaded_specs['atk_icons'].full_gem_path}/stylesheets"
end
