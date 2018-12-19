class CreateUsers > ActiveRecord:: Migration[5.0]
    def up
        create_table :user do |t|
            
          t.string :email
          t.string :password
        end
      end
    
      def down
        drop_table :user
      end
end