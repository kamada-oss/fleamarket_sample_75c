class Category < ApplicationRecord
  has_many :items
  has_ancestry

  def set_items

    if self.root?
      category_id = self.root.id
      category_ids = self.root.id
      items = Item.where(category_id: indirect_ids)

      return items

    elsif self.has_children?
      category_id = self.children.first.id
      category_ids = self.children.last.id
      items = Item.where(category_id: child_ids)
      return items
      
    else
      return self.items
    end
# # 必要 残す理由 ピックアップブランドとカテゴリーからリンクをできるようにするため
  end
end
