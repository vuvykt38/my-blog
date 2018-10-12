namespace :data do
  desc "Add first initial categories, skip if added"
  task add_initial_categories: :environment do
    puts 'Adding 3 categories'
    Category.find_or_create_by(name: 'Food')
    Category.find_or_create_by(name: 'Travel')
    Category.find_or_create_by(name: 'Life')
    puts 'Done!'
  end
end
