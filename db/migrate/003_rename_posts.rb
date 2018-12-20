class RenamePosts < ActiveRecord:: Migration[5.0]
    def change
        rename_column :posts, :name, :post

    end    
end


