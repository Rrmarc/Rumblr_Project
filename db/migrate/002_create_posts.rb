class CreatePosts < ActiveRecord::Migration
    def up
        create_table :posts do |t|

          t.integer :user_id
          t.string :name
          t.timestamp :post_date
          t.string :image

        end
      end

      def down
        drop_table :posts
      end
end