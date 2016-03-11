namespace :db do
  desc "Creating default roles"
  task :seed => :environment do
    Role.create name: "Developer"
  end
end
