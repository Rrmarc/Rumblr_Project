class CreatePosts < ActiveRecord:: Migration[5.0]
    def up
        create_table :posts do |t|
        ;
          t.string :title
          t.string :user_id
          t.string :name
          t.timestamp :post_date
        end
      end

      def down
        drop_table :posts
      end
end