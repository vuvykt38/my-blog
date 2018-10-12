class RunTaskToAddInitialCategories < ActiveRecord::Migration[5.2]
  def up
    Rake::Task['data:add_initial_categories'].invoke
  end
end
