guard :rspec, cmd: "bundle exec rspec" do
  # Watch les fichiers de tests et les modèles
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^app/(.*)\.rb$}) { |m| "spec/#{m[1]}_spec.rb" }

  # Watch les fichiers de migrations
  watch(%r{^db/migrate/.+\.rb$}) { "spec/models" }

  # Relancer les tests de configuration si les fichiers changent
  watch("config/routes.rb") { "spec/routing" }
  watch("config/application.rb") { "spec" }
end
