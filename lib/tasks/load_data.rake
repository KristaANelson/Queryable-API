namespace :load_data  do
  desc "load data"
  task :insert_providers, [:file] => [:environment] do |t, args|
    file = args[:file]
    if file
      starting_count = Provider.count
      puts "Starting load..."
      DataLoader.new(file).insert_providers
      total_count = Provider.count
      puts "Load complete: #{total_count - starting_count} Providers added"
    else
      puts "please specify a file"
    end
  end
end
