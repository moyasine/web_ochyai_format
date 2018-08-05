class CreateTempletes < ActiveRecord::Migration[5.1]
  def change
    create_table :templetes do |t|
      t.text :title
      t.text :author
      t.text :what_thing
      t.text :where_good
      t.text :where_kimo
      t.text :how_effective
      t.text :what_discussion
      t.text :what_next

      t.timestamps
    end
  end
end
