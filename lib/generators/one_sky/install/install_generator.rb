require 'i18n-one_sky'

module OneSky
  module Generators
    class InstallGenerator < Rails::Generators::Base
      include Rails::Generators::Migration
      
      desc "This generator generates Rails files(initializer and database migration) to use Onesky service"
      
      source_root File.expand_path("../templates", __FILE__)
      
      def install_onesky_active_record
        generate_initializers
        generate_db_migration
      end
      
      def self.next_migration_number(dirname)
        if ActiveRecord::Base.timestamped_migrations
          Time.now.utc.strftime("%Y%m%d%H%M%S")
        else
          "%.3d" % (current_migration_number(dirname) + 1)
        end
      end
      
      protected

      def generate_initializers
        copy_file "onesky.rb", "config/initializers/onesky.rb"
      end
      
      def generate_db_migration
        migration_template 'migration.rb', 'db/migrate/create_translations_table.rb'        
        rake("db:migrate")
      end
    end
  end
end
