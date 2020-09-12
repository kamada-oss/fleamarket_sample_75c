crumb :root do
  link "トップページ", root_path
end

crumb :item do |item|
  link item.name, item_path(item)
  parent :root
end

# マイページ
crumb :good_index do |user|
  link "マイページ", good_index_mypage_path(user)
  parent :root
end

crumb :item_exhibiting do |user|
  link "出品した商品-出品中", item_exhibiting_mypage_path(user)
  parent :good_index, user
end

crumb :item_sold do |user|
  link "出品した商品-売却済み", item_sold_mypage_path(user)
  parent :good_index, user
end

crumb :item_purchased do |user|
  link "購入した商品", item_purchased_mypage_path(user)
  parent :good_index, user
end

crumb :edit_profile do |user|
  link "プロフィール", edit_profile_mypage_path(user)
  parent :good_index, user
end

crumb :edit_address do |user|
  link "発送元・お届け先住所変更", edit_address_mypage_path(user)
  parent :good_index, user
end

crumb :edit_address do |user|
  link "発送元・お届け先住所変更", edit_address_mypage_path(user)
  parent :good_index, user
end

crumb :edit_payment do |user|
  link "支払い方法", edit_payment_mypage_path(user)
  parent :good_index, user
end

crumb :edit_email_password do |user|
  link "メール/パスワード", edit_email_password_mypage_path(user)
  parent :good_index, user
end

crumb :logout do |user|
  link "ログアウト", logout_mypage_path(user)
  parent :good_index, user
end